# Flutter Tech Test App

A Flutter technical assessment project demonstrating **authentication, API integration, pagination, theme switching, and clean architecture**.

This project follows a scalable architecture and focuses on best practices used in modern Flutter applications.

---

# Features

* User Authentication (Login API)
* Bottom Navigation (Products, Posts, Settings)
* Products List with Pagination
* Posts List with Pagination
* Light / Dark Theme Switching
* Local Session Storage
* Logout Functionality
* Error Handling
* Clean Architecture Structure

---

# Screens

* Login Screen
* Home Screen (Bottom Navigation)
* Products Screen
* Posts Screen
* Settings Screen

Optional (Bonus):

* Product Detail Screen
* Post Detail Screen

---

# Tech Stack

* Flutter
* Getx (State Management)
* Dio (API Client)
* SharedPreferences (Local Storage)
* Cached Network Image
* Clean Architecture

---

# Project Structure

lib/
│
├── core/
│   ├── network/
│   ├── error/
│   ├── constants/
│   └── utils/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── products/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── posts/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── settings/
│       └── presentation/
│
└── main.dart

---

# API Used

Authentication

POST
https://dummyjson.com/auth/login

Test Credentials

username: emilys
password: emilyspass

Products API

https://dummyjson.com/products?limit=10&skip=0

Posts API

https://dummyjson.com/posts?limit=10&skip=0

---

# Installation

Clone the repository

git clone https://github.com/yourusername/flutter-tech-test.git

Go to project directory

cd flutter-tech-test

Install dependencies

flutter pub get

Run the project

flutter run

---

# Future Improvements

* Pull to Refresh
* Product Details Screen
* Post Details Screen
* Shimmer Loading
* Offline Cache
* Unit Testing

---

# Author

Flutter Developer
Eastodev Roy Utso

LinkedIn: https://www.linkedin.com/

---

# License

This project is created for technical assessment purposes.
