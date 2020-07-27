import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'location_list.dart';
import 'add_location.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHome(),
        '/location_list': (BuildContext context) => LocationList(),
        '/add_location': (BuildContext context) => AddLocation(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  double latitude, longitude;
  Geoflutterfire geo = Geoflutterfire();

  GeoFirePoint myLocation;

  @override
  void initState() {
    super.initState();
    Admob.initialize(
        'ca-app-pub-4093634308985967~5997591316'); //myAppID =ca-app-pub-4093634308985967~5997591316
  } //test Id = ca-app-pub-3940256099942544~3347511713

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is Text 1 ',
            style: TextStyle(fontSize: 25.0),
          ),

          Text(
            'This is Text 2 ',
            style: TextStyle(fontSize: 25.0),
          ),
          //Ad Here

          Text(
            'This is Text 3 ',
            style: TextStyle(fontSize: 25.0),
          ),
          Text(
            'This is Text 4 ',
            style: TextStyle(fontSize: 25.0),
          ),
          SizedBox(
            height: 20.0,
            child: Container(
              color: Colors.white,
            ),
          ),
          AdmobBanner(
            adSize: AdmobBannerSize.FULL_BANNER,
            adUnitId:
                'ca-app-pub-4093634308985967/2716821852', //my BannerAdId = ca-app-pub-4093634308985967/2716821852
            //test BannerAdId = ca-app-pub-3940256099942544/6300978111
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        onPressed: () {
          generateRandomPoint();
          DocumentReference documentReference =
              Firestore.instance.collection('locations').document();
          myLocation = geo.point(latitude: latitude, longitude: longitude);
          documentReference.setData({
            'name': documentReference.documentID,
            'position': myLocation.data
          });
          print("Latitude = $latitude");
          print("Longitude = $longitude");
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/location_list');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_location,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/add_location');
            },
          ),
        ],
      ),
    );
  }

  void generateRandomPoint() {
    Random random = Random();
    latitude = (random.nextInt(1801) - 900) / 10.0;
    longitude = (random.nextInt(3601) - 1800) / 10.0;
  }
}
