import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_project/Teacher/home_page_Teacher.dart';
import 'package:new_project/student/login.dart';
import 'package:new_project/student/home_page.dart';
import 'firebase_options.dart';
import 'package:new_project/start.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp(

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Start(),
      routes: {
        '/main':(context)=>Home_page(),
        '/main_l':(context)=>Homepage(),
      },
    );
  }
}
