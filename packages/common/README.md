# common

The **common** package in the **LevelUp App** is a Dart package that centralizes all reusable widgets, components, constants, and utilities. It promotes modularity, consistency, and maintainability across the app while reducing duplicate development effort.

## Features
- Reusable UI components (buttons, text fields, animated backgrounds, etc.)
- Centralized themes and `AppColors` extension
- Utility functions for extensions, validators, services, dialogs, and input formatting
- Constants for app-wide usage

## Structure
The **common** package is structured into the following folders:

- `pubspec.yaml` : Contains all the dependencies and package configuration.
- `lib/const_data/` : Contains application-wide constants (`app_const.dart`).
- `lib/theme/` : Contains app theme configuration and color extensions.
- `lib/utils/` : Contains utilities such as:
    - `extensions/` : Extension methods
    - `input_formatters/` : Custom input formatters
    - `dialog_utils.dart` : Dialog helpers
    - `service_utils.dart` : Service layer utilities
    - `validators.dart` : Validation helpers
- `lib/widgets/` : Reusable widgets such as animated backgrounds, primary text form field, and typewriter text.
- `lib/common.dart` : Barrel export file for easier imports.

## Usage
Follow the steps below to set up and use the **common** in the **Level Up** app:

1. **Install dependencies**  
   Run the following command in the terminal or use **Pub get** from `pubspec.yaml`:
   ```bash
    flutter pub get
    ```

2. **Add dependency in `pubspec.yaml`**  
   Add dependency in `pubspec.yaml` of **levelup** app, add the translations package:   ```yaml
   dependencies:
   translation:
   path: ../packages/translation
   ```

3. **Export the package**  
   Export the **common** package in the `level_up.dart` of level up app.
   ```dart
   export 'package:common/common.dart';
   ```

4. **Use the package**  
   Import `level_up.dart` and use the widgets, constants, utils, and services.
   ```dart
   import 'package:level_up/level_up.dart';
   
   AppConst.appName
   ServiceUtils.keyboardClosed()
   DialogUtils.showDialog()
   ```
   
#
### NOTE
> Do not forget to apply barrel export. applying barrel export will ease the process of accessibility throughout the packages.