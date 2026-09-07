# এপ্লিকেশন সেটআপ গাইড

এই গাইড অনুসরণ করে Voice Chat Social Party অ্যাপ্লিকেশনটি সেটআপ করুন।

## সিস্টেম প্রয়োজনীয়তা (Prerequisites)

আপনার কম্পিউটারে নিম্নলিখিত সফটওয়্যার ইনস্টল থাকতে হবে:

- **Node.js** - সংস্করণ ১৬ বা উচ্চতর
- **Flutter** - সংস্করণ ৩.০ বা উচ্চতর
- **MongoDB** - স্থানীয় বা ক্লাউড সংস্করণ
- **Git** - ভার্সন কন্ট্রোলের জন্য
- **Code Editor** - VS Code বা অন্য যেকোনো এডিটর

### অপারেটিং সিস্টেম অনুযায়ী:

**Windows/Mac এর জন্য অতিরিক্ত প্রয়োজনীয়তা:**
- **Android Studio** - অ্যান্ড্রয়েড অ্যাপ তৈরির জন্য
- **Xcode** (শুধুমাত্র Mac) - iOS অ্যাপ তৈরির জন্য

---

## ধাপ ১: রিপজিটরি ক্লোন করুন

```bash
git clone https://github.com/bdpranto340-prog/voice-chat-social-party.git
cd voice-chat-social-party
```

---

## ধাপ ২: ব্যাকএন্ড সেটআপ করুন

### ২.১ ব্যাকএন্ড ডিরেক্টরিতে যান

```bash
cd backend
```

### ২.২ নির্ভরশীল প্যাকেজ ইনস্টল করুন

```bash
npm install
```

এটি সকল প্রয়োজনীয় Node.js প্যাকেজ ডাউনলোড করবে।

### ২.३ পরিবেশ কনফিগারেশন (Environment Setup)

১. `.env.example` ফাইল থেকে `.env` ফাইল তৈরি করুন:

```bash
cp .env.example .env
```

२. `.env` ফাইলটি খুলুন এবং নিম্নলিখিত তথ্য যোগ করুন:

```env
# সার্ভার সেটিংস
PORT=3000
NODE_ENV=development

# ডাটাবেস কনফিগারেশন
MONGODB_URI=mongodb://localhost:27017/voice-chat

# জ্যাট সিক্রেট কী (নিরাপত্তার জন্য)
JWT_SECRET=your_very_secure_secret_key_here_change_this

# সার্ভার URL (প্রয়োজনীয় হলে)
SERVER_URL=http://localhost:3000
```

**নোট:** `JWT_SECRET` একটি শক্তিশালী এবং অনন্য মান হওয়া উচিত।

### २.४ MongoDB সেটআপ করুন

**বিকল্প ১: স্থানীয় MongoDB ব্যবহার করুন**

১. MongoDB ডাউনলোড করুন: https://www.mongodb.com/try/download/community
२. ইনস্টল করুন এবং সার্ভিস চালু করুন
३. টার্মিনালে চালু করুন:

```bash
mongod
```

**বিকল্প २: MongoDB Atlas (ক্লাউড) ব্যবহার করুন**

