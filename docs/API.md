# API Documentation

## Socket.io Events

### Authentication Events

#### `user-join`
User joins the application
```json
{
  "userId": "socket-id",
  "username": "john_doe",
  "email": "john@example.com"
}
```

### Room Events

#### `create-room`
Create a new chat room
```json
{
  "roomId": "room-123",
  "roomName": "Party Room 1",
  "isPrivate": false,
  "maxUsers": 10
}
```

**Response:** `room-created`

#### `join-room`
Join an existing room
```
Emit: "join-room"
Data: "room-id"
```

**Response:** `user-joined`

#### `leave-room`
Leave a room
```
Emit: "leave-room"
Data: "room-id"
```

**Response:** `user-left`

### Message Events

#### `send-message`
Send a text message in a room
```json
{
  "roomId": "room-123",
  "text": "Hello everyone!",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

**Response:** `receive-message`

### WebRTC Events

#### `offer`
Send WebRTC offer to peer
```json
{
  "to": "peer-socket-id",
  "offer": {
    "type": "offer",
    "sdp": "..."
  }
}
```

**Response:** `offer` (received by target peer)

#### `answer`
Send WebRTC answer to peer
```json
{
  "to": "peer-socket-id",
  "answer": {
    "type": "answer",
    "sdp": "..."
  }
}
```

**Response:** `answer` (received by target peer)

#### `ice-candidate`
Send ICE candidate for NAT traversal
```json
{
  "to": "peer-socket-id",
  "candidate": {
    "candidate": "...",
    "sdpMLineIndex": 0,
    "sdpMid": "0"
  }
}
```

**Response:** `ice-candidate` (received by target peer)

## Server Response Events

### User Events

#### `user-list`
Broadcasted when user list updates
```json
[
  {
    "userId": "socket-id-1",
    "username": "user1",
    "email": "user1@example.com"
  },
  {
    "userId": "socket-id-2",
    "username": "user2",
    "email": "user2@example.com"
  }
]
```

#### `user-joined`
Emitted when user joins a room
```json
{
  "userId": "socket-id",
  "username": "john_doe"
}
```

#### `user-left`
Emitted when user leaves a room
```json
{
  "userId": "socket-id"
}
```

### Room Events

#### `room-created`
Emitted when new room is created
```json
{
  "roomId": "room-123",
  "roomName": "Party Room 1",
  "isPrivate": false,
  "maxUsers": 10,
  "createdAt": "2024-01-01T00:00:00Z"
}
```

### Message Events

#### `receive-message`
Emitted when new message is received
```json
{
  "from": "socket-id",
  "username": "john_doe",
  "text": "Hello everyone!",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## REST API Endpoints

### Health Check

#### GET `/api/health`
Check server status

**Response:**
```json
{
  "status": "Server is running",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## Connection Flow

### 1. Initial Connection
```
Client → Server
socket.connect()
```

### 2. User Joins
```
Client → Server
emit('user-join', { userId, username, email })

Server → All Clients
emit('user-list', [...users])
```

### 3. Create Room
```
Client → Server
emit('create-room', { roomId, roomName, isPrivate, maxUsers })

Server → All Clients
emit('room-created', roomData)
```

### 4. Join Room
```
Client → Server
emit('join-room', roomId)
socket.join(roomId)

Server → Room Clients
emit('user-joined', { userId, username })
```

### 5. WebRTC Setup
```
Caller → Server → Callee
emit('offer', { to, offer })
emit('answer', { to, answer })
emit('ice-candidate', { to, candidate })
```

### 6. Send Message
```
Client → Server
emit('send-message', { roomId, text })

Server → Room Clients
emit('receive-message', messageData)
```

### 7. Leave Room
```
Client → Server
emit('leave-room', roomId)
socket.leave(roomId)

Server → Room Clients
emit('user-left', { userId })
```

## Error Handling

All errors are emitted as `error` event:
```json
{
  "code": "ERROR_CODE",
  "message": "Error description"
}
```

### Common Error Codes
- `ROOM_NOT_FOUND` - Room does not exist
- `USER_NOT_FOUND` - User not found
- `INVALID_DATA` - Invalid request data
- `CONNECTION_FAILED` - Failed to establish connection
- `PERMISSION_DENIED` - User doesn't have permission

## Rate Limiting

- Messages: 10 per second per user
- Room creation: 5 per minute per user
- Connection attempts: 20 per minute per IP

## Best Practices

1. **Always handle disconnections gracefully**
   ```javascript
   socket.on('disconnect', () => {
     // Clean up resources
   });
   ```

2. **Validate data on both client and server**
   ```javascript
   if (!roomId || !text) {
     emit('error', { message: 'Invalid data' });
     return;
   }
   ```

3. **Use proper error handlers**
   ```javascript
   socket.on('error', (error) => {
     console.error('Socket error:', error);
   });
   ```

4. **Keep alive with heartbeat**
   ```javascript
   setInterval(() => {
     socket.emit('ping');
   }, 30000);
   ```

## Testing

Use a WebSocket client like:
- **Socket.io Testing Tool**: https://amritb.github.io/socketio-client-tool/
- **Postman**: For REST endpoints
- **Flutter WebSocket Tools**: For mobile testing

## Changelog

### Version 1.0.0
- Initial release
- Basic room creation and joining
- Text messaging
- WebRTC signaling
- User presence
