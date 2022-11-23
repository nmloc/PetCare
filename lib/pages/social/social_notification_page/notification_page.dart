import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/social_notification_page/accept_followers_screen.dart';
import 'package:dogs_park/pages/social/social_notification_page/components/notification_detail_page.dart';
import 'package:dogs_park/pages/social/social_notification_page/pending_followers_screen.dart';
import 'package:dogs_park/routes/app_routes.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage("images/golden2.jpg"),
                  ),
                ),
              ),
            ],
            title: const Text('Notification'),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TabBar(
                  physics: BouncingScrollPhysics(),
                  isScrollable: true,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: "All"),
                    Tab(text: "Likes"),
                    Tab(text: "Comments"),
                    Tab(
                      child: Row(
                        children: [
                          Text("Followers"),
                          SizedBox(width: 5),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "3",
                                style: AppTextStyle.changePassText
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Tab(text: "Following"),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              NotificationDetail(
                content: "Liked",
              ),
              NotificationDetail(
                content: "Liked",
              ),
              NotificationDetail(
                content: "Commented",
              ),
              AcceptFollowersScreen(),
              PendingFollowersScreen()
            ],
          ),
        ),
      ),
    );
  }
}
