import 'package:adminpanel/api/fee_api.dart';
import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/fee_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/fee_form.dart';

import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:provider/provider.dart';

import 'teacher_form.dart';

class FeeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context);

    _onFeeDeleted(Fee fee) {
      Navigator.pop(context);
      feeNotifier.deleteFee(fee);
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
                  builder: (BuildContext context) => Professors(),
                ),
              );
            }),
        title: Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Text(
                  feeNotifier.currentFee.className,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Fee: ${feeNotifier.currentFee.fee}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return FeeForm(
                    isUpdating: true,
                  );
                }),
              );
            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () => deleteFee(feeNotifier.currentFee, _onFeeDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
