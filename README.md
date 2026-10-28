# Cell Point

A Flutter application for managing the day-to-day work of a mobile phone shop. Cell Point brings inventory, sales, repair tracking, and sales reports together in one app.

## Features

- **Dashboard** — quick access to the shop's main sections.
- **Inventory** — view products and stock, check low-stock items, and add stock.
- **Sales** — record shop sales and review sales information.
- **Mobile repairs** — create repair records and track their status from receipt to delivery.
- **Sales reports** — review sales over daily, weekly, and monthly periods.
- **Local database** — the project includes a SQLite database service for shop records.

## Built with

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- SQLite (`sqflite`)

## Requirements

- Flutter SDK and Dart SDK installed
- An Android emulator or a connected Android device
- Git, if you are cloning or publishing this project

Check your Flutter installation and available devices:

```powershell
flutter --version
flutter doctor
flutter devices
```

## Run the app

Open a terminal in the project root (the folder containing `pubspec.yaml`), then run:

```powershell
flutter pub get
flutter run
```

To select a particular emulator or device, list available devices with `flutter devices`, then pass its ID:

```powershell
flutter run -d <device-id>
```

## Validate and build

Run the analyzer and the project's tests:

```powershell
flutter analyze
flutter test
```

Create a release APK for Android:

```powershell
flutter build apk --release
```

The APK is written to:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Publish to GitHub

The GitHub repository for this project is [flutter-project](https://github.com/Jyothsnasri5607/flutter-project). From a terminal opened at the project root, run:

```powershell
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/Jyothsnasri5607/flutter-project.git
git push -u origin main
```

If this project is already connected to the correct GitHub repository, you can publish new changes with:

```powershell
git add README.md
git commit -m "Improve project README"
git push
```

## Project layout

The existing Flutter project layout is unchanged. Application screens and supporting Dart files are under `lib/`; Flutter platform folders are at the project root.

## Notes

- Run Flutter commands from the directory containing `pubspec.yaml`.
- If Git reports that `origin` already exists, update it with `git remote set-url origin https://github.com/Jyothsnasri5607/flutter-project.git`.
- This README documents the project as it currently exists and does not change application code or dependencies.
