# Flutter Chat App with Firebase

A real-time chat application developed in Flutter, using Firebase as the backend. This app allows users to send text messages and images to each other in real-time.

## Key Features

- Sending text messages.
- Sending and receiving images.
- User authentication using Firebase Authentication.
- Storing messages in Firebase Firestore.
- Storing images in Firebase Storage.

## Requirements

- Flutter installed. [Flutter Installation](https://flutter.dev/docs/get-started/install)
- Firebase account. [Firebase Console](https://console.firebase.google.com/)

## Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/repository-name.git
    cd repository-name

2. Add the google-services.json file (for Android) and GoogleService-Info.plist file (for iOS) to the android/app and ios/Runner directories, respectively, following the instructions in the Firebase documentation.
3. Installation of Dependencies
    ```bash
    flutter pub get

4. Run the app:
    ```bash
    flutter run

## Firebase Configuration

Before running the app, ensure that your Firebase project is properly configured:

1. **Enable Firebase Authentication** for user authentication. This allows users to create accounts and log in securely.

2. **Configure Firebase Firestore** for message storage. Firestore will be used to store and retrieve chat messages in real-time.

3. **Configure Firebase Storage** for image storage. This is necessary for sending and receiving images within the chat.

Make sure to follow Firebase's official documentation for setting up these components in your Firebase project.

For authentication setup, refer to the [Firebase Authentication Documentation](https://firebase.google.com/docs/auth).

For Firestore configuration, please follow the steps in the [Firebase Firestore Documentation](https://firebase.google.com/docs/firestore).

To set up Firebase Storage, consult the [Firebase Storage Documentation](https://firebase.google.com/docs/storage).

Once your Firebase project is configured correctly, you'll be ready to use these features in your app.


