# 🎯 RandomPick

> **랜덤 프로필 룰렛 애플리케이션**  
> `https://randomuser.me/api/` 로부터 받아온 프로필 데이터를  원형(룰렛) 형태로 회전시키고, 최종적으로 선택된 프로필을 확대하여 표시하는 iOS Demo App


---

## Architecture
**특징**
- **ReactorKit + RxSwift** 로 단방향 데이터 플로우 유지  
- **UseCase / Repository / Service** 계층 분리로 테스트 용이  
- **Codebase UI** 기반 (스토리보드 완전 제거)  
- **FlexLayout + PinLayout** 으로 선언적 레이아웃 구성  

---

## Tech Stack

| Category              | Library                                                |
|-----------------------|--------------------------------------------------------|
| **Network**       | [Alamofire](https://github.com/Alamofire/Alamofire)    |
| **Reactive**      | [RxSwift](https://github.com/ReactiveX/RxSwift)        |
|                       | [ReactorKit](https://github.com/ReactorKit/ReactorKit) |
|                       | [RxKingfisher](https://github.com/onevcat/Kingfisher)  |
| **UI Layout**     | [FlexLayout](https://github.com/layoutBox/FlexLayout)  |
|                       | [PinLayout](https://github.com/layoutBox/PinLayout)    |
| **Image Caching** | [Kingfisher](https://github.com/onevcat/Kingfisher)    |
| **API**           | [randomuser.me](https://randomuser.me/api/)            |

---

## Core Features

- ✅ **랜덤 프로필 Fetch**
  - `https://randomuser.me/api/` 에서 비동기 프로필 요청  
  - `RandomUserService → Repository → UseCase` 계층을 통해 Reactor로 전달

- 🎡 **룰렛 애니메이션**
  - 원형으로 배치된 `ProfileView`들이 순차적으로 점등/회전  
  - 회전 속도는 점점 느려지며, 마지막에 1명의 프로필을 Spotlight 효과로 확대

---

## 📂 Directory Structure

```
RandomPick/
├── Resources/
│   ├── Assets.xcassets/
│   │   └── LaunchScreen.storyboard
│
├── Sources/
│   ├── Application/
│   ├── Domain/
│   │   ├── Data/
│   │   │   ├── Network/
│   │   │   │   ├── Helper/
│   │   │   │   └── Manager/
│   │   │   ├── RepositoryImpl/
│   │   │   ├── Entity/
│   │   │   ├── Repository/
│   │   │   └── UseCase/
│   ├── Presentation/
│   │   ├── View/
│   │   │   ├── BaseView/
│   │   │   ├── ProfileView/
│   │   ├── ViewController/
│   │   │   ├── BaseViewController/
│   │   │   └── LottoSpotlightCircle/
│   │   ││
│   ├── Extensions/
│   └── Common/
│
└── Supporting Files/
│   └── Info.plist
│
├── RandomPickTests/
│
└── RandomPickUITests/

```

---

## 🛠️ Environment

| 항목 | 내용 |
|------|------|
| **Minimum iOS Version** | 15.6 |
| **Language** | Swift 5.10 |
| **UI Framework** | UIKit (Codebase UI only) |
| **Storyboard** | ❌ 제거됨 |
| **Dependency Manager** | Swift Package Manager (SPM) |


---

### ✨ Author
**HYUN SUNG**  
iOS Developer — [GitHub](https://github.com/vkcldhkd)
