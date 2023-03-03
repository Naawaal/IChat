import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/chat_screen.dart';

class LoginControllerGetx extends GetxController {
  final auth = FirebaseAuth.instance;

  Future<void> userLogin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.off(() => const ChatScreen());
    } catch (e) {
      debugPrint(e.toString());
    }
    return userLogin(email, password);
  }
}
