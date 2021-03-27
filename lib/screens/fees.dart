import 'package:adminpanel/api/fee_api.dart';
import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/fee_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/detail.dart';
import 'package:adminpanel/screens/fee_form.dart';
import 'package:adminpanel/screens/feed.dart';
import 'package:adminpanel/screens/teacher_form.dart';
import 'package:adminpanel/screens/view_fee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/screens/teachercontact.dart';

import 'afterlogin.dart';

class Fees extends StatefulWidget {
  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  @override
  void initState() {
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context, listen: false);
    getFee(feeNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context);

    Future<void> _refreshList() async {
      getFee(feeNotifier);
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
        title: Text("Fee"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
//body:_children[_currentIndex],
      body: Container( decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/school.jpg"),
           
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
       
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
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
                                color: Colors.deepPurple,
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
                                                    FeeForm(
                                                      isUpdating: false,
                                                    )),
                                          );
                                        }),
                                    Text("Add Fee",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Card(
                                color: Colors.blue,
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
                                                  ViewFee(),
                                            ),
                                          );
                                        }),
                                    Text("View Fee",
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
