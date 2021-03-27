import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherContact extends StatefulWidget {
  @override
  _TeacherContactState createState() => _TeacherContactState();
}

class _TeacherContactState extends State<TeacherContact> {
  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            // clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset("assets/contact.jpg"),
                SizedBox(height: 20),
                Text(
                  'phone: ${teacherNotifier.currentTeacher.phone}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
                Text(
                  'Email: ${teacherNotifier.currentTeacher.email}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
                Text(
                  'Address: ${teacherNotifier.currentTeacher.address}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
