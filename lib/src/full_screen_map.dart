import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

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
