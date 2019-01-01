import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/home/home_page.dart';
import 'package:flutter_login_screen/ui/onboarding/onboarding_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SignUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoardingPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/onboarding': (BuildContext context) => OnBoardingPage()
      },
    );
  }
}