१. https://www.mongodb.com/cloud/atlas এ একাউন্ট তৈরি করুন
२. একটি নতুন ক্লাস্টার তৈরি করুন
३. Connection String পান
४. `.env` ফাইলে এটি যোগ করুন:

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/voice-chat
```

### २.५ ব্যাকএন্ড সার্ভার চালু করুন

**ডেভেলপমেন্ট মোডে:**

```bash
npm run dev
```

এটি স্বয়ংক্রিয়ভাবে রিলোড হবে যখন আপনি ফাইল পরিবর্তন করবেন।

**প্রোডাকশন মোডে:**

```bash
npm start
```

**সফলতার চিহ্ন:** টার্মিনালে দেখবেন:
```
Server is running on http://localhost:3000
MongoDB connected successfully
```

---

## ধাপ ३: মোবাইল অ্যাপ সেটআপ করুন

### ३.१ মোবাইল ডিরেক্টরিতে যান

```bash
cd mobile
```

### ३.२ Flutter ডিপেন্ডেন্সি ডাউনলোড করুন

```bash
flutter pub get
```

### ३.३ বিল্ড রানার চালান (যদি প্রয়োজন হয়)

```bash
flutter pub run build_runner build
```

### ३.४ ব্যাকএন্ড URL কনফিগার করুন

১. `lib/config/` বা `lib/` ডিরেক্টরিতে `config.dart` খুঁজুন
२. ব্যাকএন্ড সার্ভারের URL আপডেট করুন:

```dart
const String BACKEND_URL = 'http://localhost:3000';
const String SOCKET_URL = 'http://localhost:3000';
```

> **দ্রষ্টব্য:** ডিভাইস থেকে সংযোগ করলে localhost এর পরিবর্তে আপনার কম্পিউটারের IP ব্যবহার করুন:
> ```dart
> const String BACKEND_URL = 'http://192.168.x.x:3000';
> ```

---

## ধাপ ४: অ্যান্ড্রয়েড অ্যাপ চালান

### ४.१ Android Virtual Device (AVD) তৈরি করুন (প্রথমবার)

१. Android Studio খুলুন
२. **AVD Manager** খুলুন
३. **Create Virtual Device** এ ক্লিক করুন
४. একটি ডিভাইস নির্বাচন করুন (যেমন: Pixel 5)
५. Android API লেভেল ২१ বা তার উপরে নির্বাচন করুন

### ४.२ অ্যাপ চালু করুন

**মোবাইল ডিরেক্টরিতে থাকতে হবে:**

```bash
flutter run
```

**বা নির্দিষ্ট ডিভাইসে চালান:**

```bash
flutter run -d emulator-5554
```

### ४.३ APK বিল্ড করুন (রিলিজ এর জন্য)

```bash
flutter build apk --release
```

APK ফাইল পাবেন: `build/app/outputs/flutter-apk/app-release.apk`

### ४.४ প্রয়োজনীয় অনুমতি (AndroidManifest.xml)

নিম্নলিখিত অনুমতি এনেবল করুন:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

---

## ধাপ ५: iOS অ্যাপ চালান (শুধুমাত্র Mac এ)

### ५.१ iOS ডিপেন্ডেন্সি ইনস্টল করুন

```bash
cd mobile/ios
pod install
cd ../..
```

### ५.२ Podfile আপডেট করুন

`mobile/ios/Podfile` খুলুন এবং নিশ্চিত করুন:

```ruby
platform :ios, '12.0'
```

### ५.३ অ্যাপ চালু করুন

```bash
flutter run
```

### ५.४ Info.plist এ অনুমতি যোগ করুন

`ios/Runner/Info.plist` খুলুন এবং যোগ করুন:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice chat</string>
<key>NSCameraUsageDescription</key>
<string>This app needs camera access for video calls</string>
```

### ५.५ IPA বিল্ড করুন

```bash
flutter build ipa --release
```

---

## ধাপ ६: সিস্টেম যাচাই করুন (Verification)

### ६.१ ব্যাকএন্ড স্বাস্থ্য পরীক্ষা

ব্রাউজারে খুলুন বা টার্মিনালে চালান:

```bash
curl http://localhost:3000/api/health
```

সফল প্রতিক্রিয়া:
```json
{
  "status": "Server is running",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

### ६.२ মোবাইল অ্যাপ পরীক্ষা করুন

१. অ্যাপ খোলে (Splash Screen দেখা যায়)
२. Login Screen এ পৌঁছায়
३. নতুন অ্যাকাউন্ট তৈরি করতে পারে
४. লগইন করতে পারে

### ६.३ WebSocket সংযোগ পরীক্ষা

অ্যাপে লগইন করার পর:
- অনলাইন স্ট্যাটাস দেখা যাবে
- চ্যাট বার্তা পাঠাতে পারবেন
- অন্য ব্যবহারকারী তা পাবেন

---

## ট্রাবলশুটিং - সমস্যা এবং সমাধান

### ব্যাকএন্ড সমস্যা

#### সমস্যা: পোর্ট ৩০০০ ইতিমধ্যে ব্যবহৃত

**সমাধান:**

```bash
# Linux/Mac:
lsof -i :3000
kill -9 <PID>

# Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

অথবা `.env` ফাইলে পোর্ট পরিবর্তন করুন:
```env
PORT=3001
```

#### সমস্যা: MongoDB সংযোগ ব্যর্থ

**সমাধান:**
१. MongoDB চালু হয়েছে কিনা যাচাই করুন:

```bash
# Local MongoDB এর জন্য:
mongod

# Atlas এর জন্য চেক করুন নেটওয়ার্ক সংযোগ
```

२. Connection String যাচাই করুন:
```bash
# MongoDB CLI দিয়ে পরীক্ষা করুন:
mongo "mongodb://localhost:27017/voice-chat"
```

३. `.env` ফাইলে সঠিক পথ আছে কিনা নিশ্চিত করুন।

#### সমস্যা: Socket.io সংযোগ ব্যর্থ

**সমাধান:**
१. `server.js` এ CORS সেটিংস চেক করুন
२. ফ্রন্টএন্ড URL হোয়াইটলিস্টে আছে কিনা দেখুন
३. ফায়ারওয়াল সেটিংস যাচাই করুন

---

### মোবাইল অ্যাপ সমস্যা

#### সমস্যা: Flutter ডিপেন্ডেন্সি এরর

