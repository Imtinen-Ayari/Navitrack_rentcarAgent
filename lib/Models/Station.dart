class Station {
  final String  lng,lat;

  const Station({
    required this.lng,
    required this.lat,
  });

  factory Station.fromJson(dynamic json) {
   try{ return Station(
      
      lng: json['lng']?? "",
      lat: json['lat']?? "",
    );}   catch(e){   print('Error parsing JSON station : $e, JSON data: $json');
      throw e; }
  }

  static List<Station> parseData(List<dynamic> data) {
    List<Station> objectList = [];
    for (var element in data) {
      objectList.add(Station.fromJson(element));
    }
    return objectList;
  }
}
