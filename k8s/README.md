# Kubernetes 배포 가이드

egovframe-portal-site-template 을 Kubernetes 클러스터에 배포하는 절차입니다.

## 사전 조건

- Docker 및 `kubectl` 설치
- Kubernetes 클러스터 접근 권한 (`~/.kube/config` 설정 완료)
- Maven 3.9+, JDK 17+ (로컬 빌드 시)

---

## 1. 이미지 빌드

프로젝트 루트에서 Docker 이미지를 빌드합니다. 내부적으로 Maven 빌드 → WAR 패키징 → Tomcat 10.1 이미지 생성의 두 단계(multi-stage)로 진행됩니다.

```bash
# 프로젝트 루트에서 실행
docker build -t egovframe-portal-site-template:5.0.0 .
```

이미지를 사설 레지스트리에 올릴 경우:

```bash
docker tag egovframe-portal-site-template:5.0.0 ghcr.io/<org>/egov-portal-site:5.0.0
docker push ghcr.io/<org>/egov-portal-site:5.0.0
```

레지스트리를 사용한다면 `k8s/deployment.yaml`의 `image` 필드를 해당 주소로 수정하십시오.

---

## 2. 데이터베이스 설정

본 애플리케이션은 **MySQL 데이터베이스가 필수**입니다. 두 가지 방식 중 택일합니다.

### 방법 A: 클러스터 내 MySQL 직접 배포 (개발/테스트용)

k8s 디렉터리에 포함된 매니페스트를 사용하여 MySQL을 클러스터 내에 배포합니다.

#### 2-1. DDL/DML ConfigMap 생성

`DATABASE/mysql/` 아래의 SQL 파일을 ConfigMap으로 생성합니다. MySQL 최초 기동 시 `/docker-entrypoint-initdb.d/` 에 마운트되어 자동 실행됩니다.

```bash
# 프로젝트 루트에서 실행
kubectl create configmap mysql-initdb \
  --from-file=01-ddl.sql=DATABASE/mysql/all_pst_ddl_mysql.sql \
  --from-file=02-data.sql=DATABASE/mysql/all_pst_data_mysql.sql
```

> **참고**: SQL 파일 크기 합계가 1 MiB를 초과하면 ConfigMap 한도에 걸릴 수 있습니다.
> 이 경우 initContainer에서 git clone으로 SQL 파일을 가져오거나, PV에 직접 복사하는 방식을 사용하십시오.

#### 2-2. MySQL 리소스 배포

```bash
kubectl apply -f k8s/mysql-secret.yaml
kubectl apply -f k8s/mysql-configmap.yaml
kubectl apply -f k8s/mysql-pvc.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/mysql-service.yaml
```

MySQL Pod가 Ready 상태가 될 때까지 대기합니다:

```bash
kubectl rollout status deployment/mysql
```

> **주의**: `mysql-secret.yaml`에 기본 패스워드가 포함되어 있습니다.
> 운영 환경에서는 반드시 SealedSecrets, External Secrets Operator 등으로 교체하십시오.

### 방법 B: 외부 MySQL 사용 (운영 환경 권장)

기존 MySQL 서버 또는 AWS RDS, Cloud SQL 등 관리형 서비스를 사용합니다.

1. 외부 DB에 `pst` 데이터베이스와 사용자를 생성합니다.
2. DDL/DML을 수동으로 적용합니다:
   ```bash
   mysql -h <DB_HOST> -u <USER> -p pst < DATABASE/mysql/all_pst_ddl_mysql.sql
   mysql -h <DB_HOST> -u <USER> -p pst < DATABASE/mysql/all_pst_data_mysql.sql
   ```
3. `k8s/deployment.yaml`의 앱 컨테이너에서 `DB_HOST` 환경변수를 외부 DB 주소로 변경합니다.
4. MySQL 관련 k8s 매니페스트(`mysql-*.yaml`)는 배포하지 않습니다.

---

## 3. globals.properties 설정

본 애플리케이션은 Tomcat WAR 배포 방식으로, Spring Boot의 환경변수 자동 바인딩이 동작하지 않습니다.

컨테이너 이미지에 포함된 `docker-entrypoint.sh`가 기동 시 환경변수(`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD`)를 읽어 `globals.properties`의 JDBC URL, 사용자명, 패스워드를 자동으로 치환합니다.

`k8s/deployment.yaml`에 이미 해당 환경변수가 설정되어 있으므로, 별도 수정 없이 동작합니다.

> **커스텀 빌드 시**: 환경변수를 사용하지 않고 직접 `globals.properties`를 수정하여 WAR를 재빌드할 수도 있습니다.
>
> ```bash
> # src/main/resources/egovframework/egovProps/globals.properties 수정 후
> mvn -B -DskipTests package
> docker build -t egovframe-portal-site-template:5.0.0 .
> ```

---

## 4. 매니페스트 배포

```bash
kubectl apply -f k8s/
```

명령 한 번으로 모든 매니페스트가 함께 적용됩니다.

앱의 initContainer가 MySQL 서비스(mysql-db:3306)에 연결 가능할 때까지 대기한 후 메인 컨테이너가 기동됩니다.

---

## 5. 접속

### 서비스 타입: ClusterIP (기본)

`service.yaml`의 서비스 타입은 `ClusterIP`이므로 클러스터 외부에서 직접 접근할 수 없습니다.
로컬 개발 시에는 `kubectl port-forward`로 접속합니다.

```bash
kubectl port-forward svc/egov-portal-site 8080:8080
```

브라우저에서 `http://localhost:8080` 으로 접속합니다.

### minikube 환경

```bash
minikube service egov-portal-site
```

minikube가 NodePort를 자동 할당하고 브라우저를 엽니다. (서비스 타입을 `NodePort`로 변경하면 포트 번호가 고정됩니다.)

### 외부 공개가 필요한 경우

`service.yaml`의 `type`을 `LoadBalancer`로 변경하거나 별도 Ingress 리소스를 추가하십시오.

---

## 6. 상태 확인

```bash
# Pod 목록 및 상태
kubectl get pods -l app.kubernetes.io/part-of=egovframe-template

# Deployment 롤아웃 완료 대기
kubectl rollout status deployment/egov-portal-site

# Pod 로그 확인
kubectl logs -l app.kubernetes.io/name=egov-portal-site --tail=100
```

### 헬스 프로브

| 프로브 | 경로 | 포트 | initialDelay | period |
|--------|------|------|--------------|--------|
| Readiness | `/` | 8080 | 30 s | 10 s |
| Liveness  | `/` | 8080 | 90 s | 20 s |

Tomcat이 ROOT 컨텍스트(`/`)를 정상적으로 서비스하면 HTTP 200을 반환하므로 별도 Actuator 경로 없이 동작합니다.

---

## 7. 배포 제거

```bash
kubectl delete -f k8s/
kubectl delete configmap mysql-initdb    # DDL/DML ConfigMap 별도 삭제
kubectl delete pvc mysql-pvc             # 데이터 볼륨 삭제 (주의: 데이터 유실)
```
