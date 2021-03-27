import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';

import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:provider/provider.dart';

import 'teacher_form.dart';

class FoodDetail extends StatefulWidget {
  final data;
  FoodDetail({this.data});



  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
  TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);

    _onTeacherDeleted(Teacher teacher) {
      Navigator.pop(context);
     teacherNotifier.deleteTeacher(teacher);
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
                      builder: (BuildContext context) =>Professors(),
                    ),
                  );
               } ), 
         title: Text("Details"),centerTitle:true,
       
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
                     teacherNotifier.currentTeacher.image != null
                          ? teacherNotifier.currentTeacher.image
                          : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 24),
                    Text(
                     teacherNotifier.currentTeacher.name,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description: ${teacherNotifier.currentTeacher.category}',
                      style: TextStyle(fontSize: 18,),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'phone: ${teacherNotifier.currentTeacher.phone}',
                      style: TextStyle(fontSize: 18, ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email: ${teacherNotifier.currentTeacher.email}',
                      style: TextStyle(fontSize: 18, ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Address: ${teacherNotifier.currentTeacher.address}',
                      style: TextStyle(fontSize: 18, ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Skills",
                      style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(8),
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: teacherNotifier.currentTeacher.subIngredients
                          .map(
                            (ingredient) => Card(
                              color: Colors.black54,
                              child: Center(
                                child: Text(
                                  ingredient,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                 //   Text(widget.data['name']),
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
                  return TeacherForm(
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
            onPressed: () => deleteTeacher(teacherNotifier.currentTeacher, _onTeacherDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
