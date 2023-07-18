import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:madcamp_week3/api/data/University.dart';


Future<University?> getUniversity(String universityName) async {
  var url = Uri.parse('${base_url}/university');
  var queryParams = { 'universityName': universityName };
  url = url.replace(queryParameters: queryParams);

  var response = await http.get(url);

  if(response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    bool success = responseBody['success'];
    if(success) {
      Map<String, dynamic> universityData = responseBody['university'];
      University university = University.fromJson(universityData);

      return university;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<UniversityList?> getUniversityList() async {
  var url = Uri.parse('${base_url}/university/list');
  var response = await http.get(url);

  if(response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    bool success = responseBody['success'];
    if(success) {
      return UniversityList.fromJson(responseBody);
    } else {
      return null;
    }
  } else {
    return null;
  }
}

