import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("quizavailable")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> uploadData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("quizavailable")
        .doc(quizId)
        .collection('Qnsans')
        .add(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance
        .collection("quizavailable")
        .snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("quizavailable")
        .doc(quizId)
        .collection('Qnsans')
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}