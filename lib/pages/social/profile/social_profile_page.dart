import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/chat/chat_screen.dart';
import 'package:dogs_park/pages/social/components/feed_post.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/channel_controller.dart';

class SocialProfilePage extends StatelessWidget {
  final AmityUser user;
  RxInt followingNumber = 0.obs;
  RxInt followerNumber = 0.obs;
  RxString followStatus = "Follow".obs;
  RxBool processing = true.obs;
  RxList<AmityPost> posts = RxList();
  SocialProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    user.relationship().getFollowInfo().then(((value) async {
      followerNumber.value = value.followerCount ?? 0;
      followingNumber.value = value.followingCount ?? 0;

      if (value.status == AmityFollowStatus.ACCEPTED) {
        followStatus.value = "Unfollow";
      }
      if (value.status == AmityFollowStatus.PENDING) {
        followStatus.value = "Pending...";
      }

      var postsData = await user.getFeed().getPagingData();
      posts.clear();
      posts.addAll(postsData.data);
      processing.value = false;
    }));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
            title: Text('Information'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Obx(
            () => processing.value
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: AppColors.gray,
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    color: Colors.white,
                    child: ListView(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 28, bottom: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextsColumn(followerNumber.value, 'Followers'),
                            Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: user.avatarUrl != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              user.avatarCustomUrl ?? ""),
                                        )
                                      : const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              "images/user_placeholder.png")),
                                ),
                                Text(
                                  user.displayName!,
                                  style: AppTextStyle.userDisplayText,
                                )
                              ],
                            ),
                            TextsColumn(followingNumber.value, 'Following'),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              var currentUser = AmityCoreClient.getUserId();
                              if (user.userId != null &&
                                  currentUser != user.userId!) {
                                ChannelController.createConversationChannel(
                                    [currentUser, user.userId!],
                                    (channel, error) {
                                  if (channel != null) {
                                    Get.to(ChatSingleScreen(
                                      key: UniqueKey(),
                                      channel: channel.channels![0],
                                    ));
                                  }
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: AppColors.primary)),
                              width: 140,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(
                                    Icons.message,
                                    color: AppColors.primary,
                                  ),
                                  Text(
                                    'Message',
                                    style: AppTextStyle.buttonText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (followStatus.value == "Follow") {
                                user.relationship().follow().then((value) {
                                  print(value);
                                  if (value == AmityFollowStatus.ACCEPTED) {
                                    followerNumber.value += 1;
                                    followStatus.value = 'Unfollow';
                                  }
                                });
                              } else if (followStatus.value == "Unfollow") {
                                user.relationship().unfollow().then((value) {
                                  print(value);
                                  if (value != AmityFollowStatus.ACCEPTED) {
                                    followerNumber.value -= 1;
                                    followStatus.value = 'Follow';
                                  }
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              width: 140,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                followStatus.value,
                                style: AppTextStyle.buttonText
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      TabBar(
                          unselectedLabelColor: AppColors.gray,
                          indicatorColor: AppColors.primary,
                          labelColor: AppColors.primary,
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelStyle: AppTextStyle.tabText,
                          labelStyle: AppTextStyle.tabText
                              .copyWith(color: AppColors.primary),
                          tabs: const [
                            Tab(
                              child: Text(
                                'Posts',
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Stories',
                              ),
                            ),
                          ]),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .8,
                            maxHeight: 300),
                        child: TabBarView(physics: ScrollPhysics(), children: [
                          ListView(
                            children: [
                              ...posts.map(
                                (element) => Container(
                                    padding: const EdgeInsets.all(4.0),
                                    margin: EdgeInsets.only(bottom: 4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Color(0xFFEEEEEE), width: 1),
                                    ),
                                    child: FeedPost(
                                        post: element,
                                        onPostDeleteHandler: () {})),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text('No story posted'),
                            ],
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ]),
                  ),
          )),
    );
  }

  Widget TextsColumn(int num, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: AppTextStyle.followNumberText,
        ),
        Text(
          content,
          style: AppTextStyle.followText,
        )
      ],
    );
  }
}
