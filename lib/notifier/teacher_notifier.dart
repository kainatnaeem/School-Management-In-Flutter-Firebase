import 'dart:collection';

import 'package:adminpanel/model/allmodels.dart';
import 'package:flutter/cupertino.dart';

class TeacherNotifier with ChangeNotifier {
  List<Teacher> _teacherList = [];
  Teacher _currentTeacher;

  UnmodifiableListView<Teacher> get teacherList => UnmodifiableListView(_teacherList);

  Teacher get currentTeacher => _currentTeacher;

  set teacherList(List<Teacher> teacherList) {
    _teacherList = teacherList;
    notifyListeners();
  }

  set currentTeacher(Teacher teacher) {
    _currentTeacher = teacher;
    notifyListeners();
  }

  addTeacher(Teacher teacher) {
    _teacherList.insert(0, teacher);
    notifyListeners();
  }

  deleteTeacher(Teacher teacher) {
    _teacherList.removeWhere((_teacher) => _teacher.id == teacher.id);
    notifyListeners();
  }
}
