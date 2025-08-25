# SmartBridge - AIoT Smart Home System
스마트 가전이 아닌 기기까지 제어 가능한 AIoT 기반 만능 리모컨 시스템

<!-- 헤더: 움직이는 타이핑 배너 -->
<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=28&pause=1000&center=true&vCenter=true&width=750&lines=Hi%20I%27m%20SmartBridge%21;AIoT-based%20universal%20remote%20control%20system" alt="Typing SVG" />
</p>

<!-- 제목 -->
<h1 align="center">✨ SmartBridge — AIoT 만능 리모컨 ✨</h1>

<p align="center">
  기존 가전을 교체하지 않고도 스마트홈 환경에 연결할 수 있는 <b>AIoT 기반 만능 리모컨 시스템</b>
</p>

---

## 📌 프로젝트 개요

SmartBridge는 기존 가전을 교체하지 않고도 스마트홈 환경에서 제어할 수 있도록 만든  
**AIoT 기반 만능 리모컨**입니다.  

- 🖐 **손 제스처 인식**과 🎤 **음성 인식**을 통해 입력  
- Arduino UNO R4 WiFi를 이용해 **적외선(IR) 신호 송신**  
- 📱 **Flutter 크로스플랫폼 앱**으로 직관적인 모바일 제어
- 구형 가전을 스마트홈 통합 시스템에 연결  

---

## 🎯 개발 배경

💡 최신 스마트홈 기기는 대부분 **Wi-Fi 또는 BLE** 기반이지만,  
여전히 많은 가전은 **IR 리모컨**을 사용합니다.  

- 구형 가전은 스마트홈 생태계에서 배제되는 경우 多  
- 고령자 및 디지털 취약 계층은 **앱 기반 제어 UI** 사용에 어려움 존재  

👉 **SmartBridge**는 **제스처/음성/모바일 중심 직관적 제어**를 목표로 합니다.

---

## 🏗️ 시스템 아키텍처

<img width="1783" height="913" alt="image" src="https://github.com/user-attachments/assets/9f8f46f5-7193-4982-95a4-0b63e98cf999" />


```
[사용자] → (제스처 / 음성 / 모바일 입력)
      ↓
[Flask 서버] → MQTT → [Arduino UNO R4 WiFi] → IR LED → [가전제품]
      ↓              ↓
[Firebase RTDB] ↔ [Flutter 앱] ↔ [사용자 모바일]
```

---

## 🔑 주요 기능

### 🖐 손 제스처 인식
- Mediapipe 기반 손 관절 추출  
- MLP+TCN 기반 제스처 분류 (18가지 제스처)
- 실시간 제스처 인식 및 기기 제어

### 🎤 음성 명령 인식
- Google STT 기반 STT (음성 → 텍스트)  
- Google TTS (텍스트 → 음성 응답)  
- 자연어 명령 처리

### 📱 Flutter 모바일 대시보드
- **크로스플랫폼 지원**: iOS, Android, Web
- **실시간 기기 상태 모니터링**: Firebase Realtime Database 연동
- **제스처 커스터마이징**: 개인별 제스처-기기 매핑 설정
- **IR 리모컨 기능**: 전통적인 리모컨 UI 제공
- **AI 추천 시스템**: 사용 패턴 기반 제스처/기기 추천
- **사용자 관리**: Firebase Authentication 기반 로그인
- **5개 기기 지원**: 전등, 선풍기, 커튼, 에어컨, TV

### 📡 가전 제어
- Arduino UNO R4 WiFi + IR LED  
- 360° 서보모터로 특정 가전 방향 송신  
- Firebase RTDB로 IR 코드 관리  

### 🌐 시스템 연동
- Flask 서버: 제스처/음성 처리  
- MQTT 통신: 서버 ↔ 아두이노  
- Flutter 앱: 대시보드 UI 제공  
- Firebase: 인증, 실시간 DB, 클라우드 함수

---

## 🚀 프로젝트 실행 방법

### 1️⃣ Flask 서버 (제스처/음성 처리)

