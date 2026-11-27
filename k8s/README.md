# egovframe-portal-site-template — 컨테이너/쿠버네티스 운영 안내

## 사전 요구 사항

| 도구 | 최소 버전 | 용도 |
|------|-----------|------|
| Docker | 24 이상 | 이미지 빌드 및 Compose 실행 |
| kubectl | 1.27 이상 | 쿠버네티스 배포 |
| (선택) minikube / Docker Desktop / kind | — | 로컬 클러스터 |

| 항목 | 값 |
|------|----|
| 리소스명(Deployment/Service/이미지) | `egovframe-portal-site-template` |
| MySQL 리소스명 (선택 구성) | `egovframe-portal-site-template-mysql` |
| 컨텍스트 경로 | `/` (ROOT) |
| 컨테이너 포트 | `8080` |
| NodePort | `30080` |

| 파일 | 내용 |
|------|------|
| `deployment.yml`, `service.yml` | 애플리케이션 (기본 내장 HSQLDB) |
| `secret.yml` | 첨부파일 ID 암호화 키 (`GLOBALS_FILE_ALGORITHMKEY`) |
| `mysql/` | MySQL 8.4 (Secret · 초기화 SQL ConfigMap · PVC · Deployment · Service), 앱 DB 접속 Secret |

---

## 1. 이미지 빌드

```bash
# 프로젝트 루트에서 실행
docker build -t egovframe-portal-site-template:5.1.0 .
```

멀티 스테이지 빌드로 Maven WAR 빌드 → 실행 이미지(Tomcat 10.1 / JRE 17)를 순서대로 생성합니다.  
빌드 캐시(`/root/.m2`)를 활용하려면 BuildKit을 활성화(`DOCKER_BUILDKIT=1`)하세요.

---

## 2. Docker Compose로 로컬 실행

```bash
# 실행 (내장 HSQLDB)
docker compose up -d --build

# 실행 (MySQL 연동)
docker compose -f docker-compose.yml -f docker-compose.mysql.yml up -d --build

# 로그 확인
docker compose logs -f

# 중지 및 컨테이너 삭제 (MySQL 구성은 -f 옵션 동일하게 지정, 볼륨까지 삭제 시 -v)
docker compose down
```

접속: http://localhost:8080/

| 환경 변수 | 기본값 | 설명 |
|-----------|--------|------|
| `APP_VERSION` | `5.1.0` | 빌드/실행할 이미지 태그 |
| `JAVA_OPTS` | `-Xms256m -Xmx512m -XX:+ExitOnOutOfMemoryError` | JVM 옵션 |
| `GLOBALS_FILE_ALGORITHMKEY` | `change-this-file-key` | 첨부파일 ID 암호화 키 |
| `DB_PASSWORD` | `pst01` | MySQL `pst` 계정 비밀번호 (MySQL 구성) |
| `MYSQL_ROOT_PASSWORD` | `root1234` | MySQL root 비밀번호 (MySQL 구성) |
| `MYSQL_PORT` | `3306` | MySQL 호스트 노출 포트 (MySQL 구성, 사용 중이면 변경) |

헬스 확인:
```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/
```

---

## 3. 쿠버네티스 배포

### 3-1. 이미지 준비

`k8s/deployment.yml`의 `image` 값을 실제 레지스트리 경로로 변경합니다.

```yaml
# 예시
image: ghcr.io/<org>/egovframe-portal-site-template:5.1.0
```

로컬 클러스터는 환경에 따라 이미지를 적재합니다.

| 환경 | 이미지 적재 |
|------|-------------|
| minikube | `minikube image load egovframe-portal-site-template:5.1.0` |
| kind | `kind load docker-image egovframe-portal-site-template:5.1.0` |
| Docker Desktop | 별도 적재 불필요 (로컬 Docker 이미지 그대로 사용) |

> **참고**
> - 기본 구성은 내장 HSQLDB(인메모리)를 사용하므로 Pod 재시작 시 데이터가 초기화되고, Pod 간 데이터가 공유되지 않습니다. 외부 DB 연동 전까지 `replicas: 1`을 유지하세요.
> - 컨테이너는 root 가 아닌 계정(UID/GID 1000)으로 실행됩니다 (Dockerfile `USER`, deployment.yml `securityContext`).
> - 첨부파일 볼륨(`upload`)은 `emptyDir` 이므로 Pod 재생성 시 유실됩니다. 운영은 PVC(레플리카 2개 이상이면 `ReadWriteMany`)로 교체하세요.

### 3-2. 매니페스트 적용 (기본 : 내장 HSQLDB)

```bash
kubectl apply -f k8s/
```

### 3-3. MySQL 연동 (선택)

`k8s/mysql/` 을 적용하면 MySQL 이 배포되고, 앱이 `envFrom`(optional)으로 참조하는 DB 접속 Secret(`egovframe-portal-site-template-db`)이 생성됩니다.  
MySQL 은 최초 기동(빈 PVC) 시 `initdb-configmap.yml` 의 DDL·데이터를 자동 적재합니다.

```bash
kubectl apply -f k8s/mysql/
kubectl rollout status deployment/egovframe-portal-site-template-mysql

# 앱이 이미 실행 중이면 재시작하여 DB 접속정보 반영
kubectl rollout restart deployment/egovframe-portal-site-template
```

> - 앱을 MySQL 보다 먼저 기동하면 DB 연결 실패로 liveness 프로브에 의해 1~2회 재시작된 뒤 정상화됩니다. MySQL 을 먼저 적용하는 것을 권장합니다.
> - `mysql/secret.yml` 의 비밀번호는 예시 값입니다. 운영에서는 SealedSecrets, External Secrets Operator 등으로 교체하세요.
> - 외부(관리형) MySQL 을 사용하면 `mysql/secret.yml` 의 `egovframe-portal-site-template-db` Secret 의 `GLOBALS_URL`·`GLOBALS_USERNAME`·`GLOBALS_PASSWORD` 만 접속정보에 맞게 수정하여 적용합니다 (이미지 재빌드 불필요). PostgreSQL 은 `GLOBALS_DBTYPE: postgres`, `GLOBALS_URL: jdbc:log4jdbc:postgresql://<host>:5432/pst`.

`DATABASE/mysql/*.sql` 을 변경했다면 초기화 SQL ConfigMap 을 재생성합니다.

```bash
kubectl create configmap egovframe-portal-site-template-mysql-initdb \
  --from-file=01-ddl.sql=DATABASE/mysql/all_pst_ddl_mysql.sql \
  --from-file=02-data.sql=DATABASE/mysql/all_pst_data_mysql.sql \
  --dry-run=client -o yaml \
  | kubectl label --local -f - app.kubernetes.io/name=egovframe-portal-site-template-mysql \
      app.kubernetes.io/part-of=egovframe-template -o yaml > k8s/mysql/initdb-configmap.yml
```

### 3-4. 배포 상태 확인

```bash
# Pod 상태
kubectl get pods -l app.kubernetes.io/part-of=egovframe-template

# Deployment 롤아웃 완료 대기
kubectl rollout status deployment/egovframe-portal-site-template

# 적용된 DB 확인 (비어 있으면 globals.properties 기본값 hsql)
kubectl exec deployment/egovframe-portal-site-template -- printenv GLOBALS_DBTYPE
```

---

## 4. 접속

### NodePort (service.yml 기준)

service.yml은 `type: NodePort`, `nodePort: 30080`로 설정되어 있습니다.  
클러스터 내부에서는 `egovframe-portal-site-template:8080`으로 접근할 수 있습니다.

| 환경 | 접속 URL |
|------|----------|
| minikube | `http://<minikube INTERNAL-IP>:30080/` (`kubectl get nodes -o wide` 로 INTERNAL-IP 확인) |
| Docker Desktop / kind | `http://localhost:30080/` |

> Apple Silicon Mac 에서 minikube + docker driver 를 사용하면 NodePort 로 연결되지 않을 수 있습니다.
> 이 경우 `minikube service egovframe-portal-site-template` 으로 로컬 터널을 구성하거나 아래 포트 포워딩을 사용합니다.
> 같은 클러스터에 30080 을 쓰는 다른 서비스가 있으면 `nodePort` 를 변경합니다.

### 포트 포워딩 (개발/테스트 용)

```bash
kubectl port-forward service/egovframe-portal-site-template 8080:8080
```

접속: http://localhost:8080/

---

## 5. 헬스체크 확인

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/
```

정상 응답 예시:
HTTP 302 응답(메인 화면으로 리다이렉트)

k8s Probe 설정 요약:

| Probe | 경로 | initialDelaySeconds | periodSeconds |
|-------|------|---------------------|---------------|
| readiness | / | 30 | 10 |
| liveness | / | 90 | 20 |

Pod가 `Running` 상태이고 `READY` 열이 `1/1`이면 정상입니다.

---

## 6. 삭제

```bash
kubectl delete -f k8s/mysql/   # MySQL 구성 사용 시 (PVC 포함, 데이터 삭제)
kubectl delete -f k8s/
```

> 이전 버전 매니페스트(리소스명 `egov-portal-site`, `mysql`, `mysql-db`)로 배포한 리소스는 이름이 다르므로 함께 정리되지 않습니다.
> `kubectl delete deployment,service egov-portal-site mysql mysql-db --ignore-not-found` 및 `kubectl delete secret,configmap,pvc mysql-secret egov-portal-site-secret mysql-config mysql-initdb mysql-pvc --ignore-not-found` 로 삭제한 뒤 다시 적용합니다.
