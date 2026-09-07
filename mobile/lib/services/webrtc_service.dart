import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  static final WebRTCService _instance = WebRTCService._internal();
  
  late RTCPeerConnection peerConnection;
  late RTCDataChannel dataChannel;
  MediaStream? localStream;
  MediaStream? remoteStream;

  // Callbacks
  Function? onRemoteStream;
  Function? onIceCandidate;
  Function? onConnectionStateChange;

  WebRTCService._internal();

  factory WebRTCService() {
    return _instance;
  }

  Future<void> initialize() async {
    final config = <String, dynamic>{
      'iceServers': [
        {
          'urls': ['stun:stun.l.google.com:19302'],
        },
      ],
    };

    peerConnection = await createPeerConnection(config);

    peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      onIceCandidate?.call(candidate);
    };

    peerConnection.onAddStream = (MediaStream stream) {
      remoteStream = stream;
      onRemoteStream?.call(stream);
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) {
      onConnectionStateChange?.call(state);
    };
  }

  Future<void> getLocalStream() async {
    try {
      final stream = await navigator.mediaDevices.getUserMedia({
        'audio': {'echoCancellation': true},
        'video': false,
      });
      localStream = stream;
      await peerConnection.addStream(stream);
    } catch (e) {
      print('Error getting local stream: $e');
    }
  }

  Future<RTCSessionDescription> createOffer() async {
    final offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);
    return offer;
  }

  Future<RTCSessionDescription> createAnswer() async {
    final answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);
    return answer;
  }

  Future<void> setRemoteDescription(RTCSessionDescription description) async {
    await peerConnection.setRemoteDescription(description);
  }

  Future<void> addIceCandidate(RTCIceCandidate candidate) async {
    await peerConnection.addCandidate(candidate);
  }

  Future<void> cleanup() async {
    await localStream?.getTracks().forEach((track) {
      track.stop();
    });
    await peerConnection.close();
  }
}
