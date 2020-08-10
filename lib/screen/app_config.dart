import 'package:first_resp_api/screen/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

// #51597e
// #ff0000
// #151721

ThemeData getTheme() {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.8),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      labelStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

Map<String, WidgetBuilder> getRoutes() => <String, WidgetBuilder>{
      HomePage.route: (context) => HomePage(),
      /*  AuthScreen.route: (context) => AuthScreen(),
      HomeScreen.route: (context) => HomeScreen(),
      ProfileScreen.route: (context) => ProfileScreen(),
    */
    };