**সমাধান:**

```bash
flutter clean
flutter pub get
flutter pub upgrade
```

#### সমস্যা: Android বিল্ড এরর

**সমাধান:**

```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter run
```

Windows এ:
```bash
flutter clean
cd android
gradlew.bat clean
cd ..
flutter run
```

#### সমস্যা: iOS বিল্ড এরর

**সমাধান (শুধুমাত্র Mac):**

```bash
flutter clean
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter run
```

#### সমস্যা: অনুমতি সমস্যা (মাইক্রোফোন/ক্যামেরা)

**সমাধান (Android):**
१. সেটিংস খুলুন
२. অ্যাপ > Voice Chat
३. অনুমতি খুলুন
४. মাইক্রোফোন এবং ক্যামেরা এনেবল করুন

**সমাধান (iOS):**
१. সেটিংস খুলুন
२. আপনার অ্যাপ খুঁজুন
३. মাইক্রোফোন অনুমতি দিন

#### সমস্যা: ব্যাকএন্ডের সাথে সংযোগ হচ্ছে না

**সমাধান:**

१. IP অ্যাড্রেস যাচাই করুন:
```bash
# আপনার কম্পিউটারের IP খুঁজুন:
# Windows: ipconfig
# Mac/Linux: ifconfig
```

२. `lib/config/config.dart` আপডেট করুন:
```dart
const String BACKEND_URL = 'http://YOUR_IP:3000';
```

३. ডিভাইস এবং কম্পিউটার একই নেটওয়ার্কে আছে কিনা নিশ্চিত করুন।

---

## সাধারণ কমান্ড এবং টিপস

### ডেভেলপমেন্ট কমান্ড

```bash
# Flutter সংস্করণ চেক করুন
flutter --version

# সব ডিপেন্ডেন্সি চেক করুন
flutter doctor

# ভার্বোজ মোডে চালান (বেশি তথ্য পেতে)
flutter run -v

# ডিভাইস তালিকা দেখুন
flutter devices

# হট রিলোড (চলমান অ্যাপে পরিবর্তন প্রতিফলিত করুন)
# Press 'R' in terminal

# সম্পূর্ণ রিস্টার্ট
# Press 'Ctrl+C' then flutter run
```

### ব্যাকএন্ড কমান্ড

```bash
# ডেভেলপমেন্ট সার্ভার (auto-reload সহ)
npm run dev

# প্রোডাকশন সার্ভার
npm start

# ডাটাবেস মাইগ্রেশন চালান (যদি থাকে)
npm run migrate

# টেস্ট চালান
npm test
```

---

## নিরাপত্তা সেটিংস

### উৎপাদনের জন্য গুরুত্বপূর্ণ

१. `.env` ফাইলে শক্তিশালী `JWT_SECRET` ব্যবহার করুন:

```env
JWT_SECRET=generate_strong_random_key_here
```

२. CORS সেটিংস সীমিত করুন:

```bash
# শুধুমাত্র আপনার ডোমেইন অনুমোদন করুন
```

३. HTTPS ব্যবহার করুন (প্রোডাকশনে)

४. MongoDB পাসওয়ার্ড সুরক্ষিত করুন

---

## পরবর্তী পদক্ষেপ

1. ✅ ব্যাকএন্ড চালু হয়েছে
२. ✅ মোবাইল অ্যাপ চালু হয়েছে
३. ⬜ Firebase কনফিগারেশন (ঐচ্ছিক)
४. ⬜ WebRTC TURN সার্ভার সেটআপ (ভিডিও কলের জন্য)
५. ⬜ ইমেইল পাঠানোর সার্ভিস যুক্ত করুন
६. ⬜ ক্লাউড ডিপ্লয়মেন্ট সেটআপ করুন

---

## অতিরিক্ত সম্পদ

- 📖 [API ডকুমেন্টেশন](./API.md)
- 🏗️ [আর্কিটেকচার গাইড](./ARCHITECTURE.md)
- 🤝 [অবদান রাখুন](./CONTRIBUTING.md)
- 📝 [মূল README](../README.md)

---

## সাহায্য এবং সহায়তা

যদি কোনো সমস্যা হয়:

१. এই গাইড আবার পড়ুন
२. [ট্রাবলশুটিং](#ট্রাবলশুটিং---সমস্যা-এবং-সমাধান) সেকশন দেখুন
३. GitHub Issues এ একটি ইস্যু খুলুন
४. ডিসকাউন্ট কমিউনিটিতে প্রশ্ন করুন

---

**সফল সেটআপের জন্য শুভেচ্ছা! 🎉**

আপনার Voice Chat Social Party অ্যাপ্লিকেশন এখন সম্পূর্ণভাবে সক্রিয় হওয়া উচিত।
