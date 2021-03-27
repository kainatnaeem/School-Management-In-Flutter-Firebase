import 'dart:io';

import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/api/student_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/notifier/student_notifier.dart';
import 'package:adminpanel/screens/students.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StudentForm extends StatefulWidget {
  final bool isUpdating;

  StudentForm({@required this.isUpdating});

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Student _currentStudent;
  String _imageUrl;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    StudentNotifier studentNotifier =
        Provider.of<StudentNotifier>(context, listen: false);

    if (studentNotifier.currentStudent != null) {
      _currentStudent = studentNotifier.currentStudent;
    } else {
      _currentStudent = Student();
    }

    _imageUrl = _currentStudent.image;
  }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Name',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
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
        _currentStudent.name = value;
      },
    );
  } // _buildRollNoField()

  Widget _buildRollNoField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Roll Number',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.rollNo,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Roll number is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentStudent.rollNo = value;
      },
    );
  }

  Widget _buildRegisterationNoField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Registration Number',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.registrationNo,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Registration number is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentStudent.registrationNo = value;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Phone Number',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.phone,
      keyboardType: TextInputType.text,
      maxLength: 13,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone is required';
        }

        if (value.length == 13) {
          return 'phone must be 13';
        }

        return null;
      },
      onSaved: (String value) {
        _currentStudent.phone = value;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Address',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.address,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Address must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentStudent.address = value;
      },
    );
  }

  Widget _buildfNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter  Father name',
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentStudent.fName,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Father name is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Father name must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentStudent.fName = value;
      },
    );
  }

  _onStudentUploaded(Student student) {
    StudentNotifier studentNotifier =
        Provider.of<StudentNotifier>(context, listen: false);
    studentNotifier.addStudent(student);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Students(),
      ),
    );
  }

  _saveStudent() {
    print('saveStudent Called');
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    print('form saved');

    uploadStudentAndImage(
        _currentStudent, widget.isUpdating, _imageFile, _onStudentUploaded);

    print("name: ${_currentStudent.name}");

    print("phone: ${_currentStudent.phone}");
    print("address: ${_currentStudent.address}");

    print("category: ${_currentStudent.fName}");

    print("_imageFile ${_imageFile.toString()}");
    print("_imageUrl $_imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    StudentNotifier studentNotifier = Provider.of<StudentNotifier>(context);
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
                  builder: (BuildContext context) => Students(),
                ),
              );
            }),
        title: Text("Add Students"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Form(
                            key: _formKey,
                            autovalidate: true,
                            child: Column(
                              children: <Widget>[
                                _showImage(),
                                SizedBox(height: 16),
                                Text(
                                  widget.isUpdating
                                      ? "Edit Student Form"
                                      : "Add Student Form",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.brown[400]),
                                ),
                                SizedBox(height: 12),
                                _imageFile == null && _imageUrl == null
                                    ? ButtonTheme(
                                        child: RaisedButton(
                                          color: Colors.brown[400],
                                          onPressed: () => _getLocalImage(),
                                          child: Text(
                                            'Add Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: 0),

                                //  _buildRegistrationField(),

                                _buildRollNoField(),
                                SizedBox(height: 10),
                                _buildRegisterationNoField(),
                                SizedBox(height: 10),
                                _buildNameField(),
                                SizedBox(height: 10),
                                _buildfNameField(),
                                SizedBox(height: 10),

                                _buildAddressField(),
                                SizedBox(height: 10),
                                _buildPhoneField(),

                                //   _buildedu(),
                              ],
                            )),
                      ],
                    ))),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          studentNotifier.currentStudent = null;

          _saveStudent();
        },
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[400],
      ),
    );
  }
}
