
import 'dart:io';

import 'package:adminpanel/model/allmodels.dart';

import 'package:adminpanel/notifier/fee_notifier.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


getFee(FeeNotifier feeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Fee')
      .orderBy("createdAt", descending: true)
      .get();

  List<Fee> _feeList = [];

  snapshot.docs.forEach((document) {
 Fee  fee =Fee.fromMap(document.data());
    _feeList.add(fee);
  });

feeNotifier.feeList = _feeList;
}

uploadFeeAndImage(Fee fee, bool isUpdating, Function feeUploaded) async {
 


  


   if(fee != null){

    _uploadFee(fee, isUpdating, feeUploaded);
    print("if fee is not null so upload it to firebase");
  } else {
    
    print("fee not uploade");
      _uploadFee(fee, isUpdating, feeUploaded);
  }
}

_uploadFee(Fee fee, bool isUpdating, Function feeUploaded) async {
  CollectionReference feeRef = FirebaseFirestore.instance.collection('Fee');



  if (isUpdating) {
fee.updatedAt = Timestamp.now();

    await feeRef.doc(fee.id).update(fee.toMap());

feeUploaded(fee);
    print('updated fee with id: ${fee.id}');
  } else {
fee.createdAt = Timestamp.now();

    DocumentReference documentRef = await feeRef.add(fee.toMap());

    fee.id = documentRef.id;

    print('uploaded food successfully: ${fee.toString()}');

    await documentRef.set(fee.toMap(),  SetOptions(merge: true));

 feeUploaded(fee);
  }
}

deleteFee(Fee fee, Function feeDeleted) async {
 

  await FirebaseFirestore.instance.collection('Fee').doc(fee.id).delete();
feeDeleted(fee);
}





