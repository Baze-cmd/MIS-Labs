import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService
{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    Future<void> initialize() async
    {
        tz.initializeTimeZones();
        const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
        await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }

    Future<void> scheduleNotification(DateTime date) async
    {
        var androidDetails = const AndroidNotificationDetails(
            'Event', 'Event Notifications',
            importance: Importance.max,
            priority: Priority.high
        );

        var notificationDetails = NotificationDetails(android: androidDetails);

        await flutterLocalNotificationsPlugin.zonedSchedule(
            0,
            'Event Reminder',
            'Event coming up at ${date.toString()}',
            tz.TZDateTime.from(date, tz.local),
            notificationDetails,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
        );
    }
}
