import 'package:dogs_park/pages/social/community/community_controller.dart';
import 'package:dogs_park/pages/social/community/community_list.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CommunityTabbar extends StatelessWidget {
  const CommunityTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
            title: const Text('Explore'),
            centerTitle: true,
            bottom: const PreferredSize(
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
                    Tab(text: "Recommend"),
                    Tab(text: "Trending"),
                    Tab(text: "My favourites"),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              CommunityList(CommunityListType.recommend),
              CommunityList(CommunityListType.trending),
              CommunityList(CommunityListType.my),
            ],
          ),
        ),
      ),
    );
  }
}
