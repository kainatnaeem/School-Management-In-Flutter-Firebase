import 'package:adminpanel/notifier/fee_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/afterlogin.dart';
import 'package:adminpanel/screens/feed.dart';
import 'package:adminpanel/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/screens/afterlogin.dart';
import 'notifier/auth_notifier.dart';


import 'notifier/student_notifier.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp()
   ;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TeacherNotifier(),
        ),
      
         ChangeNotifierProvider(
          create: (context) => FeeNotifier(),
        ),
          ChangeNotifierProvider(
          create: (context) =>StudentNotifier(),
        ),
      ],
      child: MyApp(),
    ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      home: Consumer<AuthNotifier>(  //AuthNotifier is here in order to  access the user which is in AuthNotifier
        builder: (context, notifier, child) {
          return notifier.user != null ? AfterLogin() : Login();
        },
      ),
    );
  }
}
