# IGStoryLite

IGStoryLite is a modular, scalable iOS application that demonstrates a story-style feed experience inspired by Instagram. 
It is designed with clean architecture principles, a strong emphasis on separation of concerns and flexibility, and modern SwiftUI practices.

Short video presentation talking about technical decisions: [video link](https://www.loom.com/share/3ed93452d9074dedbd5685d6f702859e?sid=314e5939-2e88-44b8-96a1-856c6568e2f5)

## 📱 Features

- Horizontal story feed (Instagram-style) with user thumbnails
- Tap-to-advance story navigation
- Like/Unlike and "seen" state management
- Design system for consistent UI styling
- Dependency injection and testable components
- Simulated pagination and networking with JSONPlaceholder
- Async image loading

---

## 🧱 Architecture Overview

The app is structured following **Clean Architecture** and **SOLID** principles, with clear separation between:

### 1. **Domain Layer**
- Abstracts business logic
- Defines `UseCase` protocols (e.g. `FetchStoriesUseCase`, `MarkStoryAsSeenUseCase`)
- Uses models that are not tied to UI or API concerns

### 2. **Data Layer**
- Handles networking and data mapping
- Contains remote models, remote data sources, persistence service and concrete repository implementation
- Mappers convert remote models to domain models

### 3. **Presentation Layer**
- SwiftUI-based views and view models
- Views are lightweight and focused only on rendering
- Coordinators encapsulate navigation logic
- Components (e.g. `UserAvatarView`, `StoryView`) are reusable and test-friendly

---

## 🎨 Design System

To ensure consistency and scalability, the app includes a simple semantic design system:

- `AppPadding` – semantic spacing (e.g. `.small`, `.medium`, `.large`)
- `AppFont` – reusable font styles (e.g. `.title()`, `.bodyBold()`)
- Semantic colors defined in `AppColor`

This abstraction makes it easier to apply design changes across the app.

---

## 🧠 Design Rationale

This project was built with long-term maintainability and clarity in mind:

- **Testability-first design**: All dependencies are injected via protocols, making mocks and previews trivial to implement
- **Scalability**: Each screen or flow is isolated, and additional features (e.g. comments, media types) can be added with minimal impact
- **Code readability**: Separation of concerns ensures each file/class has a single responsibility
- **Modern SwiftUI patterns**: Uses `.task`, `.StateObject`, view composition, and avoids global state

Where simplification made sense for a focused demo:

- The `APIClient` is minimal and synchronous for simplicity
- Simulated pagination as used API doesn't actually support it
- Real-world services (auth, analytics, CoreData) are abstracted away

---

## 🚧 Areas for Future Work

- Improve navigation so story presentation starts with the selected story
- Replace static JSONPlaceholder data with real backend integration
- Add loading/error states for the story screen
- Add support for image progress bar or auto-advancing stories
- Implement actions for message sending
- Improve support for dynamic type and accessibility
- Animate story transitions and overlays

---

## 🧪 Testing

The architecture supports unit testing of:
- Repositories and Use Cases (domain logic)
- ViewModels (using dependency injection and mock use cases)

UI testing and snapshot testing are possible but not included here.

---
