class Menu {
  final String menuId;
  final String restaurantId;
  final String date;
  final String breakfast;
  final String lunch;
  final String dinner;

  Menu({
    required this.menuId,
    required this.restaurantId,
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['_id'],
      restaurantId: json['restaurantId'],
      date: json['date'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner']
    );
  }
}