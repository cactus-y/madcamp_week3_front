import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:madcamp_week3/api/data/Menu.dart';

const String base_url = "http://172.10.5.165:443";
Future<Menu?> getMenu(String restaurantId) async {
  var url = Uri.parse('${base_url}/menu');
  var queryParams = { 'restaurantId': restaurantId };
  url = url.replace(queryParameters: queryParams);

  var response = await http.get(url);

  if(response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    bool success = responseBody['success'];
    if(success) {
      Map<String, dynamic> menuData = responseBody['menuList'];
      Menu menu = Menu.fromJson(menuData);

      return menu;
    } else {
      return null;
    }
  } else {
    return null;
  }
}