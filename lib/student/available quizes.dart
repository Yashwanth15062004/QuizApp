import 'package:new_project/student/home_page.dart';
import 'package:new_project/student/perfo_update.dart';
import '/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
String s = "";
final user = FirebaseAuth.instance.currentUser!;
final currentuser=FirebaseFirestore.instance.collection('users').doc(user.email.toString());

// final  collectionReference = currentuser.collection('profile').where('email', isEqualTo: user.email.toString()).limit(1).get().then((QuerySnapshot querySnapshot) {
// if (querySnapshot.size > 0) {
// // The document exists in the collection
// Map<String, dynamic> data = querySnapshot.docs[0].data();
// // Access the field using its name
// String fieldName = data['Class'];
// }
// };







//final cls=currentuser.collection('profile').where()

class Available_Quiz extends StatefulWidget {
  const Available_Quiz({super.key});

  @override
  State<Available_Quiz> createState() => _Available_QuizState();
}

class _Available_QuizState extends State<Available_Quiz> {
  String quizId = '';String quiz_code="";
  int minute=0;
  final CollectionReference parade =
      FirebaseFirestore.instance.collection('quizavailable');

//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        centerTitle: true,
        title:  Row(children:[SizedBox(width: 55,),Text('Quizziz',style: TextStyle( color: Colors.deepPurple[500],
          fontSize: 30.0,
          fontWeight:FontWeight.bold,),),]),
        elevation: 0,
        backgroundColor: Colors.transparent.withOpacity(0.1),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://t4.ftcdn.net/jpg/04/26/96/11/240_F_426961133_fVfYtguhghdGzCHJGvO0l1eipeseH8mm.jpg"), fit: BoxFit.cover)
        ),
        child: Scrollbar(
          
          child: StreamBuilder(

            stream: parade.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    //if(documentSnapshot['enclass']==cls) {
                      return Container(

                    //   color: Colors.redAccent,
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  backgroundColor: Colors.deepPurple[300],
                                  elevation: 40,
                                  shadowColor: Colors.black,

                                ),


                                onPressed: () {
                                  quizId = documentSnapshot['quizId'];
                                  quiz_code=documentSnapshot['quiz_code'];
                                  minute=documentSnapshot['quiz_min'];
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Validcode(quizId:quizId,quiz_code: quiz_code,minute:minute)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                    documentSnapshot['Quiz_title'],
                                                    style: TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text('Duration : '+
                                                  documentSnapshot['quiz_min'].toString()+' min',
                                                  style:
                                                  TextStyle(color:Colors.white,fontSize: 15.0)),
                                            ),
                                          ],
                                        ),

                                      ]),
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      );
                    }
                 // },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

String ques = '',
    opt1 = '',
    opt2 = '',
    opt3 = '',
    opt4 = '',
    optc = '',
    enopt = '';


class Validcode extends StatefulWidget {
  final String quizId,quiz_code;
  final int minute;
  Validcode({required this.quizId, required this.quiz_code,required this.minute});

  @override
  State<Validcode> createState() => _ValidcodeState();
}

class _ValidcodeState extends State<Validcode> {
  String Quiz_code="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validity!',style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Code" : null,
                decoration: InputDecoration(
                  hintText: "   Enter Quiz code",
                ),
                onChanged: (val) {
                  Quiz_code=val;
                },
              ),
    SizedBox(height: 20,),
    ElevatedButton(

    style: ElevatedButton.styleFrom(
    padding: EdgeInsets.all(20.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0)
    ),
    backgroundColor: Colors.deepPurple[300],
    ),


    onPressed: () {
      if (Quiz_code.toString() == widget.quiz_code.toString()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  QuizTime(quizId: widget.quizId, minute: widget.minute)),
        );
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert!'),
              content: Text('Enter the valid code'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    },
    child: Text('Start Quiz!'),),
            ],
          ),
        ),
      ),
    );
  }
}


class QuizTime extends StatefulWidget {
  final String quizId;final int minute;
  QuizTime({required this.quizId,required this.minute});

  @override
  State<QuizTime> createState() => _QuizTimeState();
}

