import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      // Handle foreground notifications
    });
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
