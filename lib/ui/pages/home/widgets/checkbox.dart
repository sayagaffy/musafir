import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 2,
      "value": false,
      "title": "Di bawah  Rp30.000",
    },
    {
      "id": 3,
      "value": false,
      "title": "Rp30.000 sampai Rp100.000",
    },
    {
      "id": 4,
      "value": false,
      "title": "Rp100.000 sampai Rp250.000",
    },
    {
      "id": 5,
      "value": false,
      "title": "Diatas Rp250.000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rentang Harga',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              height: 0.7,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Column(
            children: List.generate(
              checkListItems.length,
              (index) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -4),
                dense: true,
                title: Text(
                  checkListItems[index]["title"],
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                value: checkListItems[index]["value"],
                onChanged: (value) {
                  setState(() {
                    checkListItems[index]["value"] = value;
                    if (multipleSelected.contains(checkListItems[index])) {
                      multipleSelected.remove(checkListItems[index]);
                    } else {
                      multipleSelected.add(checkListItems[index]);
                    }
                  });
                },
              ),
            ),
          ),
          Text(
            multipleSelected.isEmpty ? "" : multipleSelected.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
