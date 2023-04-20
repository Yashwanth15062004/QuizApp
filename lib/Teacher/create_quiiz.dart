import 'package:flutter/material.dart';
import 'package:new_project/Teacher/home_page_Teacher.dart';
import '/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Create_quiz extends StatefulWidget {
  @override
  State<Create_quiz> createState() => _Create_quizState();
}



class _Create_quizState extends State<Create_quiz> {
  final _formkey = GlobalKey<FormState>();
  String Quiz_title = '', enclass = '', quizId = 'sss',quiz_code='';int quiz_min=0;
  int duration = 0;
  int secondsRemaining = 0;
  int minutesRemaining = 0;
  int hoursRemaining = 0;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();
  createQuizonline() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading:
        true;
      });
      quizId = Quiz_title;
      Map<String, dynamic> quizmap = {
        'quizId': quizId,
        'Quiz_title': Quiz_title,
        'enclass': enclass,
        'quiz_code':quiz_code,
        'quiz_min' : quiz_min,
      };
      await databaseService.addQuizData(quizmap, quizId).then((value) {
        setState(() {
          _isLoading:
          false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Add_question1(quizId)),
        );
      });
    }
  }

  Widget buildHoursInputField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter duration in hours',
      ),
      onChanged: (value) {
        setState(() {
          duration = int.tryParse(value) ?? 0;
          hoursRemaining = duration;
        });
      },
    );
  }

  Widget buildMinutesInputField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter duration in minutes',
      ),
      onChanged: (value) {
        setState(() {
          duration = int.tryParse(value) ?? 0;
          minutesRemaining = duration;
        });
      },
    );
  }

  Widget buildSecondsInputField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(gapPadding: 20.0),
        hintText: 'Enter duration in seconds',
      ),
      onChanged: (value) {
        setState(() {
          duration = int.tryParse(value) ?? 0;
          secondsRemaining = duration;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz'),
        backgroundColor: Colors.indigo,
      ),
      body: _isLoading
          ? Container(
        child: Center(
          child: LinearProgressIndicator(),
        ),
      )
          : Form(
          key: _formkey,
          child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20,20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Title" : null,
                      decoration: InputDecoration(
                        hintText: "Enter Quiz title",
                      ),
                      onChanged: (val) {
                        Quiz_title = val;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter class" : null,
                      decoration: InputDecoration(
                        hintText: "Enter a class for Quiz",
                      ),
                      onChanged: (val) {
                        enclass = val;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Quiz Code" : null,
                      decoration: InputDecoration(
                        hintText: "Enter Quiz Code",
                      ),
                      onChanged: (val) {
                        quiz_code = val;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Enter Quiz time in Minutes" : null,
                      decoration: InputDecoration(
                        hintText: "Enter Quiz Time in Minutes",
                      ),
                      onChanged: (val) {
                        quiz_min = int.tryParse(val) ?? 0;
                      },
                    ),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.indigo,
                            side: BorderSide(
                                width: 3,
                                color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(20.0)),
                        onPressed: () {
                          createQuizonline();
                        },
                        child: Text('Create Quiz')),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ))),
    );
  }
}

class Add_question1 extends StatefulWidget {
  final String quizId;
  Add_question1(this.quizId);
  @override
  State<Add_question1> createState() => _Add_question1State();
}

class _Add_question1State extends State<Add_question1> {
  bool _isLoading = false;

  String optionA = '';
  String optionB = '';
  String optionC = '';
  String optionD = '';
  String optionco = '';
  String Question = '';
  DatabaseService databaseService = new DatabaseService();
  final _formkey = GlobalKey<FormState>();
  uploadquestionquiz() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "Question": Question,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
        "optionco": optionco
      };

      //  print("${widget.quizId}");
      databaseService.uploadData(questionMap, widget.quizId).then((value) {
        Question = "";
        optionA = "";
        optionB = "";
        optionC = "";
        optionD = "";
        optionco = "";
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Questions')),
      body: _isLoading
          ? Container(
        child: Center(
          child: LinearProgressIndicator(),
        ),
      )
          : Form(
          key: _formkey,
          child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Question" : null,
                          decoration: InputDecoration(
                            hintText: "Question",
                          ),
                          onChanged: (val) {
                            Question = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Option A" : null,
                          decoration: InputDecoration(
                            hintText: "Option A",
                          ),
                          onChanged: (val) {
                            optionA = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Option B" : null,
                          decoration: InputDecoration(
                            hintText: "Option B",
                          ),
                          onChanged: (val) {
                            optionB = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Option C" : null,
                          decoration: InputDecoration(
                            hintText: "Option C",
                          ),
                          onChanged: (val) {
                            optionC = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Option D" : null,
                          decoration: InputDecoration(
                            hintText: "Option D",
                          ),
                          onChanged: (val) {
                            optionD = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                          val!.isEmpty ? "Enter Correct Option " : null,
                          decoration: InputDecoration(
                            hintText: "Correct Option(Enter in Upper case alphabet)",
                          ),
                          onChanged: (val) {
                            optionco = val;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  uploadquestionquiz();
                                },
                                child: Text('Next Question')),
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  uploadquestionquiz();
                                  Navigator.pop(context);
                                  //  context,
                                   // MaterialPageRoute(builder: (context) => Home_page()),
                                  //);
                                },
                                child: Text('Submit Quiz')),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}