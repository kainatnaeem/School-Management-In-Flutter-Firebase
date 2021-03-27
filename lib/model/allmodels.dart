import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher{
  String id;
  String name;
  String category;
  String image;
  String address;
  String phone;
  String email;
  List subIngredients = [];
  Timestamp createdAt;
  Timestamp updatedAt;

  Teacher();

 Teacher.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    address = data['address'];
    phone=data['phone'];
    email=data['email'];
    subIngredients = data['subIngredients'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'address':address,
      'phone':phone,
      'email':email,

      'subIngredients': subIngredients,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}


class Course{
  String id;
  String name;
  String description;
  String image;
  String instructor;
  Timestamp createdAt;
  Timestamp updatedAt;

  Course();

 Course.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
    image = data['image'];
    instructor = data['instructor'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'instructor': instructor,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}



class Fee{
  String id;
  String className;
  String fee;

 Timestamp createdAt;
Timestamp updatedAt;
Fee();

 Fee.fromMap(Map<String, dynamic> data) {
    id = data['id'];
   className = data['className'];
    fee = data['fee'];
     
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'className':className,
      'fee': fee,
     
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}



class Student{
  String id;
  String rollNo;
  String name;
 String fName;
  String image;
  String address;
  String phone;
  String registrationNo;


  Timestamp createdAt;
  Timestamp updatedAt;

  Student();

Student.fromMap(Map<String, dynamic> data) {
    id = data['id'];
     rollNo=data['rollNo'];
    name = data['name'];

   fName = data['fName'];
    image = data['image'];
    address = data['address'];
    phone=data['phone'];
 registrationNo =data['registrationNo'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rollNo': rollNo,
      'name': name,
      'fName': fName,
      'image': image,
      'address':address,
      'phone':phone, 
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'registrationNo':registrationNo,
    };
  }
}
