import 'package:chatapp_firebase/utils/services/notify_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper
{
  static FCMHelper helper = FCMHelper._();
  FCMHelper._();

  FirebaseMessaging messaging  = FirebaseMessaging.instance;

  Future<void> receiveMSG()
  async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("=============== $fcmToken ============");

    FirebaseMessaging.onMessage.listen(
      (event) {
        if (event.notification != null)
          {
            String? title = event.notification!.title;
            String?  body= event.notification!.body;
            String? imageUrl = event.notification!.android!.imageUrl;

            if(title != null && body != null && imageUrl == null)
              {
                NotificationService.notificationService.showSimpleNotification(title, body);
              }
            else if(title != null && body != null && imageUrl != null )
            {
               NotificationService.notificationService.showBigPictureNotification(title, body, imageUrl);
            }
          }
      },
    );
  }
}