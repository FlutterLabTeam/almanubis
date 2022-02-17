import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  static late BuildContext myContext;

  static void initNotification(BuildContext context) {
    myContext = context;
    /*var initAndroid = AndroidInitializationSettings("@drawable/launch_background");
    var initIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification,);
    var initSetting = InitializationSettings(android: initAndroid, iOS: initIOS);
    flutterLocalNotificationPlugin.initialize(initSetting, onSelectNotification: onSelectNotification);*/




    var initAndroid = const AndroidInitializationSettings("@drawable/launch_background");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails('rutasChanle', 'rutas', '', playSound: true, sound: RawResourceAndroidNotificationSound('assets/song/AEROTAXISMARY-1.mp3'));
    var initIOS = const IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var initializationSettings = InitializationSettings(android: initAndroid, iOS:  initIOS);
    flutterLocalNotificationPlugin.initialize(initializationSettings);
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS:  iOSPlatformChannelSpecifics);
  }

  static Future onDidReceiveLocalNotification(
    int? id,
    String? title,
    String? body,
    String? payload,
  ) async {
    showDialog(
        context: myContext,
        builder: (builder) => CupertinoAlertDialog(
              title: Text(title??""),
              content: Text(body??""),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  isDefaultAction: true,
                  onPressed: () => Navigator.of(myContext, rootNavigator: true).pop('false'),
                ),
              ],
            ));
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) print('get payload: $payload');
  }
}
