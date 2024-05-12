import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/data_models/city_id.dart';
import 'package:jakosc_powietrza/models/choosen_city.dart';
import 'package:jakosc_powietrza/models/city_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainData extends StatefulWidget {
  const MainData({
    super.key,
  });

  @override
  State<MainData> createState() => _MainDataState();
}

class _MainDataState extends State<MainData> {
  late List<CityID> futureCityID;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
      final response = await http
      .get(Uri.parse('https://api.gios.gov.pl/pjp-api/rest/station/findAll'));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      futureCityID = decodedJson.map<CityID>((item) => CityID.fromJson(item)).toList() ; 
    } else {
      throw Exception('Failed to load album');
    }
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
