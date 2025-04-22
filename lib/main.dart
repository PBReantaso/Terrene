import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      home: SplashScreen(),
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromRGBO(27, 77, 62, 1),
    );
  }
}
