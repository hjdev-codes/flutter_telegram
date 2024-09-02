import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_telegram/a_login_pages/user_verification.dart';
import 'package:flutter_telegram/a_pages/page2/homepage.dart';
import 'package:flutter_telegram/b_utalities/custom_theme.dart';
import 'package:flutter_telegram/c_statemanagement.dart/providerdata.dart';
import 'package:flutter_telegram/d_firebase/chat_firebase.dart';
import 'package:flutter_telegram/d_firebase/profile_firebase.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Providerdata(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileFirebase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChatFirebase(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Providerdata>(
        builder: (BuildContext context, value, Widget? child) {
      return MaterialApp(
        theme: value.DartThemeMode ? lightTheme : darkTheme,
        builder: EasyLoading.init(),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the stream
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              // If we have a user, navigate to the homepage
              return const Homepage();
            } else {
              // If the user is null, navigate to the verification page
              return const UserVerification();
            }
          },
        ),
      );
    });
  }
}
