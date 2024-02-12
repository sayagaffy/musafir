import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:intl/intl.dart'; //Impo

class TextfieldSearch extends StatefulWidget {
  const TextfieldSearch({super.key});

  @override
  State<TextfieldSearch> createState() => _TextfieldSearchState();
}

class _TextfieldSearchState extends State<TextfieldSearch> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Ketik tujuanmu',
          contentPadding: EdgeInsets.all(10.0),
          labelStyle: blackTextStyle.copyWith(
            color: kBlackColor,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Color(0xFFFE6E8EA),
          prefixIcon: const Icon(
            Icons.search_rounded,
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
        onTap: () {},
      ),
    );
  }
}
