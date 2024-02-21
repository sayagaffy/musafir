import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class DropdownFilter extends StatefulWidget {
  final String selected;
  final List<DropdownMenuItem<String>> items;
  final Function(String) valueReturned;

  const DropdownFilter({
    super.key,
    required this.selected,
    required this.items,
    required this.valueReturned,
  });

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String? sel;
  @override
  void initState() {
    super.initState();
    sel = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: kNeutral40,
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
