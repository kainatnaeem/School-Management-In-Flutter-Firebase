import 'dart:collection';

import 'package:adminpanel/model/allmodels.dart';
import 'package:flutter/cupertino.dart';

class FeeNotifier with ChangeNotifier {
  List<Fee> _feeList = [];
  Fee _currentFee;

  UnmodifiableListView<Fee> get feeList => UnmodifiableListView(_feeList);

  Fee get currentFee => _currentFee;

  set feeList(List<Fee> feeList) {
    _feeList = feeList;
    notifyListeners();
  }

  set currentFee(Fee fee) {
    _currentFee = fee;
    notifyListeners();
  }

  addFee(Fee fee) {
    _feeList.insert(0, fee);
    notifyListeners();
  }

  deleteFee(Fee fee) {
    _feeList.removeWhere((_fee) => _fee.id == fee.id);
    notifyListeners();
  }
}
