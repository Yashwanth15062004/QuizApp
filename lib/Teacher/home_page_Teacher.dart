import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Teacher/create_quiiz.dart';
import 'package:new_project/Teacher/prof_Teacher.dart';
class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  final user = FirebaseAuth.instance.currentUser!;
  late final  CollectionReference view_pro;
  @override
  void initState() {
    super.initState();
    view_pro = FirebaseFirestore.instance.collection('teachers').doc(
        user.email.toString()).collection('profile');
  }
//   Future getdetails() async{
//     // String uid=FirebaseAuth.instance.currentUser.uid;
//     await FirebaseFirestore.instance.collection('users').get().then(
//         (snapshot)=>snapshot.docs.
//     );
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizziz',
          style:TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight:FontWeight.bold,
          ),
        ),
        backgroundColor:Colors.indigo,
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

                  return Container( color: Colors.grey[200],
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
                          Text('Teacher Id',
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
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>edit_teacher_prof()));
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
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch ,
              children: <Widget>[

                Column(
                  children: [
                    SizedBox(height: 50,),
                    Text('WELCOME!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),
                    Image.asset(
                      'lib/images/performance.jpg',
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
                ElevatedButton(
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Create_quiz()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    child: Text('Create Quizz!',
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
