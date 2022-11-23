import 'package:amity_sdk/amity_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static Future<String> getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final fcmToken = await messaging.getToken();
    return fcmToken ?? "";
  }

  void registerNotification(String fcmToken) {
    // example of getting token from firebase
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // final fcmToken = await messaging.getToken();
    AmityCoreClient.registerDeviceNotification(fcmToken).then((value) {
      print("Register Device Notification Successful");
    }).onError((error, stackTrace) {
      //handle error
    });
  }

  void unregisterNotification() {
    AmityCoreClient.unregisterDeviceNotification()
        .then((value) => {
              //success
            })
        .onError((error, stackTrace) => {
              //handle error
            });
  }
}
