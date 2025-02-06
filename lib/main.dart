import 'dart:io';

import 'package:push_notification/common/controller/dependency_injection.dart';
import 'package:push_notification/features/iApproval/providers/fpn_tco_detail_provider.dart';
import 'package:push_notification/features/iCart/providers/hardware_detail_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_filter_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_provider.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/providers/isac_request_list_provider.dart';
import 'package:push_notification/features/iSAC/providers/vendor_code_list_provider.dart';
import 'package:push_notification/features/iSAC/providers/vendor_onboarding_list_provider.dart';
import 'package:push_notification/features/iSAC/screens/dashboard/isac_dashboard_screen.dart';
import 'package:push_notification/features/user/providers/login_provider.dart';
import 'package:push_notification/notification_service.dart';
import 'package:push_notification/splash_screen.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/network/my_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => LoginProvider())),
        ChangeNotifierProvider(create: ((context) => ISACProvider())),
        ChangeNotifierProvider(create: ((context) => ICartProvider())),
        ChangeNotifierProvider(create: ((context) => ICartFilterProvider())),
        ChangeNotifierProvider(create: ((context) => HardwareDetailProvider())),
        ChangeNotifierProvider(create: ((context) => FpnTcoDetailProvider())),
        ChangeNotifierProvider(create: (context) => SelectedContainerIndex()),
        ChangeNotifierProvider(create: (context) => ScrollPositonNotifier()),
        ChangeNotifierProvider(create: (context) => ScrollProvider()),
        ChangeNotifierProvider(
            create: ((context) => ISACRequestListProvider())),
        ChangeNotifierProvider(
            create: ((context) => VendorOnBoardingListProvider())),
        ChangeNotifierProvider(create: ((context) => VendorCodeListProvider())),

        // ChangeNotifierProvider(create: (context) => ScrollNotifier()),
        ChangeNotifierProvider(create: (context) => ISACRejectListProvider()),
      ],
      child: const MyApp(),
    ),
  );
  DependencyInjection.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() async {
  //   super.initState();
  //   // if (await HelperFunctions.isRootOrJailbroken()) {
  //   //   HelperFunctions.showAlert("Security Alert",
  //   //       "Your device is rooted or jailbroken. Please remove jailbreak to use this app");
  //   //   exit(0);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotificationPermisions();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    return Listener(
      onPointerDown: (event) {
        SessionManagement.checkSession(context);
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iAMIGO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