class _QuizTimeState extends State<QuizTime> {
  late final CollectionReference showquiz;
  Map<int, List<String>> myMap = {
  };
  int crtans = 0;
  String p = '';
  @override
  void initState() {
    super.initState();
    p = widget.quizId;
    showquiz = FirebaseFirestore.instance
        .collection('quizavailable')
        .doc(widget.quizId)
        .collection('Qnsans');
    s = p.toString();
  }

  Color _containerColor = Colors.blue;

  void _onContainerClicked() {
    setState(() {
      _containerColor = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Row(children:[SizedBox(width:5,),Text('$p',style: TextStyle( color: Colors.white,
    fontSize: 30.0,
    fontWeight:FontWeight.bold,),),]),

    backgroundColor: Colors.deepPurple,
    ),

      body: StreamBuilder(
        stream: showquiz.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                myMap[index] = [
                  documentSnapshot['Question'],
                  documentSnapshot['optionA'],
                  documentSnapshot['optionB'],
                  documentSnapshot['optionC'],
                  documentSnapshot['optionD'],
                  documentSnapshot['optionco'],
                ];
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Column(

                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 5, 4, 5),
                          child: Row(

                            children: [
                              Flexible(
                                child: Text(documentSnapshot['Question'],
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.3),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 3, 4, 2),
                          child: Container(
                            child: Row(
                              children: [
                                Text('A. ',style: TextStyle(fontSize: 18),),
                                Text(documentSnapshot['optionA'],style: TextStyle(color: Colors.black.withOpacity(0.1),fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 3, 4, 2),
                          child: Container(
                            child: Row(
                              children: [
                                Text('B.',style: TextStyle(fontSize: 18),),
                                Text(documentSnapshot['optionB'],style: TextStyle(color: Colors.black.withOpacity(0.1),fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 3, 4, 2),
                          child: Container(
                            child: Row(
                              children: [
                                Text('C.',style: TextStyle(fontSize: 18),),
                                Text(documentSnapshot['optionC'],style: TextStyle(color: Colors.black.withOpacity(0.1),fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 3, 4, 2),
                          child: Container(
                            child: Row(
                              children: [
                                Text('D.',style: TextStyle(fontSize: 18),),
                                Text(documentSnapshot['optionD'],style: TextStyle(color: Colors.black.withOpacity(0.1),fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                ;
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      floatingActionButton:


      Center(
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Presentation(myMap: myMap,minute:widget.minute)));
          },

          label: const Text(
            'Attempt',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),


      ),


    );
  }
}

class Presentation extends StatefulWidget {
  final Map<int, List<String>> myMap;final int minute;
  Presentation({required this.myMap,required this.minute});
  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  late Timer _timer;
  int attempted=0;int correct_ans=0;
  int not_attempted=0;
  int _currentSeconds = 0;
  int _currentMinutes = 0;
  int _currentHours = 0;
  int currentIndex = 0;
  int score = 0;
  int myInt = 0;
  MapEntry<int, List<String>> currentMapEntry =
      MapEntry<int, List<String>>(0, []);
  List<bool> _selections = [false, false, false, false];
  @override
  void initState() {
    _currentMinutes=widget.minute;
    not_attempted=0;
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

      setState(() {
        _currentSeconds--;
      });
      if((_currentHours==0)&&(_currentMinutes==0)&&(_currentSeconds==0)){
        int k = 10;
        for (int i = 0; i < 4; i++) {
          if (_selections[i] == true) k = i;
        }
          bool rigt = false;
          if (k < 4) {
            attempted++;
            if (k == 0) {
              if (currentMapEntry.value[5].toString() == "A") {
                score++;correct_ans++;
                currentMapEntry.value.add('A');
                rigt = true;
              }
            }
            if (k == 1) {
              if (currentMapEntry.value[5].toString() == "B") {
                score++;correct_ans++;
                currentMapEntry.value.add('B');
                rigt = true;
              }
            }
            if (k == 2) {
              if (currentMapEntry.value[5].toString() == "C") {
                score++;correct_ans++;
                currentMapEntry.value.add('C');
                rigt = true;
              }
            }
            if (k == 3) {
              if (currentMapEntry.value[5].toString() == "D") {
                score++;correct_ans++;
                currentMapEntry.value.add('D');
                rigt = true;
              }
            }
          } else {not_attempted++;
          currentMapEntry.value.add('NOT ATTEMPTED');
          }
          if (rigt == false) {
            if (k == 0) currentMapEntry.value.add('A');
            if (k == 1) currentMapEntry.value.add('B');
            if (k == 2) currentMapEntry.value.add('C');
            if (k == 3) currentMapEntry.value.add('D');
          }
          myInt = score;
          _selections = [false, false, false, false];
          currentIndex++;
        for(int i= currentIndex;i<widget.myMap.length;i++){
          currentMapEntry =
              widget.myMap.entries.elementAt(i);not_attempted++;
          currentMapEntry.value.add('NOT ATTEMPTED');
        }
        print('hi');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Score_reveal(
                  score: score, myMap: widget.myMap,not_attempted : not_attempted,attempted: attempted,correct_ans: correct_ans
                ,)),
        );
      }
      if (_currentSeconds <= 0) {
        if (_currentMinutes == 0) {
          if (_currentHours == 0) {
            timer.cancel();
            // setState(() {
            //   isRunning = false;
            // });
          } else {
            _currentHours--;
            _currentMinutes = 59;
            _currentSeconds = 59;
          }
        } else {
          _currentMinutes--;
          _currentSeconds = 59;
        }
      }
    });
    currentIndex = 0;
    score = 0;
    currentMapEntry = widget.myMap.entries.elementAt(currentIndex);
  }

  bool colorfulchilaka(int min,int sec){

    if(min==0&&sec<11)return false;
    else
      return true;
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            '$_currentHours:$_currentMinutes:$_currentSeconds',
            style: TextStyle(fontSize: 30.0,color: colorfulchilaka(_currentMinutes,_currentSeconds)?Colors.white:Colors.red),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${currentMapEntry.key+1}:  ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 10,),



              Text(
                '${currentMapEntry.value[0].toString()}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  children: [
                    Container(
                        margin: EdgeInsets.all(1.0),
                        child: Text('1. ' + currentMapEntry.value[1].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ,
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text('2. ' + currentMapEntry.value[2].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text('3. ' + currentMapEntry.value[3].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text('4 .' + currentMapEntry.value[4].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  ],
                  isSelected: _selections,
                  direction: Axis.vertical,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < 4; i++) {
                        if (i == index)
                          _selections[i] = true;
                        else
                          _selections[i] = false;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int k = 10;
                  for (int i = 0; i < 4; i++) {
                    if (_selections[i] == true) k = i;
                  }
                  setState(() {
                    bool rigt = false;
                    if (k < 4) {
                      attempted++;
                      if (k == 0) {
                        if (currentMapEntry.value[5].toString() == "A") {
                          score++;correct_ans++;
                          currentMapEntry.value.add('A');
                          rigt = true;
                        }
                      }
                      if (k == 1) {
                        if (currentMapEntry.value[5].toString() == "B") {
                          score++;correct_ans++;
                          currentMapEntry.value.add('B');
                          rigt = true;
                        }
                      }
                      if (k == 2) {
                        if (currentMapEntry.value[5].toString() == "C") {
                          score++;correct_ans++;
                          currentMapEntry.value.add('C');
                          rigt = true;
                        }
                      }
                      if (k == 3) {
                        if (currentMapEntry.value[5].toString() == "D") {
                          score++;correct_ans++;
                          currentMapEntry.value.add('D');
                          rigt = true;
                        }
                      }
                    } else {not_attempted++;
                      currentMapEntry.value.add('NOT ATTEMPTED');
                    }
                    if (rigt == false) {
                      if (k == 0) currentMapEntry.value.add('A');
                      if (k == 1) currentMapEntry.value.add('B');
                      if (k == 2) currentMapEntry.value.add('C');
                      if (k == 3) currentMapEntry.value.add('D');
                    }
                    myInt = score;
                    _selections = [false, false, false, false];
                    currentIndex++;
                    if (currentIndex >= widget.myMap.length) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Score_reveal(
                                score: score, myMap: widget.myMap, not_attempted: not_attempted,attempted:attempted,correct_ans:correct_ans)),
                      );
                    } else {
                      currentMapEntry =
                          widget.myMap.entries.elementAt(currentIndex);
                    }
                  });
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                child: Text('Next'),
              ),
            ],
          ),
        ));
  }
}

class Score_reveal extends StatelessWidget {
  final int score;final int not_attempted,attempted,correct_ans;
  final Map<int, List<String>> myMap;
  Score_reveal({required this.score, required this.myMap,required
  this.not_attempted,required this.attempted,required this.correct_ans});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(50),
              // padding: const EdgeInsets.symmetric(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${score}',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    'Your Score',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    View_response(myMap: myMap, score: score,not_attempted:not_attempted,attempted:attempted,correct_ans:correct_ans)));
                      },
                      child: Text('View Results'))
                ],
              ),
            ),
          ],
        ));
  }
}

