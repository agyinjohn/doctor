import 'package:doctor/screens/admin/admin_dashboard_page.dart';
import 'package:doctor/screens/dashboard_page.dart';
import 'package:doctor/screens/dotor_view.dart/home_view.dart';
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
    case AdminDashboardPage.routeName:
      return MaterialPageRoute(builder: (context) => AdminDashboardPage());

    case DoctorHomePage.routeName:
      return MaterialPageRoute(builder: (context) => DoctorHomePage());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text("This page does not exit"),
                ),
              ));
  }
}
