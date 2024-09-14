import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/shared/theme.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

class GetLocationText extends StatefulWidget {
  final String origin;
  final String destination;

  const GetLocationText({
    super.key,
    required this.origin,
    required this.destination,
  });

  @override
  State<GetLocationText> createState() => _GetLocationTextState();
}

class _GetLocationTextState extends State<GetLocationText> {
  late AsyncMemoizer _memoizer;

  _fetchData() async {
    return _memoizer.runOnce(() async {
      // This below code will call only ones. This will return the same data directly without performing any Future task.
      await Future.delayed(const Duration(seconds: 5));
      var homeC = Get.find<HomeController>();
      // ignore: prefer_typing_uninitialized_variables
      var des;
      // print(widget.origin);

      await homeC.distance(widget.origin, widget.destination).then((value) {
        des = value;
      });

      return des;
    });
  }

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

  @override
  Widget build(BuildContext context) {
    //get collection

    return FutureBuilder(
      future: _fetchData(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.toString(),
            style: blackTextStyle.copyWith(fontSize: 11),
          );
        }
        return Text(
          'loading..',
          style: blackTextStyle.copyWith(fontSize: 12),
        );
      },
    );
  }
}
