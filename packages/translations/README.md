# translations
The **Translations** package for managing **app localization** in the **LevelUp** app.

## Features
- Provides localization setup using Flutter's built-in l10n support.
- Centralizes all app strings for multiple languages.
- Simplifies translation management and integration with the app.
- Ensures consistency across the LevelUp app.
- Adds a convenient `context.l10n` extension for easy access to localized strings.

## Structure
The **Translations** package is structured into the following files and folders:

- `pubspec.yaml` : Contains all the dependencies and package configuration.
- `l10n.yaml` : Flutter localization configuration file.
- `lib/l10n/` : Contains localization setup and generated files.
    - `arb/` : Contains ARB files with translations (e.g., `app_en.arb`).
    - `app_localizations.dart` : Generated localization delegate.
    - `app_localizations_en.dart` : Generated localization for English.
    - `l10n.dart` : Localization extension (`context.l10n`) and helpers.
    - `translations.dart` : Barrel export for localization usage.

## Generating Localization Files
Run the following command to active command to generate localization files:
```bash
dart pub global activate generate
```

After making changes to the ARB files, generate the localization files using:
```bash
cd packages/translations
flutter gen-l10n
```

## Usage
Follow the steps below to set up and use the **translations** in the **Level Up** app:

1. **Install dependencies**  
   Run the following command in the terminal or use **Pub get** from `pubspec.yaml`:
   ```bash
    flutter pub get
    ```

2. **Add dependency in `pubspec.yaml`**  
   Add dependency in `pubspec.yaml` of **levelup** app, add the translations package:   
   ```yaml
   dependencies:
     translation:
       path: ../packages/translation
   ```
   
3. **Export the package**  
   Export the **translations** package in the `level_up.dart` of level up app:
   ```dart
   export 'package:translations/translations.dart';
   ```

4. **Use the package**  
   Import `level_up.dart` and use the localized strings:
   ```dart
   import 'package:level_up/level_up.dart';
   
   context.l10n.levelup
   ```

#
### NOTE
> Do not forget to apply barrel export. applying barrel export will ease the process of accessibility throughout the packages.