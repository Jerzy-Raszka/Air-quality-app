class CityID {
  final int id;
  final String stationName;
  final double gegrLat;
  final double gegrLon;

  const CityID({
    required this.id,
    required this.stationName,
    required this.gegrLat,
    required this.gegrLon,
  });

  factory CityID.fromJson(Map<String, dynamic> json) => CityID(
        id: json["id"],
        stationName: json["stationName"],
        gegrLat: double.parse(json["gegrLat"]),
        gegrLon: double.parse(json["gegrLon"]),
    );
}
