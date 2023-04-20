import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/student/available quizes.dart';
import 'package:new_project/student/performance.dart';
import 'package:new_project/student/profstu.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  late final  CollectionReference view_pro;
  @override
  void initState() {
    super.initState();
     view_pro = FirebaseFirestore.instance.collection('users').doc(
        user.email.toString()).collection('profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizziz',
          style:TextStyle(
            color: Colors.yellow,
            fontSize: 40.0,
            fontWeight:FontWeight.bold,
          ),
        ),
        backgroundColor:Colors.deepPurple[400],
        centerTitle: true,
      ),
      endDrawer: Drawer(
          child:  StreamBuilder(
              stream: view_pro.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                      return Container(
                        color: Colors.grey[200],
                        margin: const EdgeInsets.all(10),
                        child:Padding(
                          padding:EdgeInsets.all(20),
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              child:Text('PROFILE',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                      ),
                            SizedBox(height: 50,),
                                Text('Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              Container(
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                  child:  Padding(
                                    padding:EdgeInsets.fromLTRB(20, 10, 20, 20),
                                   child: Text(documentSnapshot['Name'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ),),
                            SizedBox(height: 10,),
                            Text('Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            Container(
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child:  Padding(
                                padding:EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: Text(documentSnapshot['email'],
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),),
                            SizedBox(height: 10,),
                            Text('Class',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            Container(
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child:  Padding(
                                padding:EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: Text(documentSnapshot['Class'],
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),),
                            SizedBox(height: 10,),
                            Text('Enrollment No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            Container(
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child:  Padding(
                                padding:EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: Text(documentSnapshot['enroll'],
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                             MaterialButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              color: Colors.deepPurple[200],
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                              child: Text('sign out'),
                            ),
                              MaterialButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>edit()));
                              },
                                color: Colors.deepPurple[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                  child: Text('Edit Profile'),),
                              ],
                            ),
                          ],
                        ),
                      ),
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
      body:(
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch ,
              children: <Widget>[

                Column(
                  children: [
                    Image.asset(
                      'lib/images/performance.jpg',
                      height: 300,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Available_Quiz()));
                    },


                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                       backgroundColor: Colors.deepPurple[300],

                    ),
                    child: Text('Attempt Quizz',
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight:FontWeight.bold,
                      ),
                    )
                ),
                SizedBox(
                  height : 40.0,
                ),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),

                      backgroundColor: Colors.deepPurple[300],

                    ),

                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>perfo()));
                    },
                    child: Text('View Performance',
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight:FontWeight.bold,
                      ),
                    )
                ),

              ],
            ),
          )
      ),
    );
  }
}
