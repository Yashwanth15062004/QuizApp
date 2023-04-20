import 'package:flutter/material.dart';
import 'package:new_project/student/login.dart';
import 'package:new_project/student/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return loginpage(showRegisterPage: toggleScreens);
    }
    else{
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
