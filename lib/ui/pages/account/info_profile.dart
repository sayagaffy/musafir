import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_text.dart';

class InfoProfile extends StatefulWidget {
  const InfoProfile({super.key});

  @override
  State<InfoProfile> createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  String? namaDepan;
  String? namaBelakang;
  String? bio;
  String? phone;
  String? email;

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  void getDataUser() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        namaDepan = value['firstName'];
        namaBelakang = value['lastName'];
        bio = value['bio'];
        phone = value['phone'];
        email = UserStore().auth.currentUser!.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController(text: email);
    var namaDepanController = TextEditingController(text: namaDepan);
    var namaBelakangController = TextEditingController(text: namaBelakang);
    var nomorHpController = TextEditingController(text: phone);
    var bioController = TextEditingController(text: bio);

    Future<void> updateUserDetail() async {
      String namaD = namaDepanController.text.trim();
      String namaB = namaBelakangController.text.trim();
      String phoneU = nomorHpController.text.trim();
      String bioU = bioController.text.trim();
      if (namaD.isEmpty) {
        DialogHelper.showSnackBar(
          'Nama depan tidak boleh kosong',
          title: 'Nama Depan',
          backgroundColor: kWarningMain,
        );
      } else if (namaB.isEmpty) {
        DialogHelper.showSnackBar(
          'Nama belakang tidak boleh kosong',
          title: 'Nama Belakang',
          backgroundColor: kWarningMain,
        );
      } else if (phoneU.isEmpty) {
        DialogHelper.showSnackBar(
          'Nomor Handphone tidak boleh kosong',
          title: 'Nomor Handphone ',
          backgroundColor: kWarningMain,
        );
      } else if (bioU.isEmpty) {
        DialogHelper.showSnackBar(
          'BIO tidak boleh kosong',
          title: 'BIO ',
          backgroundColor: kWarningMain,
        );
      } else {
        DialogHelper.showLoading('Loading Update Data..');
        var usersUpdate = {
          'firstName': namaD,
          'lastName': namaB,
          'phone': phoneU,
          'bio': bioU,
        };

        try {
          await UserStore().updateUserData(usersUpdate);
          DialogHelper.hideLoading();
          DialogHelper.showSnackBar(
            'Berhasil Update Data Profile',
            title: 'Successfully',
            backgroundColor: kSuccessMain,
          );
        } catch (e) {
          DialogHelper.showErroDialog();
        }
      }
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: kWhiteColor,
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: 14,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child:
                                const Icon(Icons.keyboard_backspace_rounded)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Info Profile',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: extraBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.5,
                    ),
                    Column(
                      children: [
                        //Avatar
                        Container(
                          height: 90,
                          width: 90,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/image_destination1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //ShortInfo
                        Text(
                          'Ubah Foto',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFieldText(
                      textController: emailController,
                      hintText: 'contoh: abe@gmailcom',
                      icon: Icons.email,
                      label: 'Email',
                      activeBg: true,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldText(
                      textController: namaDepanController,
                      hintText: 'contoh: Sandy',
                      icon: Icons.email,
                      label: 'Nama Depan',
                      activeBg: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldText(
                      textController: namaBelakangController,
                      hintText: 'contoh: Tarigan',
                      icon: Icons.email,
                      label: 'Nama Belakang',
                      activeBg: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldText(
                      textController: bioController,
                      hintText: 'contoh: Semangat Selalu',
                      icon: Icons.email,
                      label: 'Bio',
                      activeBg: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldText(
                      textController: nomorHpController,
                      hintText: 'contoh: 0812219992',
                      icon: Icons.email,
                      label: 'Phone',
                      activeBg: true,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Simpan',
                          onPressed: () {
                            updateUserDetail();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
