import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/sign_in_screen.dart';

void main() async {
  // todo: check if firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // todo: initialize firebase before run the project as a ui
   await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SigninScreen(),
    );
  }
}
