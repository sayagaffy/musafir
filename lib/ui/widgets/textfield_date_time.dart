import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:intl/intl.dart'; //Impo

class TextfieldDateTime extends StatefulWidget {
  const TextfieldDateTime({super.key});

  @override
  State<TextfieldDateTime> createState() => _TextfieldDateTimeState();
}

class _TextfieldDateTimeState extends State<TextfieldDateTime> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 250,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Berangkat',
                contentPadding: EdgeInsets.all(10.0),
                labelStyle: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 14,
                ),
                filled: true,
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
          SizedBox(
            height: 50,
            width: 100,
            child: TextField(
              controller: _timeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: 'Jam',
                labelStyle: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 14,
                ),
                filled: true,
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
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
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

  TimeOfDay _timeOfDay = TimeOfDay.now();
  Future<void> _selectTime() async {
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: _timeOfDay);

    if (_picked != null) {
      print(_picked.toString());
      setState(() {
        _timeController.text =
            '${_picked.hour.toString().padLeft(2, '0')}:${_picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }
}
