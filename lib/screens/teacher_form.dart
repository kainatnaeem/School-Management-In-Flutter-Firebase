import 'dart:io';

import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TeacherForm extends StatefulWidget {
  final bool isUpdating;

  TeacherForm({@required this.isUpdating});

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends State<TeacherForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List _subingredients = [];
  Teacher _currentTeacher;
  String _imageUrl;
  File _imageFile;
  TextEditingController subingredientController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    TeacherNotifier teacherNotifier =
        Provider.of<TeacherNotifier>(context, listen: false);

    if (teacherNotifier.currentTeacher != null) {
      _currentTeacher = teacherNotifier.currentTeacher;
    } else {
      _currentTeacher = Teacher();
    }

    _subingredients.addAll(_currentTeacher.subIngredients);
    _imageUrl = _currentTeacher.image;
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
        labelText: 'Name',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentTeacher.name,
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
        _currentTeacher.name = value;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentTeacher.phone,
      keyboardType: TextInputType.text,
      maxLength: 13,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone is required';
        }

        if (value.length < 13) {
          return 'Phone must be 13';
        }

        return null;
      },
      onSaved: (String value) {
        _currentTeacher.phone = value;
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
      initialValue: _currentTeacher.address,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Addressis required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Address must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentTeacher.address = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentTeacher.email,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (val) {
        return RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val)
            ? null
            : "Please Enter Correct Email";
      },
      onSaved: (String value) {
        _currentTeacher.email = value;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(3),
      ),
      initialValue: _currentTeacher.category,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15, color: Colors.black),
      validator: (String value) {
        if (value.isEmpty) {
          return 'description is required';
        }

        if (value.length < 1 || value.length > 20) {
          return 'description must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentTeacher.category = value;
      },
    );
  }

  _buildSubingredientField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: subingredientController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Skills',
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          contentPadding: EdgeInsets.all(3),
        ),
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  _onTeacherUploaded(Teacher teacher) {
    TeacherNotifier teacherNotifier =
        Provider.of<TeacherNotifier>(context, listen: false);
    teacherNotifier.addTeacher(teacher);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Professors(),
      ),
    );
  }

  _addSubingredient(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _subingredients.add(text);
      });
      subingredientController.clear();
    }
  }

  _saveTeacher() {
    print('saveteacher Called');
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    print('form saved');

    _currentTeacher.subIngredients = _subingredients;

    uploadTeacherAndImage(
        _currentTeacher, widget.isUpdating, _imageFile, _onTeacherUploaded);

    print("name: ${_currentTeacher.name}");
    print("email: ${_currentTeacher.email}");
    print("phone: ${_currentTeacher.phone}");
    print("address: ${_currentTeacher.address}");

    print("category: ${_currentTeacher.category}");
    print("subingredients: ${_currentTeacher.subIngredients.toString()}");
    print("_imageFile ${_imageFile.toString()}");
    print("_imageUrl $_imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
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
                  builder: (BuildContext context) => Professors(),
                ),
              );
            }),
        title: Text("SMS App"),
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
                                  ? "Edit Professor"
                                  : "Add Teachers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30, color: Colors.brown[400]),
                            ),
                            SizedBox(height: 12),
                            _imageFile == null && _imageUrl == null
                                ? ButtonTheme(
                                    child: RaisedButton(
                                      color: Colors.brown[400],
                                      onPressed: () => _getLocalImage(),
                                      child: Text(
                                        'Add Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : SizedBox(height: 0),
                            _buildNameField(),
                            SizedBox(height: 10),
                            _buildCategoryField(),
                            SizedBox(height: 10),
                            _buildEmailField(),
                            SizedBox(height: 10),
                            _buildAddressField(),
                            SizedBox(height: 10),
                            _buildPhoneField(),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildSubingredientField(),
                                ButtonTheme(
                                  child: RaisedButton(
                                    color: Colors.brown[400],
                                    child: Text('Add',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () => _addSubingredient(
                                        subingredientController.text),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            GridView.count(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(8),
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              children: _subingredients
                                  .map(
                                    (ingredient) => Card(
                                      color: Colors.black54,
                                      child: Center(
                                        child: Text(
                                          ingredient,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        )),
                  ],
                )),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          teacherNotifier.currentTeacher = null;

          _saveTeacher();
        },
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[400],
      ),
    );
  }
}
