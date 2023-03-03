import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/splash_screen.dart';

class IChat extends StatelessWidget {
  const IChat({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IChat',
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      theme: ThemeData.dark(),
    );
  }
}
