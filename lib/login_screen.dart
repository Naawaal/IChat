import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/custom_button.dart';
import 'package:i_chat/custom_textformfield.dart';
import 'package:i_chat/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final loginControllerGetx = Get.put(LoginControllerGetx());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: SizedBox(
              width: 200,
              child: Image.asset('assets/png/logo.png'),
            ),
          ),
          CustomTextformField(
            controller: email,
            hintText: 'Email',
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextformField(
            controller: password,
            hintText: 'Password',
          ),
          CustomButton(
            callBack: () async {
              await loginControllerGetx.userLogin(
                email.text,
                password.text,
              );
            },
            text: 'Login',
          ),
        ],
      ).paddingAll(8.0),
    );
  }
}
