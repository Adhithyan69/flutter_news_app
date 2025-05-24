# 📰 Flutter News App

A clean, simple Flutter app to read and bookmark news articles. Built with modern architecture and local session persistence.

## 🔗 Clone the Repository

```bash
git clone https://github.com/Adhithyan69/flutter_news_app.git
cd flutter-news-app
flutter pub get
flutter run

## 📸 Screenshots

| Login Page | News Feed | Bookmarks |
|------------|-----------|-----------|
|lib/assets/screenshots/login.jpg| lib/assets/screenshots/news.jpg |lib/assets/screenshots/bookmark.jpg |

🧱 Architecture Choices

MVVM Pattern: For clean separation of UI, logic, and data.

State Management: Provider (or preferred solution) to handle app state.

Modular File Structure for scalability and maintainability:


| Package                    | Purpose                                               |
| -------------------------- | ----------------------------------------------------- |
| `news_api_flutter_package` | Easy integration with News API to fetch news articles |
| `http`                     | (If used additionally) for general network calls      |
| `provider`                 | State management                                      |
| `shared_preferences`       | Save login session and bookmarks                      |
| `webview_flutter`          | View full articles in a WebView                       |
| `intl`                     | Date formatting (e.g., `16 April, 2025`)              |

## 📱 Download APK


👉 [Download APK from Google Drive](https://drive.google.com/file/d/1a2b3c4d5e6f7g8h9/view?usp=sharing)



