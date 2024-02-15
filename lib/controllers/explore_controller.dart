import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musafir/data/repository/explore_repo.dart';

class ExploreController extends GetxController implements GetxService {
  final ExploreRepo exploreRepo;

  RxString placeIdX = ''.obs;

  Rx<List<PlanModel>> plans = Rx<List<PlanModel>>([]);
  TextEditingController placeTextEditingController = TextEditingController();
  TextEditingController dateTimeTextEditingControlle = TextEditingController();
  late PlanModel planModel;
  var itemPlans = 0.obs;

  ExploreController({
    required this.exploreRepo,
  });

  void setTujuan(String description, String placeId) {
    placeIdX.value = placeId;
    placeTextEditingController.text = description;

    update();
  }

  @override
  void onClose() {
    super.onClose();
    placeTextEditingController.dispose();
    dateTimeTextEditingControlle.dispose();
  }

  addPostingPlan(String place, String dateTime) {
    planModel = PlanModel(
      place: place,
      tanggalJam: dateTime,
      placeId: placeIdX.value,
      timeCreate: DateTime.now().toString(),
    );

    plans.value.add(planModel);
    itemPlans.value = plans.value.length;

    placeTextEditingController.clear();
    dateTimeTextEditingControlle.clear();
    placeIdX.value = '';

    print(plans.value.length);
    update();
  }
}

class PlanModel {
  // int? id;
  String? place;
  String? placeId;
  String? tanggalJam;
  String? timeCreate;

  PlanModel({
    // this.id,
    this.place,
    this.placeId,
    this.tanggalJam,
    this.timeCreate,
  });

  PlanModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    place = json['place'];
    placeId = json['placeId'];
    tanggalJam = json['tanggalJam'];
    timeCreate = json['timeCreate'];
  }
}
