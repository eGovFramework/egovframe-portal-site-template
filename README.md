# 표준프레임워크 템플릿 프로젝트 포털 사이트

![java](https://img.shields.io/badge/java-007396?style=for-the-badge&logo=JAVA&logoColor=white)
![javascript](https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![Spring](https://img.shields.io/badge/Spring-F2F4F9?style=for-the-badge&logo=spring)
![jquery](https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white)
![maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)  
![workflow](https://github.com/eGovFramework/egovframe-portal-site-template/actions/workflows/maven.yml/badge.svg)

※ 본 프로젝트는 표준프레임워크에서 제공하는 공통컴포넌트의 기능들 중 일부를 선정하여 기본 구성한 참조용 프로젝트 소스입니다.

## 프로젝트 소개

### 프로젝트 개요

포털 사이트 기능 구현 시 필수적인 부분만 사용 가능하도록 경량화 된 실행환경 제공  
포털 공지사항 관리 템플릿, 사용자 관리 템플릿, 권한 관리 템플릿, 포털 초기화면 관리 템플릿, 포털 FAQ 관리 템플릿, 포털 행사 참가 관리 템플릿 기능을 제공

### 메뉴 구성

![menu_pst_v4](https://user-images.githubusercontent.com/3771788/229034916-599c933a-b77d-4685-aabd-29768ac8e393.jpg)

## 참고 화면 및 메뉴 설명

### 메인 화면

![ps1](https://user-images.githubusercontent.com/3771788/229034952-814dfeeb-a63a-4363-be64-ea77aa5c2565.jpg)

1. 포털사이트 템플릿은 웹 시스템의 커뮤니케이션 기능을 (게시판, FAQ, QnA, 설문, 사용자 및 권한관리 등)을 위주로 기본 구성한 형태이다.  
   최초 로그인계정 설정은 **[ 로그인계정(관리자) : admin , 로그인암호 : 1 / 로그인계정(사용자) : user1 , 로그인암호 : 1 ]** 로 설정되어 있다.
2. 일반 유저(예:user1 계정)를 가입신청하고 관리자가 권한정보를 부여하는 방식으로 사용할 수 있고 FAQ, QnA 등에 대한 추가 컨텐츠를 등록하여 사용 할 수 있다.
3. 프로그램, 메뉴에 대한 변경기능은 추가구성되어 있지 않으므로 필요시 DB를 통해 직접 변경한다. (내부업무 템플릿의 샘플파일을 참조하여 재구성 후 업로드)
4. 기본 기능이나 예시 메뉴를 실무적으로 추가 커스터마이징하여 활용할 수 있다.

### 사이트소개 화면

![ps2](https://user-images.githubusercontent.com/3771788/229034987-8afeb57d-7f2b-4e83-a7f9-4457e739c851.jpg)

- **해당 화면 및 세부 메뉴 화면은 구성을 위한 샘플페이지가 제공되며 기능은 구현되지 않은 상태입니다.**

1. 세부메뉴 : 사이트 소개, 연혁, 조직소개, 찾아오시는 길
2. 기능설명 : 예시 메뉴에 해당하는 항목으로 샘플 페이지 형태로 존재한다.
3. 활용방법 : 각 샘플 페이지에 대한 콘텐츠를 새로 구성하여 활용할 수 있다.

### 민원광장 화면

![ps3](https://user-images.githubusercontent.com/3771788/229035018-2e842e72-3342-40db-9c19-d2fd4bcd2732.jpg)

- **해당 화면 및 세부 메뉴 화면은 구성을 위한 샘플페이지가 제공되며 기능은 구현되지 않은 상태입니다.**

1. 세부메뉴 : 민원신청, 민원결과확인
2. 기능설명 : 예시 메뉴에 해당하는 항목으로 샘플 페이지 형태로 존재한다.
3. 활용방법 : 각 샘플 페이지에 대한 콘텐츠를 새로 구성하여 활용할 수 있다.

### 알림마당 화면

![ps4](https://user-images.githubusercontent.com/3771788/229035053-ef8d8e17-247c-43f5-a968-3818a7a9fe0c.jpg)

1. 세부메뉴 : 공지사항, 자유게시판
2. 기능설명 : 공통컴포넌트 게시판 기능을 커스터마이징하여 사용한다.
3. 활용방법 : 관리자가 등록한 게시물을 조회할 수 있다.

### 정보마당 화면

![ps5](https://user-images.githubusercontent.com/3771788/229035077-0480a884-eedb-406a-a561-b0dbc367939e.jpg)

1. 세부메뉴 : FAQ, QnA, 설문조사
2. 기능설명 : 공통컴포넌트 FAQ, QnA, 설문 기능을 커스터마이징하여 사용한다.
3. 활용방법 : 관리자가 등록한 게시형 컨텐츠 정보를 조회할 수 있다.

### 포털서비스관리 화면

![ps6](https://user-images.githubusercontent.com/3771788/229035100-995a64af-8f11-422f-8bf1-e3db4c622e45.jpg)

1. 세부메뉴 : 설문관리 (설문지, 설문템플릿, 설문문항, 설문항목, 설문응답결과), 서비스관리 (FAQ관리, QnA관리, 게시판생성관리, 게시판사용관리, 공지사항관리, 자유게시판관리, 배너관리)
2. 기능설명 : 공통컴포넌트 설문 기능, FAQ, QnA, 게시판, 배너관리를 커스터마이징하여 사용한다.
3. 활용방법 : 관리자로 로그인 한 후 게시형 컨텐츠 정보를 등록할 수 있다. (게시판 설정 가능)

### 포털시스템관리 화면

![ps7](https://user-images.githubusercontent.com/3771788/229035121-182e700c-624f-431b-8a95-0bce2241f8e9.jpg)

1. 세부메뉴 : 사용자관리 (회원관리, 이용약관관리, 개인정보보호관리), 사용자권한관리 (권한관리, 사용자그룹관리, 사용자별권한관리, 롤관리)
2. 기능설명 : 공통컴포넌트 사용자관리, 권한관리 (권한, 그룹, 사용자별권한, 롤관리) 기능을 커스터마이징하여 사용한다.
3. 활용방법 : 사용자와 사용자권한정보를 관리할 수 있다.

## 환경 설정 화면

프로젝트에서 사용된 환경 프로그램 정보는 다음과 같다.
| 프로그램 명 | 버전 명 |
| :--------- | :------ |
| java | 1.8 이상 |
| maven | 3.8.4 |

## 프로젝트 실행

1. eclipse 하단의 Servers 탭을 클릭하고, 마우스 우클릭하여 **New > Server** 를 선택하여 서버를 설치한다.

2. 생성 또는 복사된 소스 내부의 DATABASE 폴더 내 dml, ddl을 참고하여 연결하고자 하는 DB에 테이블 생성 및 기초 데이터를 생성한다.  
   dml 및 ddl은 5가지 데이터베이스(Altibase, Cubrid, MySQL, Oracle, Tibero)를 지원한다.

![new_template_pst_run1](https://user-images.githubusercontent.com/3771788/229035205-cd5ad9a7-c8cf-43bf-ad2f-816aade1069a.jpg)

3. [템플릿 구성 및 환경설정](https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:let4:configration) 문서를 참고하여 템플릿 환경설정을 수행한다.

4. 실행할 프로젝트를 마우스 우클릭하고 **Run As > Run on Server** 를 선택한다.
