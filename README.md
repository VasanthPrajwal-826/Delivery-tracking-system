# 🚚 Delivery Tracking System

A Flutter-based delivery tracking application designed to help customers track their orders, delivery agents manage deliveries, and administrators monitor the overall delivery system.

## 📌 About the Project

The Delivery Tracking System provides a simple and user-friendly platform for managing and tracking deliveries.

The application is designed around three main user roles:

- 👤 Customer
- 🚴 Delivery Agent
- 👨‍💼 Admin

Each role has access to features relevant to their responsibilities.

## ✨ Key Features

### 👤 Customer
- User authentication
- View orders
- Track delivery status
- View order details
- Monitor delivery progress

### 🚴 Delivery Agent
- View assigned deliveries
- Update delivery status
- Manage delivery information
- Track assigned orders

### 👨‍💼 Admin
- Monitor users and orders
- Manage delivery agents
- View delivery information
- Manage the overall delivery system

## 🛠️ Technologies Used

- Flutter
- Dart
- Android
- Git
- GitHub

## 🏗️ Project Structure

```text
delivery-tracking-system/
│
├── android/
├── ios/
├── assets/
│   ├── fonts/
│   └── images/
│
├── lib/
│   ├── models/
│   ├── screens/
│   │   ├── admin/
│   │   ├── auth/
│   │   ├── customer/
│   │   └── delivery_agent/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── test/
├── pubspec.yaml
└── README.md