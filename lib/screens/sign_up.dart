import 'package:doctor/screens/login.dart';
import 'package:doctor/widgets/custom_button.dart';
import 'package:doctor/widgets/custom_textfield.dart';
import 'package:doctor/widgets/signup_option_card.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = "/sign-up-screen";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
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
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Create your safepace account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 5,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomTextField(
                  prefix: const Icon(Icons.lock_open),
                  isPass: true,
                  hintText: "Confirm Password",
                  controller: emailController),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "Sign Up"),
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
                  child: Text("Or sign up with"),
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
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "  Login ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))
                      ],
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
