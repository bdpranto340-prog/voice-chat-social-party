# Setup Guide

## Prerequisites

- **Node.js** v16 or higher
- **Flutter** v3.0 or higher
- **MongoDB** (Local or Cloud Atlas)
- **Android Studio** (for Android development)
- **Xcode** (for iOS development)
- **VS Code** or any preferred code editor

## Backend Setup

### 1. Navigate to Backend Directory

```bash
cd backend
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Environment Configuration

```bash
cp .env.example .env
```

Edit `.env` file with your configuration:

```
PORT=3000
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/voice-chat
JWT_SECRET=your_secure_secret_key_here
```

### 4. Start MongoDB

**Local MongoDB:**
```bash
mongod
```

**Or use MongoDB Atlas (Cloud):**
- Create account at https://www.mongodb.com/cloud/atlas
- Create a cluster and get connection string
- Update `MONGODB_URI` in `.env`

### 5. Start Backend Server

**Development Mode:**
```bash
npm run dev
```

**Production Mode:**
```bash
npm start
```

Server will run at `http://localhost:3000`

## Mobile Setup

### 1. Navigate to Mobile Directory

```bash
cd mobile
```

### 2. Get Flutter Dependencies

```bash
flutter pub get
```

### 3. Generate Required Files (if using Hive)

```bash
flutter pub run build_runner build
```

### 4. Update Backend URL

Edit `lib/main.dart` or create a config file with your backend server URL.

## Android Setup

### Prerequisites

- Android Studio installed
- Android SDK (API level 21+)
- AVD (Android Virtual Device) created or physical device connected

### Steps

1. **Create AVD (if needed):**
   - Open Android Studio
   - AVD Manager → Create Virtual Device
   - Select desired API level (21+)

2. **Run App:**
   ```bash
   flutter run
   ```

3. **Or Build APK:**
   ```bash
   flutter build apk --release
   ```

### Permissions Required (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

## iOS Setup

### Prerequisites

- Xcode 13+
- iOS 12.0+
- CocoaPods

### Steps

1. **Navigate to iOS Directory:**
   ```bash
   cd mobile/ios
   ```

2. **Install CocoaPods:**
   ```bash
   pod install
   ```

3. **Update Podfile Deployment Target:**
   ```
   platform :ios, '12.0'
   ```

4. **Return to Project Root:**
   ```bash
   cd ../..
   ```

5. **Run App:**
   ```bash
   flutter run
   ```

6. **Or Build IPA:**
   ```bash
   flutter build ipa --release
   ```

### Info.plist Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice chat</string>
<key>NSCameraUsageDescription</key>
<string>This app needs camera access for video calls</string>
```

## Verification

### Backend Health Check

```bash
curl http://localhost:3000/api/health
```

Response should be:
```json
{
  "status": "Server is running",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

### Mobile App

- App should load splash screen
- Navigate to login screen
- Create account or login with test credentials

## Troubleshooting

### Backend Issues

1. **Port Already in Use:**
   ```bash
   # Change PORT in .env or kill process using port 3000
   lsof -i :3000
   kill -9 <PID>
   ```

2. **MongoDB Connection Error:**
   - Ensure MongoDB is running
   - Check connection string in `.env`
   - Verify network access (for Atlas)

3. **Socket.io Connection Failed:**
   - Check CORS settings in `server.js`
   - Ensure frontend URL is allowed

### Mobile Issues

1. **Flutter Dependencies Error:**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Android Build Error:**
   ```bash
   flutter clean
   cd android
   ./gradlew clean
   cd ..
   flutter run
   ```

3. **iOS Build Error:**
   ```bash
   flutter clean
   cd ios
   rm -rf Pods
   pod install
   cd ..
   flutter run
   ```

4. **Permission Denied (Android):**
   - Go to Settings → Apps → Voice Chat → Permissions
   - Enable Microphone and Camera permissions

## Development Tips

- Use `flutter run -v` for verbose output
- Use Chrome DevTools: `flutter run -d chrome`
- Use `npm run dev` for backend with auto-reload
- Check Flutter doctor: `flutter doctor`

## Next Steps

1. Configure Firebase for authentication
2. Set up MongoDB Atlas for cloud database
3. Configure WebRTC TURN servers
4. Implement proper authentication flow
5. Add error handling and logging
6. Test on real devices
7. Prepare for deployment

For more information, see [API.md](./API.md) and [ARCHITECTURE.md](./ARCHITECTURE.md)
