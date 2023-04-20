import 'package:flutter/material.dart';
import 'package:new_project/student/main_page.dart';
import 'package:new_project/student/login.dart';
import 'package:new_project/Teacher/main_teacher.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(

      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://images.unsplash.com/photo-1568275339031-a8ce20ef6f9e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjN8fHBlbmNpbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"), fit: BoxFit.cover)
      ),
      child:Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(


                shadowColor: Colors.transparent,

            color: Colors.transparent.withOpacity(0.2),
            elevation: 100,
            margin: const EdgeInsets.all(15),
            child:Column(
              children: [
                SizedBox(height:40,),
              Text('Welcome to Quiziz!',
                style: TextStyle(color:Colors.grey[800],fontSize: 27,),),
                Text('Select Student/Teacher',
                  style: TextStyle(color:Colors.white,fontSize: 27,),),
                SizedBox(height:40,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
          ElevatedButton(
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Mainpage()),);
          },
            style: ElevatedButton.styleFrom(
             backgroundColor: Colors.deepPurple[200],
            ),
           child:Text('Student',
           style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
           ),),
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Main_page()),);
             },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[200],
            ),
                child:Text('Teacher',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                    fontSize: 20,
                  ),),
          ),
    ],
                ),
                SizedBox(height:20,),
              ],
            ),
          ),
            ],
          ),
    );
  }
}
