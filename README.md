# LevelUp - Habit Tracker

A beautiful, smooth, animated habit tracking app built with Flutter. Track your habits, build streaks, and level up your productivity with an engaging user experience.

## Features

- **Habit Tracking**: Create and manage daily habits
- **Streak System**: Build and maintain streaks to stay motivated
- **Stats Overview**: Total days, committed habits, current streak, and best streak
- **Dark/Light Mode**: Built-in theme support
- **Respawn Habits**: Respawn habits to remove all streaks
- **Change Streak Emoji**: Change your streak emoji to any emoji you like
- **Beautiful UI**: Smooth animations, Animated background and modern design
- **Local Storage**: Data persistence using Hive
- **Responsive Design**: Works on mobile
- **Multi-language Support**: Built with localization in mind

## Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Navigation**: go_router
- **UI**: flutter_screenutil for responsive design
- **Animations**: Lottie, Flutter Animate, Custom Animation

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK (latest stable)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (with Flutter plugins)

### Installation

1. **Clone the repository**
   ```bash
   git clon the repo (https://github.com/aryacodes007/levelup.git)
   ```
2. **Install dependencies**  
   Navigate to **common** packages and run the following command.
   ```bash
    cd packages/common
    flutter pub get
    ```
   Navigate to **translations** packages and run the following command.
   ```bash
    cd ../translations
    flutter pub get
    ```
   Navigate to **levelup** app and run the following command.
   ```bash
    cd ../../levelup
    flutter pub get
    ```
3. **Code Generation**
   Generate the .g.dart files for Hive Adapters using the following command.
   ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4. **Run the app**
   Run the app using the following command.
   ```bash
    flutter run
    ```

### Project Structure
- `pubspec.yaml` : Project configuration file and dependencies
- `lib/routes/` : Application routing (`app_routes/`)
- `lib/data/` : Data layer (models, repositories)
- `lib/my_app/` : Main app configuration
- `lib/providers/` : Riverpod providers for state management
- `lib/screens/` : UI screens with functionalities
- `lib/common.dart` : Barrel export file for easier imports
- `packages/common/` : Shared UI components, app theme, and utilities
- `packages/translations/` : App localization

#
### NOTE
> Do not forget to apply barrel export. applying barrel export will ease the process of accessibility throughout the packages.
