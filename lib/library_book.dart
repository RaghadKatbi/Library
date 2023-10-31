import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'l10n/app_localizations.dart';
class library_book extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return library_State();
  }

}
class library_State extends State<library_book>
{
  List<double> lat=[34.3333333,36.2021,30,12345,38.32343];
  List<double> lng=[39.3123333,37.1343,38,12345,34.32343];
  List name=["غراس","نور","نون","القلم"];
  List des=["غراس","نور","نون","القلم"];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCameraposition =
  CameraPosition(target: LatLng(33.515343, 36.289590), zoom: 17.4746);
  LatLng CurrentPosition = _initialCameraposition.target;
  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 17.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
  Future<void> _getMyLocation() async {
    LocationData _myLocation = await Location().getLocation();
    _animateCamera(LatLng(_myLocation.latitude!, _myLocation.longitude!));
  }
  void initState() {
    _getMyLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)?.location}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        // shadowColor: Colors.teal.withOpacity(0.9),
        backgroundColor: Colors.cyan.shade600,
      ),
      body:Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraposition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller.complete(controller);
              });
            },
            markers:  Set<Marker>.of(
              <Marker>[
                for(int i=0;i<3;i++)
                  Marker(
                    draggable: true,
                    markerId: MarkerId(i.toString()),
                    position: LatLng((lat[i]), (lng[i])),
                    icon: BitmapDescriptor.defaultMarker,
                    infoWindow: InfoWindow(
                        title: "${name[i]}",
                        snippet: "${des[i]}"
                    ),
                  )
              ],
            ),
            onCameraMove: (CameraPosition newpos) {
              setState(() {
                CurrentPosition = newpos.target;
              });
            },
            // markers: ,
          )
        ],
      )
    );
  }

}
