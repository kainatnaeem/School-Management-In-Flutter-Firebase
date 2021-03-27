import 'package:adminpanel/screens/afterlogin.dart';
import 'package:adminpanel/screens/mygallery/uploadImages.dart';
import 'package:adminpanel/screens/mygallery/viewImages.dart';
import 'package:flutter/material.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
 final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Colors.black38,
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
          title: Text('Gallery'),
          centerTitle: true,
          bottom:   TabBar(
            tabs: [
              Tab(icon: Icon(Icons.image),text: 'Images',),
              Tab(icon: Icon(Icons.cloud_upload),text: "Upload Images",),
            ],
            indicatorColor: Colors.red,
            indicatorWeight: 5.0,
          ),
        ),

        body: TabBarView(
          children: <Widget>[
           // Text("view"),
            //Text("upload"),
              ViewImages(),
             UploadImages(globalKey: _globalKey,),
          ],
        ),
      ),
    );
  }
}
