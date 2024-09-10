import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService {
  static NotificationService notificationService = NotificationService._();
  NotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("logo");

    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await plugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> showSimpleNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("1", "Simple",
            importance: Importance.max, priority: Priority.high);

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await plugin.show(1, " $title", " $body", notificationDetails);
  }

  void showScheduleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("2", "Schedule",
            importance: Importance.max, priority: Priority.high);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await plugin.zonedSchedule(
        2,
        "late",
        "Schedule",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<Uint8List> getByteArray(String link) async {
    var res = await http.get(Uri.parse(link));
    return res.bodyBytes;
  }

  Future<void> showBigPictureNotification(String title,String body,String url)async {

    var data = await getByteArray(url);
    ByteArrayAndroidBitmap androidBitmap = ByteArrayAndroidBitmap(data);
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(androidBitmap);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "3",
      "picture",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await plugin.show(1, " $title", " $body", notificationDetails);
  }

  Future<void> showMediaStyleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails("4", "MediaSound",
        importance: Importance.max, priority: Priority.high,sound: RawResourceAndroidNotificationSound("music")
    );
    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await plugin.show(1, "Simple", "notification", notificationDetails);
  }
}