import 'dart:io';

import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/model/user.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


login(MyUser user, AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(MyUser user, AuthNotifier authNotifier) async {
 UserCredential authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
 
    await FirebaseAuth.instance.currentUser.updateProfile(displayName:user.displayName);
    

   User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile();

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

User currentUser =  FirebaseAuth.instance.currentUser;
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
User firebaseUser = await FirebaseAuth.instance.currentUser;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getTeachers(TeacherNotifier teacherNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Teachers')
      .orderBy("createdAt", descending: true)
      .get();

  List<Teacher> _teacherList = [];

  snapshot.docs.forEach((document) {
    Teacher teacher = Teacher.fromMap(document.data());
    _teacherList.add(teacher);
  });

  teacherNotifier.teacherList = _teacherList;
}

uploadTeacherAndImage(Teacher teacher, bool isUpdating, File localFile, Function teacherUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('teachers/images/$uuid$fileExtension');
 UploadTask uploadTask = firebaseStorageRef.putFile(localFile);
     print('aaa');
  print(uploadTask);
  var imageUrl = await (await uploadTask).ref.getDownloadURL();
  String url = imageUrl.toString();
  print(url);
  // Guardar el post en la bbdd



   
    print("download url: $url");
    _uploadTeacher(teacher, isUpdating, teacherUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadTeacher(teacher, isUpdating, teacherUploaded);
  }
}

_uploadTeacher(Teacher teacher, bool isUpdating, Function teacherUploaded, {String imageUrl}) async {
  CollectionReference teacherRef = FirebaseFirestore.instance.collection('Teachers');

  if (imageUrl != null) {
    teacher.image = imageUrl;
  }

  if (isUpdating) {
    teacher.updatedAt = Timestamp.now();

    await teacherRef.doc(teacher.id).update(teacher.toMap());

 teacherUploaded(teacher);
    print('updated teacher with id: ${teacher.id}');
  } else {
   teacher.createdAt = Timestamp.now();

    DocumentReference documentRef = await teacherRef.add(teacher.toMap());

    teacher.id = documentRef.id;

    print('uploaded food successfully: ${teacher.toString()}');

    await documentRef.set(teacher.toMap(), SetOptions(merge: true));

    teacherUploaded(teacher);
  }
}

deleteTeacher(Teacher teacher, Function teacherDeleted) async {
  if (teacher.image != null) {
  Reference storageReference =
      FirebaseStorage.instance.refFromURL(teacher.image);

    // print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance.collection('Teachers').doc(teacher.id).delete();
teacherDeleted(teacher);
}















