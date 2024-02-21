import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/shared/theme.dart';

class DropdownLocation extends StatefulWidget {
  final String selected;
  final List<DropdownMenuItem<String>> items;
  final Function(String) valueReturned;

  const DropdownLocation({
    super.key,
    required this.selected,
    required this.items,
    required this.valueReturned,
  });

  @override
  State<DropdownLocation> createState() => _DropdownLocationState();
}

class _DropdownLocationState extends State<DropdownLocation> {
  String? sel;
  List categoryItemlist = [];
  var googleController = Get.find<GoogleController>();

  @override
  void initState() {
    super.initState();
    sel = widget.selected;

    if (googleController.geoCode.isEmpty) {
      return;
    } else {
      var jsonData = googleController.geoCode;

      setState(() {
        categoryItemlist = jsonData;

        // print(response.body['results'][0]['formatted_address']);
        print(categoryItemlist[0].formattedAddress);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: kPrimarySurface,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 30,
      child: DropdownButton<String>(
        itemHeight: 48,
        value: sel,
        icon: Icon(
          Icons.expand_more,
          color: kBlackColor,
          size: 17,
        ),
        style: blackTextStyle.copyWith(
          fontSize: 12,
          color: kBlackColor,
          fontWeight: bold,
        ),
        items: widget.items,
        onChanged: (String? newValue) {
          setState(() {
            sel = newValue;
            widget.valueReturned(newValue!);
          });
        },
        underline: const SizedBox(),
        dropdownColor: kWhiteColor,
      ),
    );
  }
}
