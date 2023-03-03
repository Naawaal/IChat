import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/chat_screen.dart';
import 'package:i_chat/custom_button.dart';
import 'package:i_chat/login_screen.dart';
import 'package:i_chat/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      5.milliseconds,
      () async {
        final auth = FirebaseAuth.instance;
        if (auth.currentUser != null) {
          await Get.off(() => const ChatScreen());
        } else {
          await Get.off(() => const SplashScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100,
                  decoration: const BoxDecoration(),
                  child: Image.asset('assets/png/logo.png'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'IChat',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          CustomButton(
            callBack: () {
              Get.to(() => const LoginScreen());
            },
            text: 'Login',
          ),
          CustomButton(
            callBack: () {
              Get.to(() => const RegistrationScreen());
            },
            text: 'Register',
          ),
        ],
      ),
    );
  }
}
