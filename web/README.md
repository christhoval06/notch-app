# NOTCH landing page

The web target runs the Dart landing feature in `lib/features/landing`.
`web/index.html` provides the HTML shell and metadata. The supplied HTML
reference is implemented with Flutter widgets, local screenshots, and the
Obsidian Sanctuary tokens from DESIGN.md. Mobile startup remains in `lib/main.dart`.

## Preview

```sh
flutter run -d chrome
```

A standalone entry point also avoids loading mobile feature dependencies:

```sh
flutter run -d chrome -t lib/main_landing.dart
```

## Build

```sh
flutter build web --release
```

Download buttons open `https://apps.apple.com/us/app/notch/id6759076734` by default.
Override the destination with `--dart-define=NOTCH_APP_STORE_URL=YOUR_URL` if needed.
Deploy the generated
`build/web` directory. For a subdirectory deployment, pass `--base-href /path/`.

## Structure

- `lib/features/landing/widgets`: independent presentation sections.
- `lib/features/landing/services`: localized content mapping and injectable link opening.
- `lib/core/theme/landing_theme.dart`: centralized palette and typography.
- `lib/core/constants/landing_config.dart`: screenshots, branding, and external destinations.
- `lib/l10n/app_en.arb`, `app_es.arb`: all landing copy; the globe button switches languages.
- `assets/screens`: original app screenshots. `assets/icon.png`: app identity.

The landing does not initialize the app database, notifications, or authentication.
The page has no analytics, third-party image requests, or remote font requests.
Plus Jakarta Sans is bundled with its SIL Open Font License. Flutter's default
web engine may fetch rendering resources; this is independent of app data storage.

## Verification

```sh
flutter test test/features/landing
flutter analyze lib/features/landing lib/core/app/landing_app.dart
flutter build web --release
```
