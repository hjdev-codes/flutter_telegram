import 'package:flutter/material.dart';
import 'package:flutter_telegram/pages/user_verification.dart';
import 'package:flutter_telegram/statemanagement.dart/providerdata.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Providerdata(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: UserVerification(
        onChanged: (bool value) {
          setState(() {
            _isDark = value;
          });
        },
        isDark: _isDark,
      ),
    );
  }
}
