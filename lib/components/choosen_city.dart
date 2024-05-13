import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';
import 'package:http/http.dart' as http;

class ChoosenCity extends StatefulWidget {
  const ChoosenCity(
      {required this.cityId, required this.futureCityID, super.key});
  final String cityId;
  final List<CityID> futureCityID;

  @override
  State<ChoosenCity> createState() => _ChoosenCityState();
}

class _ChoosenCityState extends State<ChoosenCity> {
  final apiUrl = "https://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/";
  int airIndex = -1;
  final Map<int, Color> airIndexMap = {
    -1: Colors.black,
    0: Colors.green,
    1: Colors.yellow,
    2: Colors.orange,
    3: Colors.deepOrange,
    4: Colors.red,
    5: Colors.purple
  };

  void _fetchStationData() async {
    final response = await http.get(Uri.parse(apiUrl + widget.cityId));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      setState(() {
        airIndex = decodedJson["stIndexLevel"]?["id"] ?? -1;
      });
    }
  }

  @override
  void didUpdateWidget(covariant ChoosenCity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fetchStationData();
  }

  @override
  void initState() {
    super.initState();
    _fetchStationData();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            widget.futureCityID
                    .firstWhereOrNull(
                        (element) => element.id.toString() == widget.cityId)
                    ?.stationName ??
                'Nie znaleziono miejscowości',
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          //TODO bug with overextending space on right even though there's still place on right
          padding: const EdgeInsets.only(right: 45.0),
          child: Container(
            width: 50,
            height: 18,
            color: airIndexMap[airIndex],
          ),
        ),
      ],
    );
  }
}