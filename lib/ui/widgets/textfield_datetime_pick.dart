import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/shared/theme.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TextfieldDatetimePick extends StatefulWidget {
  final TextEditingController textController;
  final TextEditingController textdatetime;
  final String labelText;

  const TextfieldDatetimePick({
    super.key,
    required this.textController,
    required this.textdatetime,
    required this.labelText,
  });

  @override
  State<TextfieldDatetimePick> createState() => _TextfieldDatetimePickState();
}

class _TextfieldDatetimePickState extends State<TextfieldDatetimePick> {
  TextEditingController? textController;
  TextEditingController? stringText;
  TextEditingController? startDt;
  @override
  void initState() {
    super.initState();

    textController = widget.textController;
    stringText = widget.textdatetime;
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
          // ignore: use_full_hex_values_for_flutter_colors
          fillColor: const Color(0xFFFE6E8EA),
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
    var exploreC = Get.find<ExploreController>();
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _picked = await showOmniDateTimePicker(
      context: context,
      initialDate: exploreC.startDtTime.text.isNotEmpty
          ? DateFormat("dd/MM/yyyy").parse(exploreC.startDtTime.text)
          : DateTime.now(),
      firstDate: exploreC.startDtTime.text.isNotEmpty
          ? DateFormat("dd/MM/yyyy").parse(exploreC.startDtTime.text)
          : DateTime.now(),
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
      String formattedDate = DateFormat('dd/MM/yyyy HH:MM').format(_picked);
      setState(() {
        textController!.text = formattedDate;
        stringText!.text = _picked.toString();
      });
    }
  }
}

extension DateFormatTryParse on DateFormat {
  DateTime? tryParse(String inputString, [bool utc = false]) {
    try {
      return parse(inputString, utc);
    } on FormatException {
      return null;
    }
  }
}
