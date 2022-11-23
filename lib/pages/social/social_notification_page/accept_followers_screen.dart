import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/social/controller/follow_controller.dart';
import 'package:dogs_park/pages/social/social_notification_page/components/follow_card.dart';
import 'package:dogs_park/routes/app_routes.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AcceptFollowersScreen extends StatelessWidget {
  final FollowController followController = FollowController();
  AcceptFollowersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    print("Rebuild");
    followController.queryFollowers();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Obx(
        () => Column(
          children: [
            SizedBox(height: maxHeight * 0.02),
            ...followController.followRelationships.map((element) {
              return FollowCard(
                relationship: element,
              );
            })
          ],
        ),
      ),
    );
  }
}
