import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';
import 'package:jakosc_powietrza/components/city_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseStationDialog extends StatefulWidget {
  const ChooseStationDialog(
      {super.key, required this.futureCityID, required this.onDialogSaved});
  final List<CityID> futureCityID;
  final Function(List<String>) onDialogSaved;

  @override
  State<ChooseStationDialog> createState() => _ChooseStationDialogState();
}

class _ChooseStationDialogState extends State<ChooseStationDialog> {
  late List<String> _citiesList;

  @override
  void initState() {
    super.initState();
    _getStringValuesSF();
  }

  void _getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstCity = prefs.getString('0') ?? '114';
    String secondCity = prefs.getString('1') ?? '114';
    String thirdCity = prefs.getString('2') ?? '114';
    List<String> citiesList = [firstCity, secondCity, thirdCity];
    if (!mounted) return;
    setState(() {
      _citiesList = citiesList;
    });
  }

  void _updateCitiesList(String cityId, int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('$index', cityId);
    setState(() {
      _citiesList[index] = cityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._citiesList.asMap().entries.map(
              (entry) => CityDropdownMenu(
                  futureCityID: widget.futureCityID,
                  initialId: entry.value,
                  onCountrySelected: (String cityId) {
                    _updateCitiesList(cityId, entry.key);
                  }),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                widget.onDialogSaved(_citiesList);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        )
      ],
    );
  }
}
