import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madcamp_week3/api/data/University.dart';
import 'package:madcamp_week3/api/restaurant_api.dart';
import 'package:madcamp_week3/api/university_api.dart';
import 'package:madcamp_week3/test.dart';
import 'package:provider/provider.dart';

import 'api/data/Menu.dart';
import 'api/data/Restaurant.dart';
import 'api/menu_api.dart';

class MenuModel extends ChangeNotifier {
  Menu menu =  new Menu(menuId: '-', restaurantId: "-", date: '-', breakfast: '-', lunch: '-', dinner: '-',);
  String name = "마커를 클릭해주세요";

  Menu get para_menu => menu;
  String get para_name => name;

  void updateText(Menu temp_menu, String temp_name) {
    name = temp_name;
    menu = temp_menu;
    notifyListeners();
  }
}

class LNGModel extends ChangeNotifier {
  LatLng lng =  LatLng(36.371144, 127.361941);
  double zoom = 15;

  late GoogleMapController mapController;


  LatLng get para_lng => lng;
  double get para_zoom => zoom;

  void move_camera (){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: lng,zoom: zoom)
    ));
  }
  void update (GoogleMapController controller){
    mapController = controller;
  }

  void updatedata(LatLng temp_lng, double temp_zoom) {
    lng = temp_lng;
    zoom = temp_zoom;
    move_camera ();
    notifyListeners();
  }
}
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<MenuModel>(create: (_) => MenuModel()),
      ChangeNotifierProvider<LNGModel>(create: (_) => LNGModel()),
    ],
    child: GoogleMapsClonePage(),
    )
);

class GoogleMapsClonePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            CustomGoogleMap(),
            CustomHeader(),
            DraggableScrollableSheet(
              initialChildSize: 0.03,
              minChildSize: 0.03,
              maxChildSize: 0.68,
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: CustomScrollViewContent(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Google Map in the background
class CustomGoogleMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Center(child: MyApp())
    );
  }
}

/// Search text field plus the horizontally scrolling categories below the text field
class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomSearchContainer(),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5,0,0),
          child: CustomSearchCategories(),
        ),
      ],
    );
  }
}

class CustomSearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 8), //adjust "40" according to the status bar size
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: <Widget>[
            CustomTextField(),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: "Search here",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomSearchCategories extends StatelessWidget {

  MyApp myapp = MyApp();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(width: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
              ),
              backgroundColor: Colors.white,
              elevation: 0, // 그림자 크기 지정
              padding: EdgeInsets.all(0.0),),
              onPressed: (){
                //myapp.move_camera(LatLng(36.371144, 127.361941),15);
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(36.371144, 127.361941),15);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 105,
                child: CustomCategoryChip(AssetImage('assets/kaist.png'), "카이스트"),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
                ),
                backgroundColor: Colors.white,
                elevation: 0, // 그림자 크기 지정
                padding: EdgeInsets.all(0.0),),
              onPressed: (){
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(37.557260, 127.047070),16);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 115,
                child: CustomCategoryChip(AssetImage('assets/hyu.png'), "한양대학교"),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
                ),
                backgroundColor: Colors.white,
                elevation: 0, // 그림자 크기 지정
                padding: EdgeInsets.all(0.0),),
              onPressed: (){
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(37.586281, 127.029365),15.2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 115,
                child: CustomCategoryChip(AssetImage('assets/go.png'), "고려대학교"),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
                ),
                backgroundColor: Colors.white,
                elevation: 0, // 그림자 크기 지정
                padding: EdgeInsets.all(0.0),),
              onPressed: (){
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(36.019423, 129.320201),15);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 105,
                child: CustomCategoryChip(AssetImage('assets/po.png'), "포항공대"),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
                ),
                backgroundColor: Colors.white,
                elevation: 0, // 그림자 크기 지정
                padding: EdgeInsets.all(0.0),),
              onPressed: (){
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(37.588455, 126.992976),16);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 125,
                child: CustomCategoryChip(AssetImage('assets/sung.png'), "성균관_서울"),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 모서리 반경 설정
                ),
                backgroundColor: Colors.white,
                elevation: 0, // 그림자 크기 지정
                padding: EdgeInsets.all(0.0),),
              onPressed: (){
                Provider.of<LNGModel>(context,listen: false).updatedata(LatLng(37.294283, 126.974430),16);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[50],borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 125,
                child: CustomCategoryChip(AssetImage('assets/sung.png'), "성균관_수원"),
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
      );
  }
}

class CustomCategoryChip extends StatelessWidget {
  final AssetImage image;
  final String title;

  CustomCategoryChip(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          SizedBox(width: 5,),
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.fromLTRB(0,0,5,0),
              alignment: Alignment.center,
              child: Text(title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      );
  }
}

/// Content of the DraggableBottomSheet's child SingleChildScrollView

class CustomScrollViewContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 12.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )
          ),
          margin: const EdgeInsets.all(0),
          child: CustomInnerContent(my_menu: Provider.of<MenuModel>(context).menu,res_name:Provider.of<MenuModel>(context).name),
        ),
      ],
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  Menu my_menu;
  String res_name;
  CustomInnerContent({required this.my_menu , required this.res_name});

  @override
  Widget build(BuildContext context) {

    String new_bre;
    String new_lun;
    String new_din;

    if (my_menu.breakfast == "[]"){
      new_bre = "-";
    }else{
      new_bre = my_menu.breakfast;
    }
    if (my_menu.lunch == "[]"){
      new_lun = "-";
    }else{
      new_lun = my_menu.lunch;
    }
    if (my_menu.dinner == "[]"){
      new_din = "-";
    }else{
      new_din = my_menu.dinner;
    }


    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 16),
        CustomExploreBerlin(res_name : res_name),
        SizedBox(height: 16),
        CustomHorizontallyScrollingRestaurants(when: "아침", detailed_menu:new_bre),
        SizedBox(height: 16),
        CustomHorizontallyScrollingRestaurants(when: "점심", detailed_menu: new_lun),
        SizedBox(height: 16),
        CustomHorizontallyScrollingRestaurants(when: "저녁", detailed_menu: new_din),
        SizedBox(height: 35),
      ],
    );
  }
}

class detail_menu extends StatelessWidget{

  String detailed_menu;
  String when;
  detail_menu({required this.detailed_menu , required this.when});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24),
            )
        ),
        color: Color(0xFFF2EFFB),
        elevation: 4,
        margin: const EdgeInsets.all(0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            Center(
              child: Text(when),
            ),
            SizedBox(width: 20,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: 1,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0,4,0,7),
                      width: double.infinity,
                      child: Text(detailed_menu,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          height: 1.4,
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    )
                    ,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class CustomExploreBerlin extends StatelessWidget {
  String res_name;
  CustomExploreBerlin({ required this.res_name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(res_name, style: TextStyle(fontSize: 22, color: Colors.black45)),
      ],
    );
  }
}

class CustomHorizontallyScrollingRestaurants extends StatelessWidget {

  String detailed_menu;
  String when;
  CustomHorizontallyScrollingRestaurants({required this.detailed_menu , required this.when});

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    if (detailed_menu != "-"){
      List<dynamic> menu_list = json.decode(detailed_menu);
      return
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child:
          Container(
            width: double.infinity,
            height: 150,
            child: PageView.builder(
            controller: _pageController,
            itemCount: menu_list.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Padding(padding: EdgeInsets.fromLTRB(0, 0, 16,0 ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0, // 그림자 크기 지정
                        padding: EdgeInsets.all(0.0),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                          builder: ((context) {
                            return AlertDialog(
                              title: Text(when),
                              content: Text(translate(menu_list[index]["menuName"].replaceAll("/n", "\n").replaceAll(" / ", "\n").replaceAll(",", "\n").replaceAll(" ", "\n")),
                                style: TextStyle(
                                  wordSpacing: 2.0,
                                  height: 1.4,
                                  color: Colors.grey[600],
                                ),
                              ),
                              actions: <Widget>[
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); //창 닫기
                                    },
                                    child: Text("닫기"),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: detail_menu(when: when, detailed_menu:translate(menu_list[index]["menuName"].replaceAll("/n", "\n").replaceAll(" / ", "\n").replaceAll(",", "\n").replaceAll(" ", "\n"))),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }
    else{
      return
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child:
          Container(
            width: double.infinity,
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 1,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Padding(padding: EdgeInsets.fromLTRB(0, 0, 16,0 ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0, // 그림자 크기 지정
                          padding: EdgeInsets.all(0.0),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                            builder: ((context) {
                              return AlertDialog(
                                title: Text(when),
                                content: Text(""),
                                actions: <Widget>[
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); //창 닫기
                                      },
                                      child: Text("닫기"),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: detail_menu(when: when, detailed_menu:"메뉴없음"),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
    }
  }
  String translate(String origin){
    int len = origin.length;
    if (origin[len-1] == "n" && origin[len-2] == "/" ){
      return origin.substring(0,len-2);
    }else{
      return origin;
    }
  }
}
Future<Menu?> get(String uni_name, String res_name) async {
  UniversityList? uni_list =  await getUniversityList();
  for (var count = 0 ; count < uni_list!.universityList.length ; count++) {
    if (uni_name == uni_list!.universityList[count].universityName){
      RestaurantList? res_list = await  getRestaurantList(uni_list!.universityList[count].universityId);
      for (var i = 0 ; i < res_list!.restaurantList.length ; i++) {
        if (res_name == res_list!.restaurantList[i].restaurantName){
          Menu? menu = await getMenu(res_list!.restaurantList[i].restaurantId);
          return menu;
        }
      }
    }
  }
  return null;
}