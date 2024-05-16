import 'package:flutter/material.dart';

class LegendButton extends StatelessWidget {
  const LegendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 113, 201, 206),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: const Color.fromARGB(255, 166, 227, 233),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 16,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Center(
                      child: Text(
                    'Kategoria powietrza',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 20),
                  _buildLegend(
                      const Color.fromARGB(255, 0, 0, 0), 'Brak dannych'),
                  _buildLegend(
                      const Color.fromARGB(255, 76, 175, 80), 'Bardzo dobra'),
                  _buildLegend(
                      const Color.fromARGB(255, 255, 235, 59), 'Dobra'),
                  _buildLegend(
                      const Color.fromARGB(255, 255, 152, 0), 'Umiarkowana'),
                  _buildLegend(
                      const Color.fromARGB(255, 255, 87, 34), 'Dostateczna'),
                  _buildLegend(const Color.fromARGB(255, 244, 67, 54), 'Zła'),
                  _buildLegend(
                      const Color.fromARGB(255, 156, 38, 176), 'Bardzo zła'),
                ],
              ),
            );
          },
        );
      },
      child: const Text(
        'Legenda',
        style: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Widget _buildLegend(Color colorData, String description) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const SizedBox(width: 12),
            Text(description),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: colorData, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(15),
            ),
          ],
        ),
      ],
    ),
  );
}
