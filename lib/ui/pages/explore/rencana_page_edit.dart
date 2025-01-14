// import 'package:intl/intl.dart';
// ignore_for_file: avoid_print

/// Halaman ini menampilkan daftar item yang dapat dipilih oleh pengguna.
///
/// Pengguna dapat memilih satu atau beberapa item dari daftar.
/// Setiap item dalam daftar memiliki nama dan deskripsi.
///
/// Fitur utama:
/// - Menampilkan daftar item
/// - Memungkinkan pengguna untuk memilih item
/// - Menampilkan detail item yang dipilih
///
/// Cara penggunaan:
/// 1. Buka halaman ini untuk melihat daftar item.
/// 2. Pilih item yang diinginkan dengan mengkliknya.
/// 3. Detail item yang dipilih akan ditampilkan di bagian bawah halaman.
///
/// Catatan:
/// - Pastikan untuk memeriksa koneksi internet sebelum menggunakan halaman ini.
/// - Jika terjadi kesalahan, coba muat ulang halaman.
library;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';

import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';

import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

import 'package:musafir/ui/widgets/textfield_datetime_pick.dart';
import 'package:musafir/ui/widgets/text_fd_custom.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class RencanaPageEdit extends StatefulWidget {
  const RencanaPageEdit({super.key});

  @override
  State<RencanaPageEdit> createState() => _RencanaPageEditState();
}

class _RencanaPageEditState extends State<RencanaPageEdit> {
  // ignore: unused_field

  var exploreController = Get.find<ExploreController>();

  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime = TextEditingController();
  TextEditingController startFormat = TextEditingController();
  TextEditingController endFormat = TextEditingController();

  void addPlace(String type) async {
    String nameplan = exploreController.namePlan.text.trim();
    String search = exploreController.searchPlace.text.trim();
    String start = exploreController.startDtTime.text.trim();
    String end = exploreController.endDtTime.text.trim();

    if (nameplan.isEmpty) {
      DialogHelper.showSnackBar('Nama Rencana Perjalanan tidak boleh kosong',
          title: 'Nama');
    } else if (search.isEmpty) {
      DialogHelper.showSnackBar(
          'Tempat Atau Tujuan Rencana Perjalanan tidak boleh kosong',
          title: 'Tujuan/Tempat');
    } else if (start.isEmpty) {
      DialogHelper.showSnackBar('Tanggal Berangkat tidak boleh kosong',
          title: 'Tanggal Berangkat');
    } else if (end.isEmpty) {
      DialogHelper.showSnackBar('Tanggal Kembali tidak boleh kosong',
          title: 'Tanggal Kembali');
    } else {
      if (type == 'resto') {
        await exploreController.getNearbyPlace(
          keyword: 'resto+food',
          rankby: 'distance',
          type: type,
          location:
              '${exploreController.latlng!.latitude.toString()}, ${exploreController.latlng!.longitude.toString()}',
        );

        Get.offNamed(RouteHelper.getSearchPlaceExplore('edit'));
      } else {
        await exploreController.getNearbyPlace(
          keyword: 'mosque',
          rankby: 'distance',
          type: type,
          location:
              '${exploreController.latlng!.latitude.toString()}, ${exploreController.latlng!.longitude.toString()}',
        );

        Get.offNamed(RouteHelper.getSearchPlaceExplore2('edit'));
      }
    }
  }

  void clearAll() {
    Get.offNamed(RouteHelper.getInitial());

    Future.delayed(const Duration(milliseconds: 2000), () {
      exploreController.searchPlace.clear();
      exploreController.placeIdX.value = '';
      exploreController.startDtTime.clear();
      exploreController.endDtTime.clear();
      exploreController.namePlan.clear();
      exploreController.selectedFood.clear();
      exploreController.selectedMosque.clear();
      exploreController.setLatLng();
      exploreController.idDocument = '';
    });
  }

  Future<void> deletePlan() async {
    await UserStore().exploreDelete(
      exploreController.idDocument,
    );

    clearAll();
  }

