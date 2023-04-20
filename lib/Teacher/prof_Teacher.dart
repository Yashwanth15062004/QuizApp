import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( edit_teacher_prof());
}

class edit_teacher_prof extends StatefulWidget {

  @override
  _edit_teacher_profState createState() => _edit_teacher_profState();
}

class _edit_teacher_profState extends State<edit_teacher_prof> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enrollController = TextEditingController();
  final TextEditingController _ClassController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  late final  CollectionReference view_pro;
  @override
  void initState() {
    super.initState();
    view_pro = FirebaseFirestore.instance.collection('teachers').doc(
        user.email.toString()).collection('profile');
  }


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['Name'];
      _emailController.text = documentSnapshot['email'];
      _enrollController.text=documentSnapshot['enroll'];
      _ClassController.text=documentSnapshot['Class'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _ClassController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _enrollController,
                  decoration: const InputDecoration(
                    labelText: 'Teacher Id',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300],
                    ),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String email = _emailController.text;
                      final String enroll=_enrollController.text.toString();
                      final String Class=_ClassController.text.toString();
                      if (Class != null) {
                        await view_pro
                            .doc(documentSnapshot!.id)
                            .update({"Name": name, "Class": Class,"enroll":enroll});
                        _nameController.text = '';
                        _emailController.text = '';
                        _enrollController.text = '';
                        _ClassController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  ),),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor:Colors.deepPurple[400],
        title: const Center(child: Text('Edit Profile')),
      ),
      body: StreamBuilder(
        stream: view_pro.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.grey[200],
                        padding: EdgeInsets.all(20.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name :'),
                            Text(documentSnapshot['Name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:20,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.grey[200],
                        padding: EdgeInsets.all(20.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email Id :'),
                            Text(documentSnapshot['email'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:20,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.grey[200],
                        padding: EdgeInsets.all(20.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Teacher Id :'),
                            Text(documentSnapshot['enroll'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:20,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.grey[200],
                        padding: EdgeInsets.all(20.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subject :'),
                            Text(documentSnapshot['Class'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:20,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepPurple[300],
                        child: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.edit),
                            onPressed: () => _update(documentSnapshot)),
                      ),
                    ],
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
// Add new product
    );
  }
}