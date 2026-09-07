# Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Flutter Mobile App                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Screens (UI Layer)                                  │   │
│  │  - LoginScreen                                       │   │
│  │  - HomeScreen                                        │   │
│  │  - RoomScreen                                        │   │
│  │  - CallScreen                                        │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Services (Business Logic)                           │   │
│  │  - SocketService (Real-time)                         │   │
│  │  - WebRTCService (P2P Voice)                         │   │
│  │  - AuthService (Authentication)                      │   │
│  │  - UserService (Profile Management)                  │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Models (Data Layer)                                 │   │
│  │  - User                                              │   │
│  │  - Room                                              │   │
│  │  - Message                                           │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
         ↑                                           ↑
         │        WebSocket & REST API              │
         │        (Socket.io & HTTP)                │
         ↓                                           ↓
┌─────────────────────────────────────────────────────────────┐
│                  Node.js Backend Server                      │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Routes / Controllers                                │   │
│  │  - AuthController                                    │   │
│  │  - UserController                                    │   │
│  │  - RoomController                                    │   │
│  │  - MessageController                                 │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Services (Business Logic)                           │   │
│  │  - AuthService                                       │   │
│  │  - RoomService                                       │   │
│  │  - WebRTC Signaling                                  │   │
│  │  - MessageService                                    │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Socket.io Event Handlers                            │   │
│  │  - Connection Management                             │   │
│  │  - Room Management                                   │   │
│  │  - WebRTC Signaling                                  │   │
│  │  - Message Broadcasting                              │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Database Layer (Models)                             │   │
│  │  - User Model                                        │   │
│  │  - Room Model                                        │   │
│  │  - Message Model                                     │   │
│  │  - Session Model                                     │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                           ↓
                    ┌──────────────┐
                    │   MongoDB    │
                    │   Database   │
                    └──────────────┘
```

## Technology Stack

### Frontend (Mobile)
- **Framework**: Flutter 3.0+
- **State Management**: Riverpod / Provider
- **Real-time Communication**: Socket.io Client
- **P2P Communication**: flutter_webrtc
- **Storage**: Hive / Shared Preferences
- **Authentication**: Firebase Auth

### Backend
- **Runtime**: Node.js 16+
- **Framework**: Express.js
- **Real-time**: Socket.io
- **Database**: MongoDB
- **Authentication**: JWT (JSON Web Tokens)
- **Validation**: Express Validator
- **Security**: bcryptjs, helmet

### DevOps & Deployment
- **Backend Hosting**: Heroku / AWS / Digital Ocean
- **Database**: MongoDB Atlas
- **Mobile Distribution**: Google Play Store / Apple App Store

## Data Flow

### User Registration Flow

```
1. User fills registration form (Flutter App)
   ↓
2. Send POST /api/auth/register (Backend)
   ↓
3. Backend validates data
   ↓
4. Hash password with bcryptjs
   ↓
5. Store in MongoDB
   ↓
6. Generate JWT token
   ↓
7. Return token to app
   ↓
8. App stores token locally
   ↓
9. Navigate to home screen
```

### Real-time Messaging Flow

```
1. User sends message (Flutter App)
   ↓
2. emit('send-message', {roomId, text})
   ↓
3. Socket.io receives event (Backend)
   ↓
4. Validate message
   ↓
5. Save to MongoDB
   ↓
6. io.to(roomId).emit('receive-message', message)
   ↓
7. All users in room receive message
```

### WebRTC Voice Call Flow

```
1. User initiates call
   ↓
2. Flutter app gets local media stream
   ↓
3. Create WebRTC offer
   ↓
4. Send offer via Socket.io to peer
   ↓
5. Backend relays offer to target user
   ↓
6. Target user creates answer
   ↓
7. Send answer back via Socket.io
   ↓
8. Exchange ICE candidates
   ↓
9. P2P connection established
   ↓
