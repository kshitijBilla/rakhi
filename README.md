# Rakhi - Women Safety App 🛡️

**Rakhi** is a comprehensive women's safety application designed to provide immediate assistance and peace of mind. Built with Flutter, it bridges the gap between emergency contacts, real-time location tracking, and community support.

## ✨ Key Features

*   **🆘 SOS Panic Mode**: Instant activation compliant with safety standards. Sends alerts with live location to emergency contacts.
*   **📍 Live Location Tracking**: Real-time GPS tracking allows trusted contacts to monitor your journey.
*   **🎥 Camera & Audio Recording**: Automatically captures evidence during SOS activation.
*   **📞 Emergency Contacts**: Easily manage and notify trusted friends & family.
*   **🗺️ Safe Route Finder**: Navigation assistance prioritizing safe and well-lit routes.
*   **⌚ Wearable Integration**: Connects with smart devices for hands-free SOS activation.
*   **🏥 Helplines**: Quick access to national emergency numbers and support services.
*   **💬 Fake Call**: A discreet tool to escape uncomfortable situations (Removed in v1.0 per policy, but framework exists).

## 🛠️ Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/) (Dart)
*   **State Management**: Provider
*   **Maps**: Google Maps Flutter / OpenStreetMap (configurable)
*   **Permissions**: `permission_handler` for robust granular permission management.
*   **Storage**: Shared Preferences / Local Storage

## 🚀 Getting Started

### Prerequisites

*   [Flutter SDK](https://docs.flutter.dev/get-started/install)
*   [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
*   A connected Android device or emulator.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/kshitijBilla/rakhi.git
    cd rakhi
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app**:
    ```bash
    flutter run
    ```

## 🔐 Permissions

The app requires the following permissions to function correctly:
*   `ACCESS_FINE_LOCATION`: For live tracking and SOS.
*   `SEND_SMS`: To send emergency alerts to contacts.
*   `CAMERA`: To record evidence during emergencies.
*   `RECORD_AUDIO`: For audio evidence.

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---
*Built with ❤️ for a safer world.*

