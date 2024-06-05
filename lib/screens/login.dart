import 'package:doctor/screens/dashboard_page.dart';
import 'package:doctor/screens/sign_up.dart';
import 'package:doctor/widgets/custom_button.dart';
import 'package:doctor/widgets/custom_textfield.dart';
import 'package:doctor/widgets/signup_option_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login-page";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              "SafeSpace",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 79, 135),
                  letterSpacing: -1,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Log into your Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextField(
                prefix: const Icon(Icons.mail_outline),
                hintText: "Email",
                controller: emailController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextField(
                prefix: const Icon(Icons.lock_open),
                hintText: "Password",
                isPass: true,
                controller: emailController),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              text: "Sign in",
              onPressed: () =>
                  Navigator.pushNamed(context, DashboardPage.routeName),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: 70,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Or sign in with"),
              ),
              Container(
                height: 2,
                width: 70,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpCardOption(img: "assets/images/a.png"),
              SignUpCardOption(img: "assets/images/f.png"),
              SignUpCardOption(img: "assets/images/g.png")
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: "  Sign Up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold))
                    ],
                    text: "Don't have an account?",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          )
        ],
      )),
    );
  }
}