```bash
# 가상환경 설치 및 활성화
python -m venv venv
source venv/bin/activate   # (Mac/Linux)
venv\Scripts\activate      # (Windows)

# 라이브러리 설치
pip install -r requirements.txt

# Flask 서버 실행
python app.py

# ngrok 실행 (외부 접근용)
ngrok http 5000
```

### 2️⃣ Flutter 앱 (모바일 대시보드)

```bash
# Flutter 의존성 설치
flutter pub get

# 웹에서 실행
flutter run -d chrome

# 모바일에서 실행
flutter run
```

### 3️⃣ Arduino 펌웨어

- Arduino IDE에서 `arduino_control/` 폴더의 코드 업로드
- Wi-Fi 및 MQTT 브로커 설정 필요

---

### 4️⃣ 손동작 인식 학습 데이터

- MLP 데이터 : https://drive.google.com/file/d/1OTsTO228GnLIHdCKpG7RDiGOyXTuZfia/view?usp=drive_link
- TCN 데이터 : https://drive.google.com/file/d/1QAH3B2xb9BZhQWyzNqW1F38bo8Lg0WTk/view?usp=drive_link

## 📱 Flutter 앱 주요 화면

### 🏠 홈 화면
- 실시간 기기 상태 표시
- AI 추천 제스처 목록
- 빠른 제어 버튼

### 📋 기기 목록
- 5개 IoT 기기 (전등, 선풍기, 커튼, 에어컨, TV)
- 연결 상태 실시간 모니터링
- 기기별 제어 화면 접근

### 🎮 기기 상세 제어
- **제스처 목록**: 설정된 제스처 확인 및 수정
- **리모컨 화면**: 전통적인 IR 리모컨 UI
- **실시간 상태**: 전원, 온라인 상태 표시

### ✋ 제스처 커스터마이징
- 18가지 제스처 지원 (👍👎✌️🤟👌 등)
- 개인별 제스처-기기-제어 매핑
- 직관적인 그리드 UI

### 🤖 AI 추천 시스템
- 사용 패턴 분석 기반 제스처 추천
- 환경 정보 (온도, 시간) 고려
- 백엔드 API 연동

---

## 📌 요구사항 (Requirements)

### 🛠️ 하드웨어
- Arduino UNO R4 WiFi 보드  
- IR LED 송신기 (**핀: D3**)  
- 360° 서보모터 (**핀: D9**)  
- MQTT Broker (예: Mosquitto)  
- Wi-Fi AP (SSID, Password 필요)  

### 📚 라이브러리 (Arduino)
- **WiFiS3**  
- **PubSubClient**  
- **ArduinoJson** (버전 6.x 이상)  
- **IRremote** (버전 4.x 이상)  
- **Servo** (Arduino 내장)  

### 📱 Flutter 라이브러리
- **firebase_core**: Firebase 초기화
- **firebase_auth**: 사용자 인증
- **firebase_database**: 실시간 데이터베이스
- **http**: API 통신
- **shared_preferences**: 로컬 저장

---

## ✅ 기대 효과

- 구형 가전도 교체 없이 스마트홈에 연결 가능
- 제스처/음성/모바일 제어로 누구나 직관적 사용 가능
- 고령자·장애인 접근성 향상
- 개인화된 AI 추천으로 사용 편의성 증대

---

## 🔧 개발 환경

- **Frontend**: Flutter (Dart)
- **Backend**: Flask (Python)
- **Database**: Firebase Realtime Database, Firebase Firestore Database
- **Authentication**: Firebase Auth
- **Hardware**: Arduino UNO R4 WiFi (C/C++)
- **Communication**: MQTT, HTTP API
- **AI/ML**: Mediapipe, TensorFlow

---

## 시연 영상

-유튜브 링크: https://youtu.be/hTZr1kJplH8?si=2JTG4JiwHE3kMMD3

---

<p align="center">
  <b>SmartBridge로 모든 가전을 스마트하게! 🏠✨</b>
</p>
