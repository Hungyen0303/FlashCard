# Flashcard Learning App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)
![Dart](https://img.shields.io/badge/Dart-2.x-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

### Created by : Hungyen0303 
## Youtube : Demo 
- https://youtu.be/GaH_4NPYHh4
## Backend repo 
I build by myself
- https://github.com/Hungyen0303/FlashCard_backend

Inspired by trendy AI ,  I create app for assisting Vietnamese to learn English. This motivation makes me invent this app. 
A mobile application built with **Flutter** to help users learn through interactive flashcards and AI-powered conversations. This project aims to provide an engaging learning experience with appealing UI , easy tools, modern trendy technology. 

---

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Technologies Used](#technologies-used)
- [Architecture](#Architecture)


---

## Features

- **Flashcard System**: Interactive cards with customizable content for learning.
- **AI Conversations**: Simulated conversations powered by AI to enhance language skills.
- **Loading Overlay**: Custom loading overlay with animated visuals (e.g., a jumping cat) for smooth user experience during data fetching.
- **Shimmer Effect**: Skeleton loading UI using the `shimmer` package to display placeholders while fetching data.
- **Provider State Management**: Efficient state management for handling conversations and user data
- **Dictionary** : Designed for searching words, prounoucing words, listening natives speak , scan images for quick search

---

## Screenshots

![Home Screen](home (2).png)
![Intro page](intropage.png)
![Flashcard](card.png)
![Dictionary](dictionary.png)
![AI Conversation](chatwithAI.png)
![Account](account.png)


## Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.x or higher)
- [Dart](https://dart.dev/get-dart) (version 2.x or higher)
- An IDE (e.g., Android Studio, VS Code)
- Android/iOS emulator or physical device

### Steps
1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/flashcard-learning-app.git
   cd flashcard-learning-app
2. **Install Dependencies**
   ```bash
   flutter pub get
2. **Run Code**
   ```bash
   flutter run

### Usage
- Launch the App: Open the app to see the default splash screen (Flutter logo) followed by the home screen.
- Explore Flashcards: Navigate through the flashcard section to view learning content.
- AI Conversations: Access the "AI Conversations" section, where cards display a shimmer effect while data loads from the AI backend. Once loaded, interact with the conversation cards.
- AI Chat : Chat with AI for feedbacks or other problems with leanring
- Navigating to dictionary help you to practice pronoucing , listening  skills.

## Technologies Used
Flutter: Cross-platform framework for building the app.
Dart: Programming language for Flutter.
Java 
MySQL 
Supabase 
and more ... 

## Architecture

```bash
   flashcard-learning/
   ├── android/              # Android native files
   ├── ios/                  # iOS native files
   ├── lib/
   │   ├── ui/               # UI components and screens
   │   │   ├── home/         # Home screen and widgets
   │   │   │   ├── widgets/  # Reusable widgets (e.g., CardCustom)
   │   │   └── conversation_ai_screen.dart  # AI conversation screen
   │   ├── utils/            # Utility files (colors, enums)
   │   ├── view_models/      # View models for state management
   │   └── main.dart         # App entry point
   ├── assets/               # Images and static resources
   ├── pubspec.yaml          # Dependencies and configuration
   └── README.md             # Project documentation





