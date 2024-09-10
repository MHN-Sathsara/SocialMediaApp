import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:redditclone_app/screens/sign_InPage.dart';
import 'package:redditclone_app/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      theme: AppTheme.darkTheme,
      home: SignInPage(),
    );
  }
}
