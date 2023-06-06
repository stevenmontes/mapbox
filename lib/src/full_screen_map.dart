import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController? mapController;

  var isLight = true;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
          accessToken:
              'sk.eyJ1Ijoic3RldmVubW9udGVzIiwiYSI6ImNsaWpsMGoxbDA3ejYzZ3BoYjZyZjdmMXQifQ.lfbMcV4xuykZWF62EvIpGA',
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
              zoom: 14, target: LatLng(9.894701, -84.064173))),
    );
  }
}
