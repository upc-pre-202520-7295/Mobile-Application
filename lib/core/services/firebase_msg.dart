import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsg {
  final msgService = FirebaseMessaging.instance;

  initFCM()async{
    await msgService.requestPermission();
    var token = await msgService.getToken();

    print("✅✅✅✅✅✅✅✅Firebase Messaging Token: $token");

    FirebaseMessaging.onBackgroundMessage(handleNotification);
    FirebaseMessaging.onMessage.listen(handleNotification);
  }

}
Future<void >handleNotification(RemoteMessage msg) async{
  print("[+] Message from: ${msg.notification?.title}");
  print("[+] Message body: ${msg.notification?.body}");
}
