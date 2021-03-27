import 'dart:io';

import 'package:adminpanel/api/fee_api.dart';

import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/fee_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/fees.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/afterlogin.dart';

import 'package:provider/provider.dart';

class FeeForm extends StatefulWidget {
  final bool isUpdating;

  FeeForm({@required this.isUpdating});

  @override
  _FeeFormState createState() => _FeeFormState();
}

class _FeeFormState extends State<FeeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Fee _currentFee;

  @override
  void initState() {
    super.initState();
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context, listen: false);

    if (feeNotifier.currentFee != null) {
      _currentFee = feeNotifier.currentFee;
    } else {
      _currentFee = Fee();
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter class",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      initialValue: _currentFee.className,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Name must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentFee.className = value;
      },
    );
  }

  Widget _buildFeeField() {
    return TextFormField(
      initialValue: _currentFee.fee,
      keyboardType: TextInputType.text,
      // maxLength: 50,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Fee",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

      style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),
      validator: (String value) {
        if (value.isEmpty) {
          return 'fee is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentFee.fee = value;
      },
    );
  }

  _onFeeUploaded(Fee fee) {
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context, listen: false);
    feeNotifier.addFee(fee);
  }

  _saveFee() {
    print('fee Called');
    if (!_formKey.currentState.validate()) {}

    _formKey.currentState.save();

    print('form saved');

    uploadFeeAndImage(_currentFee, widget.isUpdating, _onFeeUploaded);

    print("name: ${_currentFee.className}");
    print("category: ${_currentFee.fee}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  builder: (BuildContext context) => Fees(),
                ),
              );
            }),
        title: Text("Add Fee"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body:Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/school.jpg"),
           
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
       
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                autovalidate: true,
                child: Column(children: <Widget>[
                  SizedBox(height: 16),
                  Text(
                    widget.isUpdating ? "Edit Fee" : "Create Fee",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildNameField(),
                  SizedBox(height: 16),
                  _buildFeeField(),
                  SizedBox(height: 16),
                ]),
              ),
            ],
          ),
  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _saveFee();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AfterLogin(),
            ),
          );
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
    );
  }
}
