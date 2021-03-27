import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/detail.dart';
import 'package:adminpanel/screens/teacher_form.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
  TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context, listen: false);
    getTeachers(teacherNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);

    Future<void> _refreshList() async {
      getTeachers(teacherNotifier);
    }

    print("building Feed");
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
         title: Text("List of Professors"),centerTitle:true,
       
        backgroundColor: Colors.brown,
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
              teacherNotifier.teacherList[index].image != null
                    ? teacherNotifier.teacherList[index].image
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,
              ),
              title: Text(teacherNotifier.teacherList[index].name),
              subtitle: Text(teacherNotifier.teacherList[index].category),
              onTap: () {
             teacherNotifier.currentTeacher = teacherNotifier.teacherList[index];
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return FoodDetail();
                }));
              },
            );
          },
          itemCount: teacherNotifier.teacherList.length,
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
