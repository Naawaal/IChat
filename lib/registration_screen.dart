import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/custom_button.dart';
import 'package:i_chat/custom_textformfield.dart';
import 'package:i_chat/registration_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final registrationControllerGetx = Get.put(RegistrationControllerGetx());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
              height: 10,
            ),
            CustomTextformField(
              controller: password,
              hintText: 'Password',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              callBack: () async {
                await registrationControllerGetx.userRegistration(
                  email.text,
                  password.text,
                );
              },
              text: 'Registration',
            ),
          ],
        ).paddingAll(8.0),
      ),
    );
  }
}
