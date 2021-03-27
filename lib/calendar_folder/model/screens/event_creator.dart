  
import 'package:adminpanel/calendar_folder/model/screens/event_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:adminpanel/calendar_folder/model/event_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:adminpanel/screens/afterlogin.dart';
import 'package:intl/intl.dart';

final AuthNotifier  _auth =AuthNotifier();
class EventData {
  String title = '';
  DateTime time;
  String summary = '';
}
class EventCreator extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return new EventCreatorState();
  }


}

class EventCreatorState extends State<EventCreator> {
  
   DateTime _dateTime;
  final dateFormat = DateFormat("MMMM d, yyyy 'at' h:mma");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  EventData _eventData = new EventData();

  @override
  Widget build(BuildContext context) {

    final titleWidget = new TextFormField(
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
          hintText: 'Event Name',
          labelText: 'Event Title',
          contentPadding: EdgeInsets.all(16.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
          )
      ),
      
      style: Theme.of(context).textTheme.bodyText1,
      validator: this._validateTitle,
      onSaved: (String value) => this._eventData.title = value,
    );

    final notesWidget = new TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Detail',
        labelText: 'Enter detail here',
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        )
      ),
   
      style: Theme.of(context).textTheme.headline,
      onSaved: (String value) => this._eventData.summary = value,
    );
    
    return new Scaffold(
      appBar: new AppBar(
       leading:   IconButton(
              icon: new Icon(Icons.arrow_back),color: Colors.white,iconSize: 40,
            
              highlightColor: Colors.pink,
              onPressed: (){ 
               
            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>AfterLogin(),
                    ),
                  );
               } ),
        title: new Text('Create New Event'),
        backgroundColor: Colors.brown[400],
        
        actions: <Widget>[
          new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15.0),
            // child: new InkWell(
            //   child: new Text(
            //     'SAVE',
            //     style: TextStyle(
            //       fontSize: 20.0),
            //   ),
            //   onTap: () => _saveNewEvent(context),
              
            // ),
          ),
          SizedBox(height: 16.0),
              //notesWidget,
        ],
        
      ),
      body: SingleChildScrollView(
              child: new Form(
          key: this._formKey,
          child: new Container(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                titleWidget,
                SizedBox(height: 16.0),
                 FormBuilderDateTimePicker(
                    name: "date",
                    initialValue: 
                        DateTime.now(),
                    initialDate: DateTime.now(),
                    fieldHintText: "Add Date",
                    initialDatePickerMode: DatePickerMode.day,
                    inputType: InputType.date,
                    format: DateFormat('EEEE, dd MMMM, yyyy'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.calendar_today_sharp),
                    ),
                   
                  validator: this._validateDate,
                  onSaved: (DateTime value) => this._eventData.time = value,
                  ),
             
              notesWidget,
                  SizedBox(height: 16.0),
                             IconButton(
                               
                icon: new Icon(Icons.save),color: Colors.black,iconSize: 40,
                highlightColor: Colors.pink,
                onPressed: ()
                { 
                  _saveNewEvent(context);
              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AfterLogin()
                      ),
                    );
                 } ), 


           
              ],
            ),
          )

        ),
      ),
    );
  }
  
  String _validateTitle(String value) {
    if (value.isEmpty) {
      return 'Please enter a valid title.';
    } else {
      return null;
    }
  }

  String _validateDate(DateTime value) {
    if ( (value != null)
        && (value.day >= 1 && value.day <= 31)
        && (value.month >= 1 && value.month <= 12)
        && (value.year >= 2015 && value.year <= 3000)) {
      return null;
    } else {
      return 'Please enter a valid event date.';
    }
  }

  Future _saveNewEvent(BuildContext context) async {
   User currentUser = _auth.currentUser;
    print('current user: $currentUser');

    if (currentUser != null && this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      FirebaseFirestore.instance.collection('calendar_events').doc()
          .set({'name': _eventData.title, 'summary': _eventData.summary,
        'time': _eventData.time, 'email': currentUser.email});
 
       
    } else {
      print('Error validating data and saving to firestore.');
    }
  }

}