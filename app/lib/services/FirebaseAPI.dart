import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI
{
    final firebaseMessaging = FirebaseMessaging.instance;

    Future<void> initNotifications() async
    {
        await firebaseMessaging.requestPermission();
        print('Token: ${await firebaseMessaging.getToken()}');
    }
}
