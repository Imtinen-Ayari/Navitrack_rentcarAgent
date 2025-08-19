class Emplacement {
  String latitude,longitude ;

  Emplacement({
    required this.latitude,
    required this.longitude
  });

  factory Emplacement.fromJson(Map<String, dynamic> json) {
    return Emplacement(
        latitude: json['latitude'],
        longitude: json['longitude']
    );
  }
}