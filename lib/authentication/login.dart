import 'dart:io';
import 'package:android_studio_projects/providers/cart_model.dart';
import 'package:android_studio_projects/providers/theme_changer_provider.dart';
import 'package:android_studio_projects/providers/theme_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'auth_page.dart';
import 'utils.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locales.init(['hu', 'en', 'de']);

  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDcXj8EWWB_rngaDOzZIhC7QLnguyvAHzE',
        appId: '1:331949612021:android:8b0ee595f4d7d1915e1ebc',
        messagingSenderId: '331949612021',
        projectId: 'myfirstmobileapp-c8750',
        storageBucket: "myfirstmobileapp-c8750.appspot.com"
      ))
      : await Firebase.initializeApp();

  runApp(DevicePreview(
      enabled: false,
      builder: (context) => const MyApp()
      ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static const String title = 'Firebase Auth';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => ThemeChanger())
    ],
  child: Builder(builder: (BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return LocaleBuilder(
    builder: (locale) => ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MaterialApp(
    title: 'Flutter Locales',
    localizationsDelegates: Locales.delegates,
    supportedLocales: Locales.supportedLocales,
    locale: locale,
    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    themeMode: themeChanger.themeMode,
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      primaryColorLight: Colors.red,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red
      ),
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
      ),
    ),
    home: const LoginApp(),
    ),
    ),

    );
    }
    )
    );
  }
}


class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Mayday!"));
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return AuthPage();
        }
      }
    ),
  );
}
