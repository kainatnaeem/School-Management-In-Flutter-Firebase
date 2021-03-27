import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/screens/detail.dart';
import 'package:adminpanel/screens/studentsearchresult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'afterlogin.dart';

Student myuser;

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";
  @override
  Widget build(BuildContext context) {
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
                  builder: (BuildContext context) => AfterLogin(),
                ),
              );
            }),
        backgroundColor: Colors.brown,
        title:Text("Search Students"),
        centerTitle: true,
        // title: Card(
        //   child: TextField(
        //     decoration: InputDecoration(
        //        icon: Icon(Icons.search), hintText: 'search by reg no'),
        //     onChanged: (val) {
        //       setState(() {
        //         name = val;
        //       });
        //     },
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Container(
           height:MediaQuery.of(context).size.height*0.07,
            color:Colors.brown,
            
          ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
            child: TextField(
              decoration: InputDecoration(
                 icon: Icon(Icons.search), hintText: 'Search by registration no'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
        ),
          ),   
          Flexible(
                      child: StreamBuilder<QuerySnapshot>(
              stream: (name != "" && name != null)
                  ? FirebaseFirestore.instance
                      .collection('Students')
                      .where("registrationNo", isEqualTo: name)
                      .snapshots()
                  : FirebaseFirestore.instance.collection("Students").snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          //return buildResultCard(data);

                          return Card(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentSearchResult(data: data)),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          data['image'],
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          data['registrationNo'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) // Text("k"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
