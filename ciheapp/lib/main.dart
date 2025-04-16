import 'package:ciheapp/provider/api/courseprovider.dart';
import 'package:ciheapp/provider/api/dropdownprovider.dart';
import 'package:ciheapp/provider/api/enrollementprovider.dart';
import 'package:ciheapp/provider/api/group_member_provider.dart';
import 'package:ciheapp/provider/assignment.dart';
import 'package:ciheapp/provider/calender_provider.dart';
import 'package:ciheapp/provider/courses_provider.dart';
import 'package:ciheapp/provider/message_provider.dart';
import 'package:ciheapp/provider/password_provider.dart';
import 'package:ciheapp/provider/profile_provider.dart';
import 'package:ciheapp/splashscreen.dart';
import 'package:ciheapp/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// // Background message handler for Firebase Cloud Messaging
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message: ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  // // Set up Firebase Cloud Messaging
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  

  // await NotificationHelper.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) =>PasswordVisibilityyProvider()),
        ChangeNotifierProvider(create: (_) => PasswordVisibilitysProvider()),
        ChangeNotifierProvider(create: (_) => CoursesProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_)=> MessageProvider()),
        ChangeNotifierProvider(create: (_) => AssignmentProvider()),
         ChangeNotifierProvider(create: (_) => EnrollmentProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => PosDropdownProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
      ],
      child: MaterialApp(
        title: 'CIHE App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light, //// if we want use the system theme then we can use ThemeMode.system
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

