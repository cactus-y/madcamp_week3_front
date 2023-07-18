import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:madcamp_week3/api/data/Restaurant.dart';


Future<Restaurant?> getRestaurant(String restaurantId) async {
  var url = Uri.parse('${base_url}/restaurant');
  var queryParams = { 'restaurantId': restaurantId };
  url = url.replace(queryParameters: queryParams);

  var response = await http.get(url);

  if(response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    bool success = responseBody['success'];
    if(success) {
      Map<String, dynamic> restaurantData = responseBody['restaurant'];
      Restaurant restaurant = Restaurant.fromJson(restaurantData);

      return restaurant;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<RestaurantList?> getRestaurantList(String universityId) async {
  var url = Uri.parse('${base_url}/restaurant/list');
  var queryParams = { 'universityId': universityId };
  url = url.replace(queryParameters: queryParams);

  var response = await http.get(url);

  if(response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    bool success = responseBody['success'];
    if(success) {
      return RestaurantList.fromJson(responseBody);
    } else {
      return null;
    }
  } else {
    return null;
  }
}