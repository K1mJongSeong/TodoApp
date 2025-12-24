# 📝 Tasks

Google Tasks 스타일의 Flutter 할 일 관리 앱입니다.

## 📱 스크린샷

| 빈 상태 (라이트) | 빈 상태 (다크) | 할 일 목록 | 상세 보기 |
|:---:|:---:|:---:|:---:|
| 할 일이 없을 때 안내 화면 | 다크 모드 지원 | 할 일 목록 표시 | 할 일 상세 정보 |

## ✨ 주요 기능

### 할 일 관리
- ➕ **할 일 추가**: 하단 FAB 버튼으로 새 할 일 추가
- ✅ **완료 표시**: 체크박스로 할 일 완료/미완료 토글
- ⭐ **즐겨찾기**: 중요한 할 일에 별표 표시
- 📅 **마감일 설정**: 날짜 선택으로 마감일 지정
- 🗑️ **삭제**: 스와이프하여 할 일 삭제
- 📝 **상세 보기**: 할 일 탭하여 상세 정보 확인

### 테마
- 🌙 **다크 모드**: 라이트/다크 모드 전환 지원
- 🎨 **Material 3**: 최신 Material Design 3 적용

### 정렬
- 즐겨찾기 항목 우선 표시
- 마감일 기준 자동 정렬
- 완료된 항목은 하단 배치

## 🏗️ 프로젝트 구조

```
lib/
├── main.dart                          # 앱 진입점 및 테마 설정
└── features/
    └── todo/
        ├── domain/
        │   └── entities/
        │       └── todo_entity.dart   # 할 일 데이터 모델
        └── presentation/
            ├── pages/
            │   ├── home_page.dart             # 홈 화면
            │   ├── todo_detail_page.dart      # 상세 화면
            │   ├── add_todo_bottom_sheet.dart # 할 일 추가 바텀시트
            │   └── no_todo.dart               # 빈 상태 화면
            ├── viewmodels/
            │   ├── todo_viewmodel.dart        # 할 일 상태 관리
            │   └── theme_viewmodel.dart       # 테마 상태 관리
            └── widgets/
                ├── todo_view.dart             # 할 일 카드 위젯
                ├── todo_card.dart             # 할 일 카드 (미사용)
                └── add_todo_button.dart       # FAB 버튼
```

## 🛠️ 기술 스택

| 기술 | 버전 | 설명 |
|------|------|------|
| Flutter | 3.x | 크로스 플랫폼 UI 프레임워크 |
| Dart | ^3.5.0 | 프로그래밍 언어 |
| Provider | ^6.1.0 | 상태 관리 |
| intl | ^0.19.0 | 날짜 포맷팅 |

## 📦 설치 및 실행

### 요구사항
- Flutter SDK 3.x 이상
- Dart SDK 3.5.0 이상

### 실행 방법

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
```

### 빌드

```bash
# Android APK 빌드
flutter build apk

# iOS 빌드 (macOS 필요)
flutter build ios

# Web 빌드
flutter build web
```

## 📂 데이터 모델

### ToDoEntity

```dart
class ToDoEntity {
  final String title;        // 할 일 제목
  final String? description; // 세부 내용 (선택)
  final bool isFavorite;     // 즐겨찾기 여부
  final bool isDone;         // 완료 여부
  final DateTime? dueDate;   // 마감일 (선택)
}
```

## 🎨 디자인 시스템

### 색상 팔레트

| 용도 | 라이트 모드 | 다크 모드 |
|------|------------|----------|
| Primary | `#E65100` | `#FF6D00` |
| Background | `#F5F5F5` | `#202124` |
| Surface | `#FFFFFF` | `#303134` |
| AppBar | `#3C4043` | `#3C4043` |
| FAB | `#FF5722` | `#FF5722` |

### 컴포넌트

- **Border Radius**: 12dp (카드, 버튼)
- **Padding**: 20dp (기본 여백)
- **Card Shadow**: 0.05 opacity (라이트 모드)

## 📄 라이선스

이 프로젝트는 학습 목적으로 제작되었습니다.
