import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Show notification when the background task is executed
    await showNotification();
    return Future.value(true);
  });
}

void scheduleNotification() {
  Workmanager().registerOneOffTask(
    "uniqueTaskName",
    "showNotificationTask",
    initialDelay: Duration(seconds: 5), // Adjust delay as needed
  );
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'com.google.firebase.messaging.default_notification_channel_id',
          'high_importance_channel',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await FlutterLocalNotificationsPlugin().show(0, 'Background Notification',
      'The task has completed', platformChannelSpecifics);
}
