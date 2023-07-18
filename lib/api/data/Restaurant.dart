class Restaurant {
  final String restaurantId;
  final String universityId;
  final String restaurantName;
  final String latitude;
  final String longitude;

  Restaurant({
    required this.restaurantId,
    required this.universityId,
    required this.restaurantName,
    required this.latitude,
    required this.longitude
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantId: json['_id'],
      universityId: json['universityId'],
      restaurantName: json['restaurantName'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class RestaurantList {
  final bool success;
  final List<Restaurant> restaurantList;

  RestaurantList({ required this.success, required this.restaurantList });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    List<Restaurant> restaurantList = (json['restaurantList'] as List)
        .map((item) => Restaurant.fromJson(item))
        .toList();

    return RestaurantList(success: json['success'], restaurantList: restaurantList);
  }
}