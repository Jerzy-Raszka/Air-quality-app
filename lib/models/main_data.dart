import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/data_models/city_id.dart';
import 'package:jakosc_powietrza/models/choose_station_dialog.dart';
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
  List<String> selectedCities = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    //TODO Load selectedCities from memory if wanted
  }

  void _fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.gios.gov.pl/pjp-api/rest/station/findAll'));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      futureCityID =
          decodedJson.map<CityID>((item) => CityID.fromJson(item)).toList();
      futureCityID.sort((a, b) => a.stationName.compareTo(b.stationName));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void _onDialogSaved(List<String> cities) {
    setState(() {
      selectedCities = cities;
    });
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
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              const CityData(
                cityName: 'malaga',
              ),
              ...selectedCities.map((cityId) => CityData(
                    cityName: futureCityID
                        .firstWhere(
                            (element) => element.id.toString() == cityId)
                        .stationName,
                  )),
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
          onPressed: () => showDialog<List<String>>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
                child: ChooseStationDialog(
                    futureCityID: futureCityID, onDialogSaved: _onDialogSaved)),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
