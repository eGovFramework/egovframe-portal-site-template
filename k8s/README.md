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

## 2. 매니페스트 배포

```bash
kubectl apply -f k8s/
```

명령 한 번으로 `deployment.yaml`과 `service.yaml`이 함께 적용됩니다.

---

## 3. 접속

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

## 4. 상태 확인

```bash
# Pod 목록 및 상태
kubectl get pods -l app.kubernetes.io/name=egov-portal-site

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

## 5. 배포 제거

```bash
kubectl delete -f k8s/
```
