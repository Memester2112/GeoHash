import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  double latitude;
  double longitude;
  Geoflutterfire geo = Geoflutterfire();

  GeoFirePoint myLocation;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(fontSize: 25.0),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'LATITUDE'),
              onSaved: (value) => latitude = double.parse(value),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(fontSize: 25.0),
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: 'LONGITUDE'),
              onSaved: (value) {
                longitude = double.parse(value);
              },
            ),
            Center(
              child: RaisedButton(
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
                  _formKey.currentState.save();
                  if (_formKey.currentState.validate()) {
                    DocumentReference documentReference =
                        Firestore.instance.collection('locations2').document();
                    myLocation =
                        geo.point(latitude: latitude, longitude: longitude);
                    documentReference.setData({
                      'name': documentReference.documentID,
                      'position': myLocation.data
                    });
                    print("Latitude = $latitude");
                    print("Longitude = $longitude");
                  }
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      ),
    );
  }
}