  Future<void> updatePlan() async {
    // DialogHelper.showLoading('Posting Rencana Perjalanan');
    String tujuan = exploreController.searchPlace.text.trim();
    String nameplan = exploreController.namePlan.text.trim();
    String startdtTime = exploreController.startDtTime.text.trim();
    String enddtTime = exploreController.endDtTime.text.trim();

    if (tujuan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tujuanmu",
          title: "Tujuanmu");
    } else if (nameplan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum mengisi nama perjalananmu ",
          title: "Nama perjalanan");
    } else if (startdtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Berangkat",
          title: "Tanggal Berangkat");
    } else if (enddtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Kembali",
          title: "Tanggal Kembali");
    } else {
      await UserStore().explorePlanUpdates(
        exploreController.idDocument,
        exploreController.placeIdX.value,
        exploreController.searchPlace.text,
        exploreController.startDtTime.text,
        exploreController.endDtTime.text,
        exploreController.namePlan.text,
        exploreController.selectedFood,
        exploreController.selectedMosque,
        exploreController.latlng!.latitude,
        exploreController.latlng!.longitude,
      );

      clearAll();
    }
  }

  Widget header(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 21,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 18,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              clearAll();
            },
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Update Rencana Perjalanan',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: extraBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentPlan(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 34,
      ),
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFdCustom(
            textController: exploreController.searchPlace,
            labelText: 'Ketik Tujuanmu',
            icon: Icons.search_rounded,
            onTap: () {
              Get.offNamed(RouteHelper.getExploreSearch());
            },
            readOnly: true,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFdCustom(
            textController: exploreController.namePlan,
            labelText: 'Nama Rencana Perjalanan',
            icon: Icons.store,
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          TextfieldDatetimePick(
            textController: exploreController.startDtTime,
            labelText: 'Tanggal Berangkat',
            textdatetime: startFormat,
          ),
          const SizedBox(
            height: 20,
          ),
          TextfieldDatetimePick(
            textController: exploreController.endDtTime,
            labelText: 'Tanggal Kembali',
            textdatetime: endFormat,
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Restoran Tujuan ${exploreController.selectedFood.length}',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addPlace('resto');
                      },
                      child: Text(
                        'Tambahkan lainnya',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: kBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              exploreController.selectedFood.isNotEmpty
                  ? SizedBox(
                      height:
                          exploreController.selectedFood.length == 1 ? 80 : 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: exploreController.selectedFood.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: contactItem(
                                    exploreController.selectedFood[index]
                                        ['title'],
                                    exploreController.selectedFood[index]
                                        ['address'],
                                    exploreController.selectedFood[index]
                                        ['halalStatus'],
                                    exploreController.selectedFood[index]
                                        ['jarak'],
                                    exploreController.selectedFood[index]
                                        ['photos'],
                                    exploreController.selectedFood[index]
                                        ['place_id'],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        addPlace('resto');
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kNeutral40,
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Masjid / Ruang Sholat ${exploreController.selectedMosque.length}',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addPlace('mosque');
                      },
                      child: Text(
                        'Tambahkan lainnya',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: kBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              exploreController.selectedMosque.isNotEmpty
                  ? SizedBox(
                      height: exploreController.selectedMosque.length == 1
                          ? 80
                          : 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  exploreController.selectedMosque.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: contactItem2(
                                    exploreController.selectedMosque[index]
                                        ['title'],
                                    exploreController.selectedMosque[index]
                                        ['address'],
                                    exploreController.selectedMosque[index]
                                        ['jarak'],
                                    exploreController.selectedMosque[index]
                                        ['photos'],
                                    exploreController.selectedMosque[index]
                                        ['place_id'],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        addPlace('mosque');
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kNeutral40,
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 130,
                child: TextButton(
                  onPressed: () {
                    updatePlan();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Perbaharui Plan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Hapus",
                      middleText: "Apakah kamu ingin menghapus plan ini ?",
                      onConfirm: () async {
                        deletePlan();
                      },
                      textConfirm: "Hapus",
                      textCancel: "Cancel",
                      radius: 4,
                      contentPadding: const EdgeInsets.only(bottom: 20),
                      buttonColor: kBlueColor,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kWarningMain,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Hapus ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget contactItem(String title, String address, String halalStatus,
      String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    right: 3,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(halalStatus == '1'
                          ? 'assets/icon_halal.png'
                          : halalStatus == '2'
                              ? 'assets/icon_halal_blue.png'
                              : 'assets/icon_halal_black.png'),
                    ),
                  ),
                ),
                Text(
                  halalStatus == '1'
                      ? 'Halal Certified'
                      : halalStatus == '2'
                          ? 'Halal Friendly'
                          : 'Halal',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: halalStatus == '1'
                        ? kGreenHover
                        : halalStatus == '2'
                            ? kBlueColorHover
                            : kBlackColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget contactItem2(String title, String address, String destination,
      String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          contentPlan(context),
        ],
      ),
    );
  }
}
