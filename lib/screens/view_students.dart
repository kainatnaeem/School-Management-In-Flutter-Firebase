import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/api/student_api.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';

import 'package:adminpanel/notifier/student_notifier.dart';

import 'package:adminpanel/screens/studentDetail.dart';
import 'package:adminpanel/screens/students.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ViewStudents extends StatefulWidget {
  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  void initState() {
    StudentNotifier studentNotifier =
        Provider.of<StudentNotifier>(context, listen: false);
    getStudents(studentNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    StudentNotifier studentNotifier = Provider.of<StudentNotifier>(context);

    Future<void> _refreshList() async {
      getStudents(studentNotifier);
    }

    print("Students List");
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
                  builder: (BuildContext context) => Students(),
                ),
              );
            }),
        title: Text("List of Students"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                studentNotifier.studentList[index].image != null
                    ? studentNotifier.studentList[index].image
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,
              ),
              title: Text(studentNotifier.studentList[index].name),
              subtitle: Text(studentNotifier.studentList[index].rollNo),
              onTap: () {
                studentNotifier.currentStudent =
                    studentNotifier.studentList[index];
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return StudentDetail();
                }));
              },
            );
          },
          itemCount: studentNotifier.studentList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),
        onRefresh: _refreshList,
      ),
    );
  }
}