10. Voice data flows directly peer-to-peer
```

## File Structure

```
voice-chat-social-party/
├── backend/
│   ├── src/
│   │   ├── server.js              # Main server file
│   │   ├── routes/                # API endpoints
│   │   │   ├── auth.js
│   │   │   ├── users.js
│   │   │   ├── rooms.js
│   │   │   └── messages.js
│   │   ├── controllers/           # Business logic
│   │   │   ├── authController.js
│   │   │   ├── userController.js
│   │   │   ├── roomController.js
│   │   │   └── messageController.js
│   │   ├── models/                # Database schemas
│   │   │   ├── User.js
│   │   │   ├── Room.js
│   │   │   ├── Message.js
│   │   │   └── Session.js
│   │   ├── middleware/            # Custom middleware
│   │   │   ├── auth.js
│   │   │   └── errorHandler.js
│   │   └── utils/                 # Helper functions
│   │       ├── validators.js
│   │       └── logger.js
│   ├── package.json
│   ├── .env.example
│   └── .gitignore
│
├── mobile/
│   ├── lib/
│   │   ├── main.dart              # App entry point
│   │   ├── screens/               # UI screens
│   │   │   ├── splash_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── home_screen.dart
│   │   │   ├── room_screen.dart
│   │   │   └── call_screen.dart
│   │   ├── widgets/               # Reusable UI components
│   │   │   ├── room_card.dart
│   │   │   ├── message_bubble.dart
│   │   │   └── user_avatar.dart
│   │   ├── models/                # Data models
│   │   │   ├── user_model.dart
│   │   │   ├── room_model.dart
│   │   │   └── message_model.dart
│   │   ├── services/              # Business logic
│   │   │   ├── socket_service.dart
│   │   │   ├── webrtc_service.dart
│   │   │   ├── auth_service.dart
│   │   │   └── user_service.dart
│   │   ├── providers/             # State management
│   │   │   ├── auth_provider.dart
│   │   │   ├── room_provider.dart
│   │   │   └── user_provider.dart
│   │   └── constants/             # App constants
│   │       ├── colors.dart
│   │       └── strings.dart
│   ├── pubspec.yaml
│   ├── android/
│   └── ios/
│
├── docs/
│   ├── API.md                     # API documentation
│   ├── SETUP.md                   # Setup guide
│   ├── ARCHITECTURE.md            # This file
│   └── CONTRIBUTING.md            # Contribution guidelines
│
├── README.md
├── .gitignore
├── LICENSE
└── CHANGELOG.md
```

## Component Responsibilities

### SocketService (Mobile)
- Manages Socket.io connection
- Emits and listens to events
- Handles reconnection logic
- Manages user presence

### WebRTCService (Mobile)
- Initializes peer connections
- Manages local/remote streams
- Handles offer/answer creation
- Manages ICE candidates

### Socket Event Handlers (Backend)
- `connection`: Handle new user connection
- `user-join`: Register user
- `create-room`: Create new room
- `join-room`: Add user to room
- `send-message`: Handle message broadcast
- `offer/answer/ice-candidate`: WebRTC signaling
- `disconnect`: Clean up user resources

## Authentication Flow

```
1. User registers/logs in
2. Backend validates credentials
3. Backend generates JWT token
4. Token sent to mobile app
5. App stores token in secure storage
6. Token included in all API requests
7. Backend validates token before processing
8. Token refresh on expiry
```

## Error Handling

### Backend
- Express error middleware
- Validation error handling
- Database error handling
- Socket.io error events

### Mobile
- Try-catch blocks in services
- User-friendly error messages
- Connection error recovery
- Automatic reconnection

## Security Considerations

1. **Authentication**: JWT with secure expiry
2. **Data Encryption**: HTTPS/WSS for transport
3. **Input Validation**: Server-side validation
4. **Rate Limiting**: Prevent abuse
5. **CORS**: Restrict origins
6. **XSS Prevention**: Input sanitization
7. **CSRF Protection**: Token validation

## Performance Optimization

1. **Client-side**:
   - Lazy loading screens
   - Image caching
   - Connection pooling
   
2. **Server-side**:
   - Database indexing
   - Query optimization
   - Caching strategies
   - Load balancing

## Scalability

- Horizontal scaling with Redis
- Database sharding for large datasets
- CDN for static assets
- Load balancer for multiple servers
- Microservices architecture ready

## Future Enhancements

- Video calling support
- Screen sharing
- File sharing in chat
- User blocking/muting
- Room recording
- End-to-end encryption
- Mobile push notifications
- Desktop applications
