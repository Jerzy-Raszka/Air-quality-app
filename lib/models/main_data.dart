import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/choosen_city.dart';
import 'package:jakosc_powietrza/models/city_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<CityID> fetchCityID() async {
  final response = await http
      .get(Uri.parse('https://api.gios.gov.pl/pjp-api/rest/station/findAll'));
  if (response.statusCode == 200) {
    return CityID.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class MainData extends StatefulWidget {
  const MainData({
    super.key,
  });

  @override
  State<MainData> createState() => _MainDataState();
}

class _MainDataState extends State<MainData> {
  late Future<CityID> futureCityID;

  @override
  void initState() {
    super.initState();
    futureCityID = fetchCityID();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ChoosenCity(
          boxColor: Colors.red,
          cityName: 'malaga',
        ),
        const ChoosenCity(
          boxColor: Colors.green,
          cityName: 'tikitaki',
        ),
        const ChoosenCity(
          boxColor: Colors.blue,
          cityName: 'i',
        ),
        const ChoosenCity(
          boxColor: Colors.yellow,
          cityName: 'kasztanki',
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: const <Widget>[
              SizedBox(
                width: 10,
              ),
              CityData(
                cityName: 'malaga',
              ),
              CityData(cityName: 'tikitaki'),
              CityData(
                cityName: 'i',
              ),
              CityData(
                cityName: 'kasztanki',
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 191, 216, 175),
          ),
          child: const Text(
            'Zmień lokalizacje',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

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

  factory CityID.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'stationName': String stationName,
        'gegrLat': double gegrLat,
        'gegrLon': double gegrLon,
      } =>
        CityID(
            id: id,
            stationName: stationName,
            gegrLat: gegrLat,
            gegrLon: gegrLon),
      _ => throw const FormatException('Failed to load city list'),
    };
  }
}
