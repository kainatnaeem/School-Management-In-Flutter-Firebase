import 'dart:io';

import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/model/user.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/notifier/student_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

getStudents(StudentNotifier studentNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Students')
      .orderBy("createdAt", descending: true)
      .get();

  List<Student> _studentList = [];

  snapshot.docs.forEach((document) {
    Student student =Student.fromMap(document.data());
    _studentList.add(student);
  });

  studentNotifier.studentList= _studentList;
}

uploadStudentAndImage(Student student, bool isUpdating, File localFile, Function studentUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('students/images/$uuid$fileExtension');
 UploadTask uploadTask = firebaseStorageRef.putFile(localFile);
     print('aaa');
  print(uploadTask);
  var imageUrl = await (await uploadTask).ref.getDownloadURL();
  String url = imageUrl.toString();
  print(url);




   
    print("download url: $url");
    _uploadStudent(student, isUpdating, studentUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadStudent(student, isUpdating, studentUploaded);
  }
}

_uploadStudent(Student student, bool isUpdating, Function studentUploaded, {String imageUrl}) async {
  CollectionReference studentRef = FirebaseFirestore.instance.collection('Students');

  if (imageUrl != null) {
    student.image = imageUrl;
  }

  if (isUpdating) {
    student.updatedAt = Timestamp.now();

    await studentRef.doc(student.id).update(student.toMap());

studentUploaded(student);
    print('updated student with id: ${student.id}');
  } else {
  student.createdAt = Timestamp.now();

    DocumentReference documentRef = await studentRef.add(student.toMap());

 student.id = documentRef.id;

    print('uploaded food successfully: ${student.toString()}');

    await documentRef.set(student.toMap(), SetOptions(merge: true));

   studentUploaded(student);
  }
}

deleteStudent(Student student, Function studentDeleted) async {
  if (student.image != null) {
  Reference storageReference =
      FirebaseStorage.instance.refFromURL(student.image);

    // print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance.collection('Students').doc(student.id).delete();
studentDeleted(student);
}















