# 📱 Simple Flutter App with Clean Architecture

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-Language-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

### **Welcome to the Simple Flutter App with Clean Architecture!**

This project is a minimal and clean Flutter application designed to demonstrate the use of **Clean Architecture** principles. The app is implemented in **Dart** and organized with a clean separation of concerns, making it easy to understand and extend. It serves as a template for anyone who wants to start with a structured, scalable, and maintainable app architecture.


## 📝 Overview
The app provides a simple interface to manage posts and demonstrates the following key features:

- **Add Post** - Create new posts with ease.
- **Delete Post** - Remove unwanted posts.
- **Get All Posts** - Retrieve and display a list of all posts.
- **Update Post** - Edit and update existing posts.
- **Get Me All** - An additional use case showcasing data retrieval functionality.

This project is a perfect starting point for developers who want to understand the basics of **Clean Architecture** in Flutter.

 ## 📋 Requirements
- **Flutter SDK** (latest stable version)
- **Dart SDK**
- **Any IDE** (e.g., VS Code, Android Studio)


## 🧩 Built With
- **Flutter** - UI framework for building natively compiled applications.
- **Dart** - Programming language optimized for building user interfaces.

## 🛠️ Project Structure

The application is built with **Clean Architecture**, structured into separate layers for better organization and maintainability:

1. **Presentation Layer**: Responsible for the UI, including widgets and screens.
2. **Domain Layer**: Contains business logic and use cases.
3. **Data Layer**: Handles data sources and repositories.

Each layer is fully isolated, making it easier to test and modify without affecting the others.

---

## 📂 Folder Structure

Here's how the main folders in this project are organized:

├── lib\
│   ├── data           
│   ├── domain         
│   ├── presentation   
│   ├── core           
│   └── main.dart      
    
---

## ⚙️ Getting Started

To get started with the app:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/simple-flutter-clean-architecture-app.git
   cd simple-flutter-clean-architecture-app
   flutter pub get
   flutter run

