import 'dart:io';
import 'package:almanubis/core/util/notificationHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';

class FirebaseNotifications {
  late FirebaseMessaging _messaging;
  late BuildContext myContext;

  void setUpFirebase({
    required BuildContext context,
    required UserModel userModel,
  }) {
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessageListener(context: context, userModel: userModel);
    myContext = context;
  }

  firebaseCloudMessageListener({
    required BuildContext context,
    required UserModel userModel,
  }) async {
    _messaging.getToken().then((token) {
      userModel.token = token;
      BlocProvider.of<AuthBloc>(context).add(SetDataUserEvent(userModel: userModel));
    });
    _messaging
        .subscribeToTopic('edmtdev_demo')
        .whenComplete(() => print('subscribe ok'));

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      if (Platform.isIOS) {
        showNotification(
          remoteMessage.data['title'],
          remoteMessage.data['body'],
          context,
          userModel,
        );
      } else if (Platform.isAndroid) {
        showNotification(
          remoteMessage.notification!.title!,
          remoteMessage.notification!.body!,
          context,
          userModel,
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      if (Platform.isIOS) {
        handledGoDailyReport(
          context: context,
          userModel: userModel,
        );
      }
      if (Platform.isAndroid) {
        handledGoDailyReport(
          context: context,
          userModel: userModel,
        );
      }
    });
    // ignore: missing_return
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void showNotification(title, body, context, userModel) async {
    print(body);
  }
}

Future<void> handledGoDailyReport({
  required BuildContext context,
  required UserModel userModel,
}) async {
  late FirebaseFirestore firebaseFirestore;
  firebaseFirestore = FirebaseFirestore.instance;
  try {

  } catch (e) {
    print(e);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