class View_response extends StatefulWidget {
  final Map<int, List<String>> myMap;
  final int score;final int not_attempted,attempted,correct_ans;
  View_response({required this.myMap, required this.score,required this.not_attempted,required this.attempted,required this.correct_ans});
  @override
  State<View_response> createState() => _View_responseState();
}

class _View_responseState extends State<View_response> {
  int p = 0;

  MapEntry<int, List<String>> currentMapEntry =
      MapEntry<int, List<String>>(0, []);
  int currentIndex = 0;
  bool coloring(String p) {
    if (('${currentMapEntry.value[5].toString()}') == p)
      return true;
    else {
      return false;
    }
  }

  bool coloring1(String p) {
    if (('${currentMapEntry.value[6].toString()}') == p)
      return false;
    else {
      return true;
    }
  }

  bool notcoloring(String p) {
    if (p == ('${currentMapEntry.value[6].toString()}'))
      return true;
    else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    currentIndex = 0;
    currentMapEntry = widget.myMap.entries.elementAt(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RESULT'),
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question' + '${currentMapEntry.key+1}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                '${currentMapEntry.value[0].toString()}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coloring("A")
                                ? coloring1("A")
                                    ? Colors.green
                                    : Color.fromARGB(255, 214, 236, 127)
                                : notcoloring("A")
                                    ? Colors.red
                                    : Colors.grey,
                            // set the border color
                            width: 2, // set the border width
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        child:
                            Text('1.' + currentMapEntry.value[1].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),)),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coloring("B")
                                ? coloring1("B")
                                    ? Colors.green
                                    : Color.fromARGB(255, 214, 236, 127)
                                : notcoloring("B")
                                    ? Colors.red
                                    : Colors.grey,
                            // set the border color
                            width: 2, // set the border width
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        child:
                            Text('2.' + currentMapEntry.value[2].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),)),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coloring("C")
                                ? coloring1("C")
                                    ? Colors.green
                                    : Color.fromARGB(255, 214, 236, 127)
                                : notcoloring("C")
                                    ? Colors.red
                                    : Colors.grey,
                            // set the border color
                            width: 2, // set the border width
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        child:
                            Text('3.' + currentMapEntry.value[3].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),)),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coloring("D")
                                ? coloring1("D")
                                    ? Colors.green
                                    : Color.fromARGB(255, 214, 236, 127)
                                : notcoloring("D")
                                    ? Colors.red
                                    : Colors.grey,
                            // set the border color
                            width: 2, // set the border width
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        child:
                            Text('4.' + currentMapEntry.value[4].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentIndex++;
                    if (currentIndex >= widget.myMap.length) {
                      // p=widget.quizId;
                      addUserscore(s, widget.score,widget.not_attempted,widget.attempted,widget.correct_ans);
                     Navigator.pop(context);//
                     // pushReplacement(context,
                        //MaterialPageRoute(builder: (context) => Homepage()));
                     //Navigator.popUntil(context, ModalRoute.withName('/main_l'));
                      //NamedAndRemoveUntil(context,'/.main_l', ModalRoute.withName('/main_l'));
                    } else {
                      currentMapEntry =
                          widget.myMap.entries.elementAt(currentIndex);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  elevation: 20,
                ),

                child: Text('Next'),
              ),
            ],
          ),
        ));
  }


  Future addUserscore(String Quiz_Title, int score,int not_attempted,int attempted,int correct_ans) async {
    final User = <String, dynamic>{
      'Quiz_Title': Quiz_Title,
      'score': score,
      'not_attempted':not_attempted,
      'attempted':attempted,
      'correct_ans':correct_ans
    };
    await currentuser
        .collection('performance')
        .add(User);
  }
}
