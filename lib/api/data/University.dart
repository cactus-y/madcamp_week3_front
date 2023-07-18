class University {
  final String universityId;
  final String universityName;
  final String latitude;
  final String longitude;

  University({ required this.universityId, required this.universityName, required this.latitude, required this.longitude});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityId: json['_id'],
      universityName: json['universityName'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class UniversityList {
  final bool success;
  final List<University> universityList;

  UniversityList({required this.success, required this.universityList});

  factory UniversityList.fromJson(Map<String, dynamic> json) {
    List<University> universityList = (json['universityList'] as List)
        .map((item) => University.fromJson(item))
        .toList();

    return UniversityList(success: json['success'], universityList: universityList);
  }
}