import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class perfo extends StatefulWidget {
  const perfo({Key? key}) : super(key: key);

  @override
  State<perfo> createState() => _perfoState();
}

class _perfoState extends State<perfo> {
  final user = FirebaseAuth.instance.currentUser!;
  late final  CollectionReference view_performance;
  @override
  void initState() {
    super.initState();
    view_performance = FirebaseFirestore.instance.collection('users').doc(
        user.email.toString()).collection('performance');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
     title: Row(children:[SizedBox(width: 30,),Text('Performance',style: TextStyle( color: Colors.white,
       fontSize: 30.0,
       fontWeight:FontWeight.bold,),),]),
      backgroundColor: Colors.deepPurple[400],

    ),
      body:Container(
          color:Colors.blueGrey[50],
          child: StreamBuilder(
            stream: view_performance.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height:20,),
                        Card(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            children: [
                              SizedBox(height:10,),
                                    Text(documentSnapshot['Quiz_Title'],
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold)),
                              SizedBox(height:10,),
                                   Text('Score : '+documentSnapshot['score'].toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                              SizedBox(height:10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 CircleAvatar(radius: 8,backgroundColor:Colors.yellow,),
                                  Text(' Not attempted : '+documentSnapshot['not_attempted'].toString(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height:10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(radius: 8,backgroundColor:Colors.green,),
                                  Text(' Correct answers : '+documentSnapshot['correct_ans'].toString(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height:10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(radius: 8,backgroundColor:Colors.red,),
                                  Text(' Wrong  answers : '+(documentSnapshot['attempted']-documentSnapshot['correct_ans']).toString(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height:15,),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
      ),
    );
  }
}
