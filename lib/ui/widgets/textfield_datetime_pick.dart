import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class TextfieldDatetimePick extends StatefulWidget {
  final TextEditingController textController;
  final String labelText;

  const TextfieldDatetimePick({
    super.key,
    required this.textController,
    required this.labelText,
  });

  @override
  State<TextfieldDatetimePick> createState() => _TextfieldDatetimePickState();
}

class _TextfieldDatetimePickState extends State<TextfieldDatetimePick> {
  TextEditingController? textController;
  @override
  void initState() {
    super.initState();

    textController = widget.textController;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        style: blackTextStyle.copyWith(
          fontSize: 14,
          letterSpacing: 1.3,
        ),
        textAlignVertical: TextAlignVertical.center,
        controller: widget.textController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: blackTextStyle.copyWith(
            color: kGreyColor,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Color(0xFFFE6E8EA),
          prefixIcon: Icon(
            Icons.calendar_month_rounded,
            color: kBlueColor,
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
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 5,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      // constraints: const BoxConstraints(
      //   maxWidth: 350,
      //   maxHeight: 650,
      // ),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.yellow,
        brightness: Brightness.dark,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );

    if (_picked != null) {
      String formattedDate = DateFormat('dd-MMMM-yyyy HH:MM').format(_picked);
      setState(() {
        textController!.text = formattedDate;
      });
    }
  }
}
