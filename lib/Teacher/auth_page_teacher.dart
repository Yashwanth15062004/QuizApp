import 'package:flutter/material.dart';
import 'package:new_project/Teacher/login_Teacher.dart';
import 'package:new_project/Teacher/Signup_Teacher.dart';

class Auth_Page extends StatefulWidget {
  const Auth_Page({super.key});

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return login_page(showRegister_Page: toggleScreens);
    }
    else{
      return Register_Page(showLogin_Page: toggleScreens);
    }
  }
}
