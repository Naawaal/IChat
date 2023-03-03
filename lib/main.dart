import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/i_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const IChat());
}
