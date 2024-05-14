import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';
import 'package:http/http.dart' as http;
import 'package:jakosc_powietrza/models/sensor.dart';

class CityData extends StatefulWidget {
  const CityData({required this.cityId, required this.futureCityID, super.key});
  final String cityId;
  final List<CityID> futureCityID;

  @override
  State<CityData> createState() => _CityDataState();
}

class _CityDataState extends State<CityData> {
  final String _sensorsApiUrl =
      "https://api.gios.gov.pl/pjp-api/rest/station/sensors/";
  final String _sensorDataApiUrl =
      "https://api.gios.gov.pl/pjp-api/rest/data/getData/";
  List<int> sensorsIds = [];
  List<Sensor> sensorsData = [];

  @override
  void didUpdateWidget(covariant CityData oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fetchSensors();
  }

  @override
  void initState() {
    super.initState();
    _fetchSensors();
  }

  void _fetchSensors() async {
    final response = await http.get(Uri.parse(_sensorsApiUrl + widget.cityId));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      sensorsIds = decodedJson
          .map<int>((item) => int.parse(item["id"].toString()))
          .toList();
      _fetchSensorsData();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void _fetchSensorsData() async {
    List<Sensor> tempSensorsData = [];
    for (var sensorId in sensorsIds) {
      var response =
          await http.get(Uri.parse(_sensorDataApiUrl + sensorId.toString()));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        tempSensorsData.add(
          Sensor(
            name: decodedJson["key"],
            value: decodedJson["values"]
                .where((measurement) => measurement["value"] != null)
                .first["value"],
          ),
        );
      } else {
        throw Exception('Failed to fetch data');
      }
    }

    //to prevent memory leak
    if (mounted) {
      setState(() {
        sensorsData = tempSensorsData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 191, 216, 175),
        ),
        width: 340,
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.futureCityID
                        .firstWhereOrNull(
                            (element) => element.id.toString() == widget.cityId)
                        ?.stationName ??
                    'Nie znaleziono miejscowości',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )),
            ...sensorsData.map((sensorData) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sensorData.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          sensorData.value.toString(),
                          style: const TextStyle(fontSize: 18),
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
