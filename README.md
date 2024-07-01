# LAO PT APP

## Table of Contents

- [Requirement](#requirdment)
- [Getting Started](#getting_started)


## Requirement <a name = "requirdment"></a>
- Flutter version 3.10.6
- JDK version 11

## Getting Started <a name = "getting_started"></a>

### How to run the app

- #### Generate localization <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/language.svg" width="20" height="15">
```
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
```
- #### Generate code (model, injection)
```
flutter pub run build_runner build --delete-conflicting-outputs
```

- ### ios
```
arch -x86_64 pod install
```

- ### Splash screen
```
flutter pub run flutter_native_splash:create
```
### or
```
flutter pub run flutter_native_splash:create --path=path/to/my/file.yaml
```
### How build the app
- Android
```
./build_app.sh
```# APP-LAOSPT
