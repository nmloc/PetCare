import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/community/community_controller.dart';
import 'package:dogs_park/pages/social/community/community_feed_screen.dart';
import 'package:dogs_park/pages/social/community/create_community_screen.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CommunityList extends StatefulWidget {
  CommunityListType communityType;

  CommunityList(this.communityType);
  @override
  _CommunityListState createState() => _CommunityListState();
}

CommunityController controller = CommunityController();

class _CommunityListState extends State<CommunityList> {
  CommunityListType communityType = CommunityListType.recommend;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    communityType = widget.communityType;
    Future.delayed(Duration.zero, () {
      switch (communityType) {
        case CommunityListType.my:
          controller.initAmityMyCommunityList();
          break;
        case CommunityListType.recommend:
          controller.initAmityRecommendCommunityList();
          break;
        case CommunityListType.trending:
          controller.initAmityTrendingCommunityList();
          break;
        default:
          controller.initAmityMyCommunityList();
          break;
      }
    });
    super.initState();
  }

  List<AmityCommunity> getList() {
    switch (communityType) {
      case CommunityListType.my:
        return controller.getAmityMyCommunities();

      case CommunityListType.recommend:
        return controller.getAmityRecommendCommunities();

      case CommunityListType.trending:
        return controller.getAmityTrendingCommunities();

      default:
        return [];
    }
  }

  int getLength() {
    switch (communityType) {
      case CommunityListType.my:
        return controller.getAmityMyCommunities().length;

      case CommunityListType.recommend:
        return controller.getAmityRecommendCommunities().length;

      case CommunityListType.trending:
        return controller.getAmityTrendingCommunities().length;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            child: getLength() < 1
                // ignore: prefer_const_constructors
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: getLength(),
                    itemBuilder: (context, index) {
                      return StreamBuilder<AmityCommunity>(
                          stream: getList()[index].listen,
                          initialData: getList()[index],
                          builder: (context, snapshot) {
                            return CommunityWidget(
                              community: snapshot.data!,
                              theme: theme,
                              communityType: communityType,
                            );
                          });
                    },
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(const CreateCommunityScreen());
          },
          child: Column(
            children: [
              const Divider(
                color: AppColors.amity_lightGrey,
                thickness: 2,
              ),
              SizedBox(
                height: Dimens.maxHeight_001,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                height: Dimens.maxHeight_007,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Create community",
                    style: AppTextStyle.changePassText
                        .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CommunityWidget extends StatelessWidget {
  const CommunityWidget(
      {Key? key,
      required this.community,
      required this.theme,
      required this.communityType})
      : super(key: key);

  final AmityCommunity community;
  final ThemeData theme;
  final CommunityListType communityType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ChangeNotifierProvider(
        //           create: (context) => CommuFeedVM(),
        //           child: CommunityScreen(
        //             community: community,
        //           ),
        //         )));
        Get.to(CommunityScreen(
          community: community,
        ));
        switch (communityType) {
          case CommunityListType.my:
            controller.initAmityMyCommunityList();
            break;
          case CommunityListType.recommend:
            controller.initAmityRecommendCommunityList();
            break;
          case CommunityListType.trending:
            controller.initAmityTrendingCommunityList();
            break;
          default:
            controller.initAmityMyCommunityList();
            break;
        }
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              ListTile(
                  leading: FadeAnimation(
                    child: (community.avatarImage?.fileUrl != null)
                        ? SizedBox(
                            height: Dimens.maxWidth_014,
                            width: Dimens.maxWidth_014,
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: (NetworkImage(
                                    community.avatarImage!.fileUrl))),
                          )
                        : SizedBox(
                            height: Dimens.maxWidth_014,
                            width: Dimens.maxWidth_014,
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/user_placeholder.png")),
                          ),
                  ),
                  title: Text(
                    community.displayName ?? "Community",
                    style: AppTextStyle.titleLarge.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1A1B23)),
                  ),
                  subtitle: Text(
                    " ${community.membersCount} members",
                    style: AppTextStyle.titleLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffC9C9C9)),
                  ),
                  trailing: GestureDetector(
                    child: Container(
                      height: Dimens.maxHeight_005,
                      width: Dimens.maxWidth_02,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          community.isJoined != null
                              ? (community.isJoined! ? "Leave" : "Join")
                              : "Join",
                          style: AppTextStyle.changePassText.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (community.isJoined != null) {
                        if (community.isJoined!) {
                          controller.leaveCommunity(community.communityId ?? "",
                              type: communityType);
                        } else {
                          controller.joinCommunity(community.communityId ?? "",
                              type: communityType);
                        }
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
