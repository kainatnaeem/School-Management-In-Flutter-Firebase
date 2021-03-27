import 'package:adminpanel/api/student_api.dart';

import 'package:adminpanel/notifier/student_notifier.dart';
import 'package:adminpanel/screens/afterlogin.dart';

import 'package:adminpanel/screens/search.dart';

import 'package:adminpanel/screens/student_form.dart';
import 'package:adminpanel/screens/view_students.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  void initState() {
    StudentNotifier studentNotifier =
        Provider.of<StudentNotifier>(context, listen: false);
    getStudents(studentNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // void _signOut() async {
    //   try {
    //     await auth.signOut();
    //     onSignOut();
    //   } catch (e) {
    //     print(e);
    //   }

    // }
    // AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    StudentNotifier studentNotifier = Provider.of<StudentNotifier>(context);

    Future<void> _refreshList() async {
      getStudents(studentNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 40,
            highlightColor: Colors.pink,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AfterLogin(),
                ),
              );
            }),
        title: Text("Students"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/school.jpg"),
           
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
       
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.pink[300]),
                    child: Column(
                      children: [
                        IconButton(
                            icon: new Icon(Icons.person_add),
                            color: Colors.white,
                            iconSize: 20,
                            highlightColor: Colors.pink,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StudentForm(
                                          isUpdating: false,
                                        )),
                              );
                            }),
                        Text("Add Students",
                            style: TextStyle(color: Colors.white))
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.green[300]),
                    child: Column(
                      children: [
                        IconButton(
                            icon: new Icon(Icons.view_column),
                            color: Colors.white,
                            iconSize: 20,
                            highlightColor: Colors.pink,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewStudents(),
                                ),
                              );
                            }),
                        Text("View Students",
                            style: TextStyle(color: Colors.white))
                      ],
                    )),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
