import 'package:doctor/screens/dashboard_page.dart';
import 'package:doctor/screens/login.dart';
import 'package:doctor/screens/sign_up.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case DashboardPage.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardPage());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text("This page does not exit"),
                ),
              ));
  }
}
