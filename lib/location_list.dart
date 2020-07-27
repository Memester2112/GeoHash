import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: 0, longitude: 0);
    CollectionReference collectionReference =
        Firestore.instance.collection('locations2');
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(
            center: center, radius: 50, field: 'position', strictMode: true);
    return SingleChildScrollView(
      child: Scaffold(
        body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(
                'ERROR PLEASE TRY AGAIN',
                style: TextStyle(fontSize: 25.0),
              );
            }

            return ListView(
              children: <Widget>[
                Text('SNAPSHOT HAS DATA'),
                for (int i = 0; i < snapshot.data.length; i++)
                  ListTile(
                    leading: Text(i.toString()),
                    title: Text(snapshot.data[i]['name']),
                    subtitle: Divider(
                      color: Colors.pink,
                    ),
                  ),
              ],
            );
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ),
      ),
    );
  }
}
