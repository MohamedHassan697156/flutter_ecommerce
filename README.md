# 🛍️ Flutter E-Commerce App

A full-featured e-commerce mobile application built with **Flutter** following **Clean Architecture** principles and **BLoC/Cubit** state management.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC%2FCubit-13B9FD?style=for-the-badge&logo=flutter&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-6C63FF?style=for-the-badge)

## ✨ Features

- 🏠 **Home** — Product listings with categories & search
- 🔍 **Product Detail** — Images, description, size/color selector, reviews
- 🛒 **Cart** — Add/remove items, quantity control, total calculation
- ❤️ **Wishlist** — Save favourite products
- 👤 **Profile** — User info & order history
- 🌙 **Dark/Light Mode** — Full theme support
- 🌐 **Arabic RTL** — Full right-to-left support

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/        # App constants, colors, strings
│   ├── theme/            # Light & dark theme
│   └── utils/            # Extensions, helpers
├── data/
│   ├── models/           # Product, Cart, User models
│   └── repositories/     # Data sources (mock)
└── presentation/
    ├── screens/          # Home, Product, Cart, Profile
    ├── widgets/          # Reusable UI components
    └── bloc/             # Cubits & states
```

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| Flutter | Cross-platform UI |
| Dart | Programming language |
| Cubit (BLoC) | State management |
| GetIt | Dependency injection |
| Hive | Local cart persistence |
| Cached Network Image | Image caching |
| Go Router | Navigation |

## 🚀 Getting Started

```bash
git clone https://github.com/MohamedHassan697156/flutter_ecommerce.git
cd flutter_ecommerce
flutter pub get
flutter run
```

## 📱 Screens

| Home | Product Detail | Cart | Profile |
|------|---------------|------|---------|
| Categories + Grid | Images + Reviews | Items + Total | Orders + Settings |

## 👨‍💻 Author

**Mohamed Hassan** — Flutter Mobile Developer
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat&logo=linkedin)](https://www.linkedin.com/in/mohamed-hassan-6891401aa/)
[![Portfolio](https://img.shields.io/badge/Portfolio-09090f?style=flat&logo=github)](https://MohamedHassan697156.github.io/MY-portfolio/)
