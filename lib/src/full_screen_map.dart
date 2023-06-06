import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:async'; // ignore: unnecessary_import
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController? mapController;

  final center = const LatLng(9.894701, -84.064173);
  String selectedTheme =
      'mapbox://styles/stevenmontes/clijlmlh400ti01pd73nt0u07';

  final darkThemeMap = 'mapbox://styles/stevenmontes/clijlmlh400ti01pd73nt0u07';
  final monochromeThemeMap =
      'mapbox://styles/stevenmontes/clijlkb1s00sb01qfew8gdlp2';

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButtons(),
      body: createMap(),
    );
  }

  Column floatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            mapController!.addSymbol(SymbolOptions(
                textField: 'Punto de partida',
                textOffset: const Offset(0, 1),
                geometry: center,
                iconImage: 'networkImage'));
          },
          child: const Icon(Icons.sentiment_dissatisfied),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomIn());
          },
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomOut());
          },
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            if (selectedTheme == darkThemeMap) {
              selectedTheme = monochromeThemeMap;
            } else {
              selectedTheme = darkThemeMap;
            }

            setState(() {});
          },
          child: const Icon(Icons.add_to_home_screen),
        )
      ],
    );
  }

  MapboxMap createMap() {
    return MapboxMap(
        styleString: selectedTheme,
        accessToken:
            'sk.eyJ1Ijoic3RldmVubW9udGVzIiwiYSI6ImNsaWpsMGoxbDA3ejYzZ3BoYjZyZjdmMXQifQ.lfbMcV4xuykZWF62EvIpGA',
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(zoom: 14, target: center));
  }
}
