# photo-a-day
An app for reminding you to take a photo a day to create timelapses and collages.

## Firebase Setup Instructions:

1. Go to the [Firebase Console](https://console.firebase.google.com/) and sign in with your Google account.

2. Click on the "Add project" button to create a new Firebase project.

5. Add Android/iOS Apps:

    Once your project is created, click on the "Add app" button to add your Flutter app to Firebase.

    For Android, enter the package name of your Flutter app (usually something like com.example.myapp) and click "Register app."
  
    For iOS, enter the iOS bundle identifier and click "Register app."

5. Download Configuration Files:

    For Android: After registering your Android app, you'll be prompted to download the _google-services.json_ file. Download it to your local machine.

    For iOS: After registering your iOS app, you'll be prompted to download the _GoogleService-Info.plist_ file. Download it to your local machine.

6. Place Configuration Files Accordingly:

    For Android: Move the downloaded _google-services.json_ file into the ```android/app/``` directory.
   
    For iOS: Move the downloaded _GoogleService-Info.plist_ file into the ```ios/``` directory.

## Adding SHA-1 to Firebase for Android login
https://stackoverflow.com/questions/39144629/how-to-add-sha-1-to-android-application
