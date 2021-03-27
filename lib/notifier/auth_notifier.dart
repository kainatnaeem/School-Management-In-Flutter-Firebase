import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';




//ChangeNtifier notify all listners about changes and AuthNotier is from CN
class AuthNotifier with ChangeNotifier { 
 User _user; //its the firebase User

User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
