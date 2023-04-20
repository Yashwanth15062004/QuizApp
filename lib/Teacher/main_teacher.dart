import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Teacher/auth_page_teacher.dart';
import 'package:new_project/Teacher/login_Teacher.dart';
import 'package:new_project/Teacher/home_page_Teacher.dart';

class Main_page extends StatelessWidget {
  const Main_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home_page();
          } else {
            return Auth_Page();
          }
        },
      ),
    );
  }
}
