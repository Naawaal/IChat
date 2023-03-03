import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/login_screen.dart';

class RegistrationControllerGetx extends GetxController {
  final auth = FirebaseAuth.instance;

  Future<void> userRegistration(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.off(() => const LoginScreen());
    } catch (e) {
      debugPrint(e.toString());
    }
    return userRegistration(email, password);
  }
}
