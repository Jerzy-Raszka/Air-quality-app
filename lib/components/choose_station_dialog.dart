import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';
import 'package:jakosc_powietrza/components/city_dropdown_menu.dart';

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

  void _updateCitiesList(String cityId, int index) {
    setState(() {
      _citiesList[index] = cityId;
    });
  }

  @override
  void initState() {
    super.initState();
    //TODO these values will come from the passed value loaded from memory in the main_data (if there will be such feature)
    var firstItem = widget.futureCityID.first.id.toString();
    _citiesList = [firstItem, firstItem, firstItem];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._citiesList.asMap().entries.map(
              (entry) => CityDropdownMenu(
                  futureCityID: widget.futureCityID,
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
