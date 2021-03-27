import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/detail.dart';
import 'package:adminpanel/screens/feed.dart';

import 'package:adminpanel/screens/teacher_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/screens/teachercontact.dart';

import 'afterlogin.dart';

class Professors extends StatefulWidget {
  @override
  _ProfessorsState createState() => _ProfessorsState();
}

class _ProfessorsState extends State<Professors> {
  @override
  void initState() {
    TeacherNotifier teacherNotifier =
        Provider.of<TeacherNotifier>(context, listen: false);
    getTeachers(teacherNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);

    Future<void> _refreshList() async {
      getTeachers(teacherNotifier);
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
        title: Text("Professors"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
//body:_children[_currentIndex],
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
         
               Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          children: <Widget>[
                            Container(
                              child: Card(
                                color: Colors.green[400],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
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
                                                    TeacherForm(
                                                      isUpdating: false,
                                                    )),
                                          );
                                        }),
                                    Text("Add Professors",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Card(
                                color: Colors.blue[400],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
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
                                                  Feed(),
                                            ),
                                          );
                                        }),
                                    Text("View Professors",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
