import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/routes/app_routes.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotificationDetail extends StatelessWidget {
  String content;
  NotificationDetail({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: maxHeight * 0.02,
          ),
          Text(
            "Today",
            style: AppTextStyle.titleLarge
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 16, right: 10),
                  leading: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.userInformation);
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage("images/golden2.jpg"),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      style: AppTextStyle.titleSmall.copyWith(
                        letterSpacing: 0.5,
                      ),
                      children: [
                        TextSpan(
                            text: "kevinTaylor",
                            style: AppTextStyle.titleSmall.copyWith(
                                fontSize: 12, color: AppColors.black)),
                        TextSpan(
                            text: ' ' + content + ' ',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 12)),
                        TextSpan(
                            text: "yourPost",
                            style: AppTextStyle.titleSmall.copyWith(
                                fontSize: 12, color: AppColors.black)),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    'Today 10.00 am',
                    style: AppTextStyle.titleSmall.copyWith(
                      fontSize: 9,
                      color: AppColors.amity_textGrey,
                    ),
                  ),
                  trailing: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(
                        'images/samoyed1.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            "Yesterday",
            style: AppTextStyle.titleLarge
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 16, right: 10),
                  leading: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.userInformation);
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage("images/golden2.jpg"),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      style: AppTextStyle.titleSmall.copyWith(
                        letterSpacing: 0.5,
                      ),
                      children: [
                        TextSpan(
                            text: "kevinTaylor",
                            style: AppTextStyle.titleSmall.copyWith(
                                fontSize: 12, color: AppColors.black)),
                        TextSpan(
                            text: ' ' + content + ' ',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 12)),
                        TextSpan(
                            text: "yourPost",
                            style: AppTextStyle.titleSmall.copyWith(
                                fontSize: 12, color: AppColors.black)),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    'Today 10.00 am',
                    style: AppTextStyle.titleSmall.copyWith(
                      fontSize: 9,
                      color: AppColors.amity_textGrey,
                    ),
                  ),
                  trailing: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(
                        'images/samoyed1.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
