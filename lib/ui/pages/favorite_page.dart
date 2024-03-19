import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/users_controller.dart';

import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Get Users',
            onPressed: () {
              Get.find<UsersController>().getUsersList();
            },
            width: 200,
          ),
          GetBuilder<UsersController>(builder: (users) {
            return users.isLoaded
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: users.usersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 200,
                        child: Text(
                          users.usersList[index],
                          style: blackTextStyle,
                        ),
                      );
                    })
                : CircularProgressIndicator(color: kRedColor);
          })
        ],
      ),
    );
  }
}
