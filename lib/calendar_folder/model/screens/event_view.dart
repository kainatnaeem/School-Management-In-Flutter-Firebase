import 'dart:async';

import 'package:adminpanel/calendar_folder/model/event_model.dart';
import 'package:adminpanel/calendar_folder/model/screens/event_creator.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

final AuthNotifier  _auth =AuthNotifier();
class EventsView extends StatefulWidget {
 


  @override
  State<StatefulWidget> createState() {
    return EventsViewState();
  }
}

class EventsViewState extends State<EventsView> {
    CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
       
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onFabClicked,
        child: new Icon(Icons.add),
      ),
      // body: FutureBuilder(
      //   future: _getEvents(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //       case ConnectionState.waiting:
      //         return new LinearProgressIndicator();
      //       case ConnectionState.done:
      //       default:
      //         if (snapshot.hasError)
      //           return new Text('Error: ${snapshot.error}');
      //         else {
      //           return ListView(
      //             children: snapshot.data.docs.map((document) {
      //               DateTime _eventTime = document.data()['time'];
      //               var eventDateFormatter = new DateFormat("MMMM d, yyyy 'at' h:mma");

      //               return new GestureDetector(
      //                 onTap: () => _onCardClicked(document),
      //                 child: new Card(
      //                   color: Colors.amberAccent,
      //                   elevation: 10.0,
      //                   shape: Border.all(color: Colors.black),
      //                   child: new Row(
      //                     children: <Widget>[
      //                       new Expanded(
      //                         child:
      //                         new Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: <Widget>[
      //                             new Container(
      //                               padding: EdgeInsets.all(10.0),
      //                               child:  new Text('Event: ' + document.data()['name'],
      //                                 style: Theme.of(context).textTheme.bodyText1,
      //                               ),
      //                             ),
      //                             new Container(
      //                               padding: EdgeInsets.all(10.0),
      //                               child:  new Text('Time: ' + eventDateFormatter.format(_eventTime),
      //                                   style: Theme.of(context).textTheme.bodyText2
      //                               ),
      //                             ),
      //                             new Container(
      //                               padding: EdgeInsets.all(10.0),
      //                               child:  new Text('Summary: ' + document.data()['summary'],
      //                                   style: Theme.of(context).textTheme.bodyText1
      //                               ),
      //                             ),
      //                         ],
      //                       ),
      //                     ),
      //                     new Container(
      //                       child: new IconButton(
      //                         iconSize: 30.0,
      //                         padding: EdgeInsets.all(5.0),
      //                         icon: new Icon(Icons.delete),
      //                         onPressed: () => _deleteEvent(document))
      //                     ),

      //                     ],
      //                   ),
      //                 )
      //               );
      //             }).toList(),
      //           );
      //         }
      //     }
      //   }
      // ),

  body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(8.0),
              child: TableCalendar(
                calendarController: _calendarController,
                weekendDays: [6],
                headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  headerMargin: const EdgeInsets.only(bottom: 8),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            StreamBuilder(
              // stream: eventDBS.streamQueryList(
              //   args: [
              //     QueryArgsV2('user_id',
              //         isEqualTo: context.read(notifier.user).user.id),
              //   ],
              // ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Text("Error"),
                  );
                }
                if (snapshot.hasData) {
                  List<Event> events = snapshot.data;
                  return ListView.builder(
                    itemCount: events.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                      return ListTile(
                        title: Text(event.title),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.edit),
                        //   onPressed: () => Navigator.pushNamed(
                        //       context, AppRoutes.editEvent,
                        //       arguments: event),
                        // ),
                        subtitle: Text("kk"),
                        // onTap: () {
                        //   Navigator.pushNamed(
                        //     context,
                        //     AppRoutes.viewEvent,
                        //     arguments: event,
                        //   );
                        // },
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),



    );
  }

  void _onCardClicked(DocumentSnapshot document) {
    Event event = new Event(document.data()['name'], document.data()['summary'],
        document.data()['time'], document.id);
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)
      => new EventCreator()));
  }


  void _deleteEvent(DocumentSnapshot document) {
    setState(() {
      FirebaseFirestore.instance.collection('calendar_events').doc(document.id).delete();
    });
  }

  void _onFabClicked() {
  

    Navigator.push(context, MaterialPageRoute(
            builder: (context) => EventCreator()
        )
    );
  }
}