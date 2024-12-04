# 🎬 Flutter Movie App

A modern Flutter application for browsing, searching, and managing movies. This app integrates advanced features like Firebase for user-specific data and personalized movie recommendations.

---

## ✨ Features

- **User Authentication**: Sign up and log in with Firebase Authentication.
- **Search**: Search movies by name with real-time results.
- **Recommendations**: Get movie recommendations based on user activity.
- **Saved & Downloads**: Save movies to Firebase or download for offline access using SQLite.
- **Latest Releases**: Browse the latest movie releases.
- **Category-Based Browsing**: Explore movies by genres.
- **User Profiles**: Manage your account and preferences.
- **Responsive UI**: Designed to work seamlessly on various screen sizes.

---

## 🚀 Recommendation System

The app includes a **personalized recommendation system**:

1. Tracks user activity (clicked movies) and stores it in Firebase.
2. Fetches movie recommendations based on the TMDB API using the `Recommendations` endpoint.
3. Displays tailored recommendations in the **Search Screen**.

### How It Works:
- When a user clicks on a movie, it is added to their recently clicked list (up to 3 movies are tracked).
- Recommendations are fetched dynamically for these movies and displayed to the user.

---

## 🔍 Search Functionality

The app features a **powerful search system**:

- Users can search for movies by their title using the TMDB API.
- Results are displayed in a clean, responsive list format.
- Integrated with user-friendly UI components for an intuitive experience.

---

## 📂 Folder Structure

```plaintext
lib/
├── common/
│   ├── animations/
│   ├── styles/
│   └── widgets/
├── features/
│   ├── AuthScreens/
│   ├── CategoryScreen/
│   ├── DownloadsScreen/
│   ├── HomeScreen/
│   ├── LatestScreen/
│   ├── MovieDetailsScreen/
│   ├── PopularScreen/
│   ├── ProfileScreen/
│   ├── SavedScreen/
│   └── SearchScreen/
├── utils/
│   └── ...
├── app.dart
├── firebase_options.dart
├── main.dart
├── main_page.dart
 ```
---
## 🌐 APIs Used
- TMDB API: Provides movie data and recommendations.
- Firebase: Handles authentication and cloud storage.
- Note !! you have to get an API-KEY to use the app

---

## 👤 Author
**Kareem Hamdy Meshal**

I'm always open to feedback and would love to connect with you! Feel free to reach out on my social platforms:

- 💼 [LinkedIn]([https://linkedin.com/in/your_username](https://www.linkedin.com/in/kareem-meshal-7706951a0/))
- 📧 Email: Kareemkhdh543@gmail.com

Let me know what you think about this project and how I can improve!

