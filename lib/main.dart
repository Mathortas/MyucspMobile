import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyUCSPApp());
}

class MyUCSPApp extends StatelessWidget {
  const MyUCSPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyUCSP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}
