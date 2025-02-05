import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:push_notification/global_variables.dart';
import 'package:push_notification/helper_functions.dart';
import 'package:push_notification/main.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    print('Token $token');
    return token!;
  }

  Future<String> getAccessToken() async {
    // Your client ID and client secret obtained from Google Cloud Console
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "demoamigoapp",
      "private_key_id": "001b09c02bf62a829a4566eeae1630da4763aba5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCsyO5eZF6QTsVX\nmSKgs0ZcgtGhC2IQZKl6cEq+jQk3rG/37OCD8DpR3vW9P/t9Ev+RcrP1P4KL1t8a\nMRNrHM8v3lqFhN111H06BEATWIzCOq4ibcgwhIaQrTpo32dgtj/wCZkm+x/ybK9k\nvXGF/sbIvU7TPHDiOnLdZi8xv9RgIQBVfdCiBtZV4Zv1mcyifaF/YxJRyKYWN/pe\nLHp/FHIZO7nFR1bzUBY4ufJjcMpvrYD2bgjVBpXzULwo/67YDiNgzHOsQog8XJzO\nwbhVG/xEMF4e4TOrjMj2O/Zb7tfo/6Q3wOxM5Tj051lHWo+HWdUJehkrU2/+LfMT\nbiJ0uEndAgMBAAECggEACx+IUOVPPSUFCUWfeA7yeaQmUKLF9l40luBBv5CexknA\nj4pdTcEaUAj1cvB6hSvC7h8fPKuRAOWdSTddk6iwIdnDpBLQmvRJ94EsitJJhXt3\nmFnO6GivrQKp3vR62DwDU7WaeWrzPI0IoYiclU64h1XAjFK4xaeTm3MnmKFLz8BV\nAA2aoPlMypGQAVvooe8skSZqvKMFZ/B1HomX1UTW7mbFqmpE9BoAgdlc2IYSwUtO\naCQKKNjxbUU0negCGLIwzMBmxHBsi3kLi61FI53SoHO4Hv63JLDFuKsZ/MqrE6pG\nERFV9J9N3frcxsYuk9567+6++Zc2UxPIXDzKTshlgQKBgQDfARslPDDKXvloxrz1\n9LsAKnEltV6PA2tCScAIwv1CkPzoVCM6i2ZtPwmB6kjN6FXvs4nmEE9fvJVvqRs6\nF8+6JEXafNrTEkYEjZ52qtBZcfHApX2eIF4qcjv4ZN+AefKdyww78Sl5llUmv41y\noD/gvT1swhU6+HiTOJ1v8gQl4QKBgQDGWaCznWvf65l3RLY/ep7cSoJnuSE2oNra\nfASpoJ+T0XDfkYwHoa5Ht72A7IKAPPJ/B+KZw70UtOc8iNW2DuzzhlvJ+tiw3M88\nhr8WpsdIZQDe9oRH+QOiX0zz1p4+9dsafQD1p6+0IHQOJVLTW6j724RHbDRxcJ3O\nC2i5FvUrfQKBgQCQU5fs9lKhduw2GoGLMVOhnNZT0Fkdd9oAMdj+Eqx0W3/DIUkX\nh8bHp4eQtD9gPCD6HJl/80hbrqKMfMapR2Xik7091ZaOCoKUSc+n/48OhIcw5iox\nn8Mx93LGpQpdjQ8vfo0xcjgkf94mUMzLxdjxq6hIbiftXYgzx+1k2R5EIQKBgC1w\nvxYnDF2iNehS/4WPa/F/yFxG10sSktDW9KJ/v883fipZx8C/05NujqWIiWUjkVJ0\n1f7wDtM9lnQRzRQGW1Z3A3REWXw7Oebd380qrCDzsr1hsHBkpeZ++rwqANrfrDBn\nTt74aZJUlQHgnxb4ur/oTGeobGNIr35Sss0ka0ppAoGBAM7wWoP8mcapD7a9Z0Ft\nq3hYDcs6DysWl82HflU4N1AqHa0tLW4Ge7xtFN5fxeLeZa3w/iS3fU2Cv8kYW9Ib\n17Hsyw8ZfF6n7htAIkYGTnyPaJW3Fca30sVs97S7clj2dklYCYMcfjeB4RY2Sb4n\nCL2zdbF7fs9dK63W8V+ziBk5\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-3gvge@demoamigoapp.iam.gserviceaccount.com",
      "client_id": "106527822095636339543",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-3gvge%40demoamigoapp.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage() async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    print("serverKey : $serverKey");

    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/demoamigoapp/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token':
            currentFCMToken, // Token of the device you want to send the message to
        'notification': {
          'body': 'This is an FCM notification message!',
          'title': 'FCM Message'
        },
        'data': {
          'redirect_url': 'FPN/FPN30NOV2023001568',
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }

  void isRefreshToken() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('TOken Refereshed');
    });
  }

  void requestNotificationPermisions() async {
    NotificationSettings notificationSettings =
        await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      HelperFunctions.showAlert(
          "permission", 'user is already granted permisions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      HelperFunctions.showAlert(
          "permission", 'user is already granted provisional permisions');
    } else {
      HelperFunctions.showAlert("permission", 'User has denied permission');
    }
  }

  // For IoS
  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      print("Notification title: ${notification!.title}");
      print("Notification title: ${notification!.body}");
      print("Data: ${message.data.toString()}");

      // For IoS
      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        // Always initialize Awesome Notifications
        NotificationController.initializeLocalNotifications();
        NotificationController.initializeIsolateReceivePort();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: -1, // -1 is replaced by a random number
                channelKey: 'alerts',
                title: '${notification!.title}',
                body: '${notification!.body}',
                //'asset://assets/images/balloons-in-sky.jpg',
                notificationLayout: NotificationLayout.BigPicture,
                payload: {'notificationId': '1234567890'}));

        // initLocalNotifications(context, message);
        // showNotification(message);
      }
    });
  }

  // void initLocalNotifications(
  //     BuildContext context, RemoteMessage message) async {
  //   var androidInitSettings =
  //       const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitSettings = const DarwinInitializationSettings();

  //   var initSettings = InitializationSettings(
  //       android: androidInitSettings, iOS: iosInitSettings);

  //   await _flutterLocalNotificationsPlugin.initialize(initSettings,
  //       onDidReceiveNotificationResponse: (payload) {
  //     handleMesssage(context, message);
  //   });
  // }

  void handleMesssage(BuildContext context, RemoteMessage message) {
    print('In handleMesssage function ${message.data.toString()}');
    var data = message.data;
    GlobalVariables.redirectURL = data['redirect_url'];
    GlobalVariables.lauchViaNotification = true;
    GlobalVariables.deviceToken = data['device_token'];
    HelperFunctions.showAlert("notification ", GlobalVariables.redirectURL);
    HelperFunctions.showAlert("notification lauchViaNotification",
        GlobalVariables.lauchViaNotification.toString());
  }

  // Future<void> showNotification(RemoteMessage message) async {
  //   AndroidNotificationChannel androidNotificationChannel =
  //       AndroidNotificationChannel(
  //           message.notification!.android!.channelId.toString(),
  //           message.notification!.android!.channelId.toString(),
  //           importance: Importance.max,
  //           showBadge: true,
  //           playSound: true);

  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(androidNotificationChannel.id.toString(),
  //           androidNotificationChannel.name.toString(),
  //           channelDescription: 'Flutter Notifications',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           playSound: true,
  //           ticker: 'ticker',
  //           sound: androidNotificationChannel.sound);

  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //           presentAlert: true, presentBadge: true, presentSound: true);

  //   NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails, iOS: darwinNotificationDetails);

  //   Future.delayed(Duration.zero, () {
  //     _flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.body.toString(),
  //         notificationDetails);
  //   });
  // }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMesssage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMesssage(context, event);
    });
  }
}

