import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class update_performance extends StatefulWidget {

  @override
  State<update_performance> createState() => _update_performanceState();
  final _quizidController = TextEditingController();
  final _scoreController = TextEditingController();
  @override
  void dispose(){
    _quizidController.dispose();
    _scoreController.dispose();
  }
}

class _update_performanceState extends State<update_performance> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  Future addUserscore (String Quiz_Title,int score,int not_attempted) async {
    final User = <String,dynamic> {
      'Quiz_Title': Quiz_Title,
      'score': score,
      'not_attempted':not_attempted
    };
    await FirebaseFirestore.instance.collection('users').doc(user.email.toString()).collection('performance').add(User);
  }
}
