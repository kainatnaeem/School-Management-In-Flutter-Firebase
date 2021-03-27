
import 'package:adminpanel/calendar_folder/model/screens/event_creator.dart';

import 'package:adminpanel/screens/fees.dart';
import 'package:adminpanel/screens/mygallery/mygallery.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:adminpanel/screens/students.dart';
// import 'package:food/screens/teacher_form.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/search.dart';

class AfterLogin extends StatefulWidget {
  @override
  _AfterLoginState createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS App"),
        centerTitle: true,
        actions: <Widget>[],
        backgroundColor: Colors.brown,
      ),
      body: Container( decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/school.jpg"),
           
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
          
            Flexible(
                        child: LayoutBuilder(
                builder: (context, constaint) {
                  return new GridView(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: <Widget>[
                      new Container(
                     
                        child: Card(
                          color: Colors.red[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.person_add),
                                  color: Colors.white,
                                  iconSize: 40,
                                  highlightColor: Colors.pink,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Professors(),
                                      ),
                                    );
                                  }),
                              Text("Professors", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      new Container(
                       
                        child: Card(
                          color: Colors.green[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.book),
                                  color: Colors.white,
                                  iconSize: 40,
                                  highlightColor: Colors.pink,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CloudFirestoreSearch(),
                                      ),
                                    );
                                  }),
                              Text("Search students",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      new Container(
                     
                        child: Card(
                          color: Colors.pink[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.person_add),
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
                              Text("Students", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      new Container(
                      
                        child: Card(
                          color: Colors.orange,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.money),
                                  color: Colors.white,
                                  iconSize: 40,
                                  highlightColor: Colors.pink,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Fees(),
                                      ),
                                    );
                                  }),
                              Text("Fee", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      new Container(
                     
                        child: Card(
                          color: Colors.blue[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.image),
                                  color: Colors.white,
                                  iconSize: 40,
                                  highlightColor: Colors.pink,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>MyGallery(),
                                            ),
                                          );
                                  }),
                              Text("Media Gallery",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      new Container(
                   
                        child: Card(
                          color: Colors.brown[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(Icons.list),
                                  color: Colors.white,
                                  iconSize: 40,
                                  highlightColor: Colors.pink,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EventCreator(),
                                      ),
                                    );
                                  }),
                              Text("Events", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  );
                },
              ),
            ),
         
          ],
        ),
      ),
    );
  }
}
