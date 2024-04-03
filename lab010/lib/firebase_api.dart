import 'package:firebase_messaging/firebase_messaging.dart';

Future <void> handleBackgroundMessage(RemoteMessage message) async{
print('title: ${message.notification?.title}');
print('body: ${message.notification?.body}');
print('payload: ${message.data}');
}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future <void> initNotification() async{
    await _firebaseMessaging.requestPermission();
    final fCNToken = await _firebaseMessaging.getToken();
    print('Token: $fCNToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}