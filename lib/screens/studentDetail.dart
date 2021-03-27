import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/api/student_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/notifier/student_notifier.dart';
import 'package:adminpanel/screens/student_form.dart';
import 'package:adminpanel/screens/students.dart';

import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:provider/provider.dart';

import 'teacher_form.dart';

class StudentDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  StudentNotifier  studentNotifier = Provider.of<StudentNotifier>(context);

    _onStudentDeleted(Student student) {
      Navigator.pop(context);
     studentNotifier.deleteStudent(student);
    }

    return Scaffold(
         appBar: AppBar(
                      leading:   IconButton(
              icon: new Icon(Icons.arrow_back),color: Colors.white,iconSize: 40,
            
              highlightColor: Colors.pink,
              onPressed: (){ 
               
            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>Students(),
                    ),
                  );
               } ), 
         title: Text("Student"),centerTitle:true,
       
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
                child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.network(
                     studentNotifier.currentStudent.image != null
                          ? studentNotifier.currentStudent.image
                          : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                    
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 24),
                    Text(
                   studentNotifier.currentStudent.name,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),    SizedBox(height: 10),
                    Text(
                      'Father Name: ${studentNotifier.currentStudent.fName}',
                      style: TextStyle(fontSize: 18, ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Phone: ${studentNotifier.currentStudent.phone}',
                      style: TextStyle(fontSize: 18,),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Roll No: ${studentNotifier.currentStudent.rollNo}',
                      style: TextStyle(fontSize: 18, ),
                    ),
                    SizedBox(height: 20),
                       Text(
                      'Registration No: ${studentNotifier.currentStudent.registrationNo}',
                      style: TextStyle(fontSize: 18,),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Address: ${studentNotifier.currentStudent.address}',
                      style: TextStyle(fontSize: 18,),
                    ),
                    SizedBox(height: 20),

                   
                 
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return StudentForm(
                    isUpdating: true,
                  );
                }),
              );
            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () => deleteStudent(studentNotifier.currentStudent, _onStudentDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
