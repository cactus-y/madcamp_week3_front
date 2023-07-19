import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madcamp_week3/api/data/Menu.dart';
import 'dart:ui' as ui;
import 'package:madcamp_week3/map_sample.dart';
import 'package:provider/provider.dart';





class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  final LatLng _center = const LatLng(36.371144, 127.361941);
  List<LatLng> kaist_points = [
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
  List<LatLng> hyu_Points = [
    LatLng(37.554005673871416, 127.044227295529),
    LatLng(37.55474289545377, 127.04830193343271),
    LatLng(37.556435842068964, 127.05052125307036),
    LatLng(37.55715643538768, 127.05099707848228),
    LatLng(37.560130170002466, 127.04995784526804),
    LatLng(37.56000426857184,  127.0493918600057),
    LatLng(37.559013612470345, 127.04832732590043),
    LatLng(37.55867128919677, 127.04819129093862),
    LatLng(37.560041565027056, 127.0462907444795),
    LatLng(37.55903364861028, 127.04312111525512),
  ];
  List<LatLng> go_points = [
    LatLng(37.592422352448956, 127.03610883187434),
    LatLng(37.59103611745382, 127.03160171869139),
    LatLng(37.59119846408331, 127.03096771351115),
    LatLng(37.59123472639909, 127.03010719935462),
    LatLng(37.59231618344867, 127.02904328088508),
    LatLng(37.592514550529096, 127.02843191887148),
    LatLng(37.59298312061246, 127.02820563678769),
    LatLng(37.593091478751646, 127.02718660464426),
    LatLng(37.594587299768875, 127.0264171671053),
    LatLng(37.59210112578081, 127.02376673348111),
    LatLng(37.59047929421761, 127.02399267050816),
    LatLng(37.5881002624196, 127.02593933861857),
    LatLng(37.58624439859666, 127.02510086686374),
    LatLng(37.586028284035805, 127.02451205217426),
    LatLng(37.58546969187788, 127.0243986502168),
    LatLng(37.58500129573562, 127.02380976330733),
    LatLng(37.58265853193473, 127.02469209055182),
    LatLng(37.582406055936296, 127.02562036321913),
    LatLng(37.581558937249234, 127.02645784816335),
    LatLng(37.58235154174411, 127.02763555498379),
    LatLng(37.58341456375229, 127.028269955739),
    LatLng(37.583684719260575, 127.02885878155735),
    LatLng(37.58537859593376, 127.02881980893339),
    LatLng(37.58548680025758, 127.02846887231443),
    LatLng(37.586036495444375, 127.02809545681366),
    LatLng(37.58676614975098, 127.02871844521081),
    LatLng(37.58831587906299, 127.02862846214185),
    LatLng(37.58948742651072, 127.027547613286),
    LatLng(37.59076230802173, 127.02764432596271),
    LatLng(37.59030214303592, 127.03032761460423),
    LatLng(37.5906218809668, 127.03076932806734),
    LatLng(37.59042811286497, 127.03097871695495),
    LatLng(37.58983365756701, 127.03020853783799),
    LatLng(37.58920742141217, 127.03038944386118),
    LatLng(37.58836501097249, 127.03032116745496),
    LatLng(37.58795950742093, 127.03054178695913),
    LatLng(37.586928004476995, 127.03002054889762),
    LatLng(37.58659903922418, 127.03042234956392),
    LatLng(37.5865718710939, 127.03095447467155),
    LatLng(37.58645473015009, 127.03099971427682),
    LatLng(37.58652184010116, 127.03272069195107),
    LatLng(37.58967889564409, 127.03589803989087),
    LatLng(37.5902644628092, 127.03615307975359),
  ];
  List<LatLng> sung_suwon_points = [
    LatLng(37.29069347347947, 126.97576452599839),
    LatLng(37.29110806055415, 126.97630571880387),
    LatLng(37.291234627711866, 126.97851609645325),
    LatLng(37.29289264230821, 126.97910207511325),
    LatLng(37.296965101533374, 126.97783775710276),
    LatLng(37.29640623752342, 126.97668752308712),
    LatLng(37.29748694756109, 126.9741156749644),
    LatLng(37.29663969493024, 126.9728753361881),
    LatLng(37.2969277898112, 126.9718601687072),
    LatLng(37.296621394169286, 126.97167982774647),
    LatLng(37.29669321871358, 126.97061962612378),
    LatLng(37.29101655258179, 126.97010306373542),];
  List<LatLng> postech_points = [
    LatLng(36.010254234445505, 129.32742477129486),LatLng(
        36.015785543076845, 129.3246818136003),LatLng(
        36.01974553701034, 129.32490908671343),LatLng(
        36.01995783156954, 129.32418332674985),LatLng(
        36.023522943356205, 129.3234007682315),LatLng(
        36.02865015153182, 129.31265892050294),LatLng(
        36.028352062650725, 129.31129696633164),LatLng(
        36.02723245681304, 129.31141953262667),LatLng(
        36.024945628313866, 129.31133051685308),LatLng(
        36.02196296666722, 129.31368342651925),LatLng(
        36.021502049306555, 129.31515615754094),LatLng(
        36.02096862902304, 129.31571728089574),LatLng(
        36.02009944473181, 129.31593583732726),LatLng(
        36.01840097327482, 129.31803770990606),LatLng(
        36.01419525022106, 129.31933402438918),LatLng(
        36.01335007433298, 129.31831115201575),LatLng(
        36.008359575936765, 129.3229111650574),LatLng(
        36.00787374090585, 129.32287472673536),LatLng(
        36.007800810033125, 129.32384843514342),LatLng(
        36.008171237429465, 129.32519002113403),LatLng(
        36.00801038935188, 129.32605025429655),LatLng(
        36.00965099738736, 129.32600975984846),];
  List<LatLng> sung_seoul_points = [
    LatLng(37.58497662315246, 126.99677328561458),LatLng(
        37.58654434189063, 126.99645620075923),LatLng(
        37.58670649662908, 126.99573158079285),LatLng(
        37.58823813426437, 126.99452000735288),LatLng(
        37.58853547955545, 126.99491626758926),LatLng(
        37.58892289790469, 126.9947237603955),LatLng(
        37.58857145965363, 126.9936821290642),LatLng(
        37.590319254274995, 126.9915872977186),LatLng(
        37.589868657190344, 126.99027393312123),LatLng(
        37.58757104912226, 126.98937977846366),LatLng(
        37.58694038228528, 126.98969688692982),LatLng(
        37.58722896571231, 126.99341051103085),LatLng(
        37.58475133932251, 126.99566376180637),];


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle('[{"featureType": "poi","elementType": "labels.icon","stylers": [{"visibility": "off"}]}]'

    );
    Provider.of<LNGModel>(context,listen: false).update(mapController);
  }
  @override
  void initState() {
    super.initState();
    get_icon();

  }
  void move_camera(LatLng to_lng , double to_zoom){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: to_lng,zoom: to_zoom)
    ));
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
        onTap: () async {
          Menu? temp_menu = await get("카이스트","카이마루");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"카이마루");
        },
        infoWindow: InfoWindow(title:  "카이마루"),
      ));
      _markers.add(Marker(
        markerId: MarkerId('west'),
        position: LatLng( 36.366955, 127.360496),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("카이스트","서맛골");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"서맛골");
          },
        infoWindow: InfoWindow(title:  "서맛골",),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east1'),
        position: LatLng( 36.369135, 127.363835),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("카이스트","동맛골_학생식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"동맛골_학생식당");
        },
        infoWindow: InfoWindow(title:  "동맛골_학생식당",),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east2'),
        position: LatLng( 36.369287, 127.363499),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("카이스트","동맛골_교직원식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"동맛골_교직원식당");
        },
        infoWindow: InfoWindow(title:  "동맛골_교직원식당",),
      ));
      _markers.add(Marker(
        markerId: MarkerId('east3'),
        position: LatLng( 36.374537, 127.364791),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("카이스트","교수회관");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"교수회관");
        },
        infoWindow: InfoWindow(title:  "교수회관",onTap: (){} ),
      ));

      _markers.add(Marker(
        markerId: MarkerId('student_cafeteria'),
        position: LatLng( 37.556339, 127.043997),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","학생식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"학생식당");
        },
        infoWindow: InfoWindow(title:  "학생식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('life_cafeteria'),
        position: LatLng( 37.556690, 127.046741),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","생활과학관식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"생활과학관식당");
        },
        infoWindow: InfoWindow(title:  "생활과학관식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('material_cafeteria'),
        position: LatLng( 37.554623, 127.045164),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","신소재공학관식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"신소재공학관식당");
        },
        infoWindow: InfoWindow(title:  "신소재공학관식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('life_1_cafeteria'),
        position: LatLng( 37.558947, 127.047096),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","제1생활관식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"제1생활관식당");
        },
        infoWindow: InfoWindow(title:  "제1생활관식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('life_2_cafeteria'),
        position: LatLng( 37.559826, 127.049819),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","제2생활관식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"제2생활관식당");
        },
        infoWindow: InfoWindow(title:  "제2생활관식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('hang_park'),
        position: LatLng( 37.557759, 127.048496),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("한양대학교","행원파크");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"행원파크");
        },
        infoWindow: InfoWindow(title:  "행원파크",onTap: (){} ),
      ));

      _markers.add(Marker(
        markerId: MarkerId('go_1'),
        position: LatLng( 37.588969, 127.030828),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","수당삼양패컬티하우스송림");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"수당삼양패컬티하우스송림");
        },
        infoWindow: InfoWindow(title:  "수당삼양패컬티하우스송림",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('go_2'),
        position: LatLng(37.584444,127.027441),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","자연계학생식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"자연계학생식당");
        },
        infoWindow: InfoWindow(title:  "자연계학생식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('go_3'),
        position: LatLng( 37.591395, 127.028802),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","안암학사식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"안암학사식당");
        },
        infoWindow: InfoWindow(title:  "안암학사식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('go_4'),
        position: LatLng( 37.584145, 127.024582),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","산학관식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"산학관식당");
        },
        infoWindow: InfoWindow(title:  "산학관식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('go_5'),
        position: LatLng( 37.592033, 127.035681),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","교우회관학생식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"교우회관학생식당");
        },
        infoWindow: InfoWindow(title:  "교우회관학생식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('go_6'),
        position: LatLng(37.586907, 127.032299),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("고려대학교","학생회관학생식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"학생회관학생식당");
        },
        infoWindow: InfoWindow(title:  "학생회관학생식당",onTap: (){} ),
      ));

      _markers.add(Marker(
        markerId: MarkerId('seoul_1'),
        position: LatLng(37.587610, 126.994551),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_서울캠퍼스","패컬티식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"패컬티식당");
        },
        infoWindow: InfoWindow(title:  "패컬티식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('seoul_2'),
        position: LatLng(37.587411, 126.994540),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_서울캠퍼스","은행골식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"은행골식당");
        },
        infoWindow: InfoWindow(title:  "은행골식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('seoul_3'),
        position: LatLng(37.587371, 126.990775),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_서울캠퍼스","법고을식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"법고을식당");
        },
        infoWindow: InfoWindow(title:  "법고을식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('seoul_4'),
        position: LatLng(37.588614, 126.993178),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_서울캠퍼스","옥류천식당");
          print(temp_menu?.date);
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"옥류천식당");
        },
        infoWindow: InfoWindow(title:  "옥류천식당",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('seoul_5'),
        position: LatLng(37.588540, 126.992723),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_서울캠퍼스","금잔디식당");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"금잔디식당");
        },
        infoWindow: InfoWindow(title:  "금잔디식당",onTap: (){} ),
      ));


      _markers.add(Marker(
        markerId: MarkerId('suwon_1'),
        position: LatLng(37.294381, 126.973753),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_수원캠퍼스","학생식당(행단골)");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"학생식당(행단골)");
        },
        infoWindow: InfoWindow(title:  "학생식당(행단골)",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('suwon_2'),
        position: LatLng(37.293952, 126.972538),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_수원캠퍼스","교직원식당(구시재)");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"교직원식당(구시재)");
        },
        infoWindow: InfoWindow(title:  "교직원식당(구시재)",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('suwon_3'),
        position: LatLng(37.295073, 126.977472),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("성균관대학교_수원캠퍼스","공대식당(해오름)");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"공대식당(해오름)");
        },
        infoWindow: InfoWindow(title:  "공대식당(해오름)",onTap: (){} ),
      ));

      _markers.add(Marker(
        markerId: MarkerId('po_1'),
        position: LatLng(36.015736, 129.322379),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("포항공과대학교","학생식당_해동아우름홀");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"학생식당_해동아우름홀");
        },
        infoWindow: InfoWindow(title:  "학생식당_해동아우름홀",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('po_2'),
        position: LatLng(36.015757, 129.322449),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("포항공과대학교","위즈덤");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"위즈덤");
        },
        infoWindow: InfoWindow(title:  "위즈덤",onTap: (){} ),
      ));
      _markers.add(Marker(
        markerId: MarkerId('po_3'),
        position: LatLng(36.014126, 129.320954),
        icon: markerbitmap,
        onTap: () async {
          Menu? temp_menu = await get("포항공과대학교","더블루힐");
          Provider.of<MenuModel>(context,listen: false).updateText(temp_menu!,"더블루힐");
        },
        infoWindow: InfoWindow(title:  "더블루힐",onTap: (){} ),
      ));


    });
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
            points: kaist_points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
          Polygon(
            polygonId: PolygonId("2"),
            points: hyu_Points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
          Polygon(
            polygonId: PolygonId("3"),
            points: go_points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
          Polygon(
            polygonId: PolygonId("4"),
            points: postech_points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
          Polygon(
            polygonId: PolygonId("5"),
            points: sung_seoul_points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
          Polygon(
            polygonId: PolygonId("6"),
            points: sung_suwon_points,
            fillColor: Color(0xFFFFFFF0).withOpacity(0.2),
            strokeWidth: 2,
          ),
        },
      ),
    );
  }
}



