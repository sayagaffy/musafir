import 'package:flex_list/flex_list.dart';
import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

import 'package:musafir/ui/widgets/dry_width.dart'; //Impo
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TextfieldDateTime extends StatefulWidget {
  const TextfieldDateTime({super.key});

  @override
  State<TextfieldDateTime> createState() => _TextfieldDateTimeState();
}

class _TextfieldDateTimeState extends State<TextfieldDateTime> {
  // ignore: prefer_final_fields
  TextEditingController _dateController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FlexList(
      horizontalSpacing: 10,
      verticalSpacing: 10,
      children: [
        Container(
          color: Colors.black,
          height: 50,
          width: 200,
          child: DryIntrinsicWidth(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Berangkat',
                contentPadding: const EdgeInsets.all(10.0),
                labelStyle: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 14,
                ),
                filled: true,
                // ignore: prefer_const_constructors, use_full_hex_values_for_flutter_colors
                fillColor: Color(0xFFFE6E8EA),
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFFFFFFF),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: DryIntrinsicHeight(
            child: TextField(
              controller: _timeController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelText: 'Jam',
                labelStyle: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 14,
                ),
                filled: true,
                // ignore: prefer_const_constructors, use_full_hex_values_for_flutter_colors
                fillColor: Color(0xFFFE6E8EA),
                prefixIcon: const Icon(
                  Icons.punch_clock,
                  color: Color(0xFFFFFFFF),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              readOnly: true,
              onTap: () {
                _selectTime();
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (_picked != null) {
      String formattedDate = DateFormat('dd - MMMM / yyyy').format(_picked);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  // ignore: prefer_final_fields
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Future<void> _selectTime() async {
    // ignore: no_leading_underscores_for_local_identifiers
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: _timeOfDay);

    if (_picked != null) {
      // print(_picked.toString());
      setState(() {
        _timeController.text =
            '${_picked.hour.toString().padLeft(2, '0')}:${_picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }
}
