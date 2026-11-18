# WOrganice

Aplikasi manajemen layanan wedding organizer berbasis Flutter.

## Technology Stack

- Flutter: 3.47.9
- Dart: 3.13.7
- SDK Management: FVM
- Primary Platform: Android
- Minimum Android API: 24

## Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/USERNAME/WO-PPL.git
cd WO-PPL
```

### 2. Install Flutter SDK

```bash
fvm install
```

### 3. Install Dependencies

```bash
fvm flutter pub get
```

### 4. Run Application

```bash
fvm flutter run
```

## Git Workflow

- `main`: Release branch.
- `develop`: Integration branch.
- `feature/WO-xxx-singkat`: Feature development branch.

All feature changes must be submitted through Pull Requests and reviewed by at least one team member before merging.

## Project Architecture

WOrganice menggunakan Flutter dengan satu basis kode untuk dua jenis pengguna, yaitu Admin Wedding Organizer dan Klien.

### Directory Structure

```text
lib/
├── app/             # Konfigurasi aplikasi, routing, providers
├── core/            # Komponen dan utilitas umum
├── domain/          # Entitas, repository contracts, use cases
├── data/            # Datasources, models, repository implementations
├── presentation/
│   ├── admin/       # UI khusus Admin WO
│   ├── client/      # UI khusus Klien
│   └── shared/      # UI yang digunakan bersama
└── main.dart        # Entry point aplikasi
```

### Technology Stack

| Component | Technology |
|---|---|
| Framework | Flutter |
| State Management | Provider |
| Routing | GoRouter |
| Backend Services | Firebase |
| Code Analysis | flutter_lints |

### Environments

WOrganice menyediakan dua environment:

- **DEV:** Digunakan untuk pengembangan dan pengujian menggunakan Firebase Development Project.
- **PROD:** Digunakan untuk build produksi menggunakan Firebase Production Project.

### Run Development

```bash
fvm flutter run --flavor dev --dart-define=APP_ENV=dev -t lib/main.dart
```

### Run Production

```bash
fvm flutter run --flavor prod --dart-define=APP_ENV=prod -t lib/main.dart
```

### Code Analysis

Sebelum membuat Pull Request, jalankan:

```bash
fvm flutter analyze
fvm flutter test
```

Pastikan tidak ada error analisis kode sebelum mengajukan Pull Request.