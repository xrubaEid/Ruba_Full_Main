import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepwell/firebase_options.dart';
import 'package:sleepwell/screens/dashboard_screen.dart';
import 'package:sleepwell/screens/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'screens/alarm_screen.dart';

late SharedPreferences prefs;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // التعامل مع الإشعارات الواردة عندما يكون التطبيق في الخلفية أو مغلقاً
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
//
  //final WidgetsBinding = WidgetsFlutterBinding.ensureInitialized();

//
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  tz.initializeTimeZones();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // GetX local storege
  //await GetStorage.init();
  prefs = await SharedPreferences.getInstance();

  await Alarm.init(showDebugLogs: true);

// GetX local storege
  // await GetStorage.init();
//coenact to fire base
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // tz.initializeTimeZones();
  runApp(const MainAppScreen());
}

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool loginStatus = prefs.getBool("isLogin") ?? false;
    return GetMaterialApp(
      title: 'SleepWell',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: loginStatus ? DashboardScreen() : const SplashScreen(),
      // home: DashboardScreen(),
    );
  }
}
