import 'dart:async';

import 'package:fl_uberapp/src/model/place_item_res.dart';
import 'package:fl_uberapp/src/model/step_res.dart';
import 'package:fl_uberapp/src/repository/place_services.dart';
import 'package:fl_uberapp/src/resources/widgets/home_menu.dart';
import 'package:fl_uberapp/src/resources/widgets/ride_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var ggKey = GlobalKey();
  Map<String, Marker> markers = Map();
  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    print("build UI");
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
//              key: ggKey,
//              markers: Set.of(markers.values),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7915178, 106.7271422),
                zoom: 14.4746,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Taxi App",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: FlatButton(
                        onPressed: () {
                          print("click menu");
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Image.asset("ic_menu.png")),
                    actions: <Widget>[Image.asset("ic_notify.png")],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
//    if (markers[mkId] != null) {
//      _mapController.removeMarker(markers[mkId]);
//    }

    markers[mkId] = Marker(
        mkId,
        MarkerOptions(
            position: LatLng(place.lat, place.lng),
            infoWindowText: InfoWindowText(place.name, place.address)));
//    markers[mkId] = Marker(
//        markerId: mkId,
//        position: LatLng(place.lat, place.lng),
//        infoWindow: InfoWindow(title: place.name, snippet: place.address));
//    setState(() {});

//    _mapController.removeMarker()
    _mapController.addMarker(markers[mkId].options);
    print("added marker: " + mkId);

    if (markers.values.length > 1) {
      LatLng s, n;
      if (markers["from_address"].options.position.latitude <=
          markers["to_address"].options.position.latitude) {
        s = markers["from_address"].options.position;
        n = markers["to_address"].options.position;
      } else {
        n = markers["from_address"].options.position;
        s = markers["to_address"].options.position;
      }
      print(s);
      print(n);
//      print(s.la)

      LatLngBounds bounds = LatLngBounds(northeast: n, southwest: s);
      _mapController.moveCamera(CameraUpdate.newLatLngBounds(bounds, 10));

      PlaceService.getStep(
              markers["from_address"].options.position.latitude,
              markers["from_address"].options.position.longitude,
              markers["to_address"].options.position.latitude,
              markers["to_address"].options.position.longitude)
          .then((vl) {
        List<Steps> rs = vl;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths
              .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }
        _mapController.addPolyline(PolylineOptions(
            points: paths, color: Color(0xFF3ADF00).value, width: 4));
      });

//      GoogleMap k = ggKey.currentWidget;
//      k.li

    } else {
      _mapController
          .moveCamera(CameraUpdate.newLatLng(markers[mkId].options.position));
    }
  }
}
