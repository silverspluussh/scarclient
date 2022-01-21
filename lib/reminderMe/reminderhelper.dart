import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Duration offsetTime = DateTime.now().timeZoneOffset;

  NotificationService._internal();
  Future<void> initNotification() async {
    tz.initializeTimeZones();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_launcher');

    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int hours, minutes) async {
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local)
          .add(Duration(hours: hours, minutes: minutes))
          .subtract(offsetTime),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_launcher'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> repeatNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(id.toString(), title,
            channelDescription: body, importance: Importance.min);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, RepeatInterval.daily, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  Future<void> schedulecustomNotification(
    int id,
    String title,
    String body,
    int hours,
    minutes,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      schedulecustomtime(hours, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          title,
          channelDescription: body,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  tz.TZDateTime schedulecustomtime(int hour, minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, now.hour, now.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate =
          scheduledDate.add(Duration(days: 1, hours: hour, minutes: minute));
    }
    return scheduledDate;
  }
}
