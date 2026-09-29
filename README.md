# Gemini AI Voice ChatBot

> A Flutter chatbot that talks to Google Gemini, with speech-to-text input and text-to-speech replies.

[![Live Demo](https://img.shields.io/badge/Live%20Demo-Open-2ea44f?style=for-the-badge&logo=vercel)](https://flutter-gemini-chatbot-web.vercel.app)

**Live demo:** https://flutter-gemini-chatbot-web.vercel.app

## Features
- Chat interface with user and bot message bubbles
- Calls the Gemini `generateContent` REST API via `http`
- **Voice input** using speech-to-text
- **Spoken replies** using text-to-speech
- Demo mode with local mock replies when no API key is configured

## Tech Stack
- Flutter / Dart
- [`http`](https://pub.dev/packages/http) – Gemini REST API
- [`speech_to_text`](https://pub.dev/packages/speech_to_text) – voice input
- [`flutter_tts`](https://pub.dev/packages/flutter_tts) – voice output

## Project Structure
```
lib/main.dart                  # GeminiChatBot app + ChatScreen
leave_requests_refactored/     # separate leave-requests UI experiment
web/                           # Flutter web shell
```

## Getting Started
```bash
flutter pub get
flutter run            # Android / iOS / desktop
flutter run -d chrome  # web
```
Build for web: `flutter build web` (output in `build/web`).

### Using your own Gemini key
Set the `apiKey` value in `lib/main.dart` to your own key from [Google AI Studio](https://aistudio.google.com/). Leave it empty to use demo mode. Never commit a real key.

> **Note:** The live web demo runs in demo mode with local mock replies instead of calling Gemini.

## Author

**Khuwaish Goyal**
- Portfolio: https://khuwaish-portfolio.vercel.app
- LinkedIn: https://www.linkedin.com/in/khuwaishgoyal
- GitHub: https://github.com/KhuwaishGoyal28