//  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static ReceivePort? receivePort;
  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
          (silentData) => onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      if (receivePort == null) {
        print(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          print('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page',
        (route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'AMIGO UAT',
            body: "You have some pending request.",
            bigPicture:
                'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'REPLY',
              label: 'Reply Message',
              requireInputText: true,
              actionType: ActionType.SilentAction),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await myNotifyScheduleInHours(
        title: 'test',
        msg: 'test message',
        heroThumbUrl:
            'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        hoursFromNow: 5,
        username: 'test user',
        repeatNotif: false);
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}

Future<void> myNotifyScheduleInHours({
  required int hoursFromNow,
  required String heroThumbUrl,
  required String username,
  required String title,
  required String msg,
  bool repeatNotif = false,
}) async {
  var nowDate = DateTime.now().add(Duration(hours: hoursFromNow, seconds: 5));
  await AwesomeNotifications().createNotification(
    schedule: NotificationCalendar(
      //weekday: nowDate.day,
      hour: nowDate.hour,
      minute: 0,
      second: nowDate.second,
      repeats: repeatNotif,
      //allowWhileIdle: true,
    ),
    // schedule: NotificationCalendar.fromDate(
    //    date: DateTime.now().add(const Duration(seconds: 10))),
    content: NotificationContent(
      id: -1,
      channelKey: 'basic_channel',
      title: '${Emojis.food_bowl_with_spoon} $title',
      body: '$username, $msg',
      bigPicture: heroThumbUrl,
      notificationLayout: NotificationLayout.BigPicture,
      //actionType : ActionType.DismissAction,
      color: Colors.black,
      backgroundColor: Colors.black,
      // customSound: 'resource://raw/notif',
      payload: {'actPag': 'myAct', 'actType': 'food', 'username': username},
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'NOW',
        label: 'btnAct1',
      ),
      NotificationActionButton(
        key: 'LATER',
        label: 'btnAct2',
      ),
    ],
  );
}
