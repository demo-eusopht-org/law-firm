
# ⚖️ Law Firm App

**Law Firm App** is a Flutter-based mobile application for managing legal services. The app helps users book consultations, access legal resources, and track case updates. It uses **Flutter Bloc** for efficient and reactive state management.

---


## 🛠️ Tech Stack
- 🐦 **Flutter**: Version 3.24.3
- 🎯 **Dart**: Version 3.5.3
- 📦 **Flutter Bloc**: Version 8.1.4


---

## 📁 Folder Structure

The project is organized into the following folder structure for better modularity and maintainability:




lib/  
├── 📡 api/               # API integrations and network requests  
│   ├── auth_api/
│   └── case_api/  
│   └──lawyer_api/
│   └── dio.dart  	
├── 📦 model/             # Data models representing application objects  
│   ├── cases/  
│   ├── login_model.dart
│   ├── forgot_password_model.dart  
│   └── get_all_lawyers_model.dart  
│   └── open_file_model.dart  
│   └── qualification_model.dart  
│   └── new_lawyer_model.dart  
├── 🔧 permission/   # Role-based access control and permissions
│   ├── role_permission.dart  
├── 🔧 services/          # Business logic and reusable service classes  
│   ├── local_storage_service.dart  
│   ├── locator.dart  
├── 🧰 utils/             # Utility functions, constants, and helpers  
│   ├── constants.dart  
│   ├── app_assets.dart
├── 🖼️ views/             # Application screens/pages  
│   ├── auth_screens/  
│   ├── cases/  
│   ├── cause/  
│   ├── customer/  
│   └── history/
│   └── home/
│   └── lawyer/
│   └── notification/
│   └── profile/
│   └── splash_screen.dart
├── 🧩 widgets/           # Custom reusable widgets for the UI  
│   ├── custom_textfield.dart  
│   ├── button_widget.dart  
│   ├── appbar_widget.dart  
│   ├── listview.dart  
│   ├── email_validator.dart  
│   └── bottom_navigation.dart
│   └── loader.dart
│   └── toast.dart  
├── 📄 pubspec.yaml       # Dependency configurations  
└── 🚀 main.dart          # Application entry point

--- 
## 🚀 Getting Started

Follow these instructions to set up and run the app locally.

### ✅ Prerequisites

Ensure the following tools are installed on your system: - **Flutter SDK**: Install the latest version from the [Flutter website](https://flutter.dev/docs/get-started/install). - **Git**: Install Git for version control. - **Code Editor**: Use an editor like **VS Code** or **Android Studio** for development.

### 🛠️ Installation Steps
1. **Clone the repository**: ```bash git clone https://github.com/your-username/flutter-app.git

2. **Install dependencies**
   Run the following command to fetch and install required packages:
```bash
flutter pub get
```
3. **Run the app**
``` bash
flutter run
```
