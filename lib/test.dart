import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
//void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  final LatLng _center = const LatLng(36.371144, 127.361941);
  List<LatLng> polygonPoints = [
    LatLng(36.369525, 127.370267),
    LatLng(36.370884, 127.368203),
    LatLng(36.375215, 127.366011),
    LatLng(36.376283, 127.362171),
    LatLng(36.379027, 127.357345),
    LatLng(36.377825, 127.356331),
    LatLng(36.373123, 127.356186),
    LatLng(36.372234, 127.356591),
    LatLng(36.371785, 127.357135),
    LatLng(36.371600, 127.356958),
    LatLng(36.371449, 127.356245),
    LatLng(36.371438, 127.355293),
    LatLng(36.369775, 127.355242),
    LatLng(36.363275, 127.359720),

  ];
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle('[{"featureType": "poi","elementType": "labels.icon","stylers": [{"visibility": "off"}]}]'
    );
  }


  @override
  void initState() {
    super.initState();
    get_icon();
  }
  Future<void> get_icon() async {

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size.infinite),
      "assets/marker.png",);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('kaimaru'),
        position: LatLng( 36.373772, 127.359185),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "카이마루",onTap: (){print("hello");},),
      ));
      _markers.add(Marker(
        markerId: MarkerId('west'),
        position: LatLng( 36.366955, 127.360496),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "서맛골",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east1'),
        position: LatLng( 36.369135, 127.363835),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "동맛골_학생식당",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east2'),
        position: LatLng( 36.369287, 127.363499),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "동맛골_교직원식당",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east3'),
        position: LatLng( 36.374537, 127.364791),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "교수회관",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('club'),
        position: LatLng( 36.369492, 127.363375),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "패컬티클럽",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('big'),
        position: LatLng( 36.366996, 127.360628),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "더큰도시락",onTap: (){print("hello");} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('tae'),
        position: LatLng( 36.373085, 127.360046),
        icon: markerbitmap,
        onTap: (){print("kaimaru");},
        infoWindow: InfoWindow(title:  "태울관식당",onTap: (){print("hello");} ),
      ));
    });
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        markers: _markers,
        polygons: {
          Polygon(
            polygonId: PolygonId("1"),
            points: polygonPoints,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
        },
      ),
    );
  }
}
