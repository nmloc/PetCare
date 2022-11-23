import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/social/components/custom_user_avatar.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

class FollowCard extends StatelessWidget {
  AmityFollowRelationship relationship;

  Function? onAccept;
  Function? onDecline;
  FollowCard(
      {this.onAccept, this.onDecline, required this.relationship, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  offset: Offset(0, 3),
                  blurRadius: 1.0),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getAvatarImage(relationship.sourceUser?.avatarUrl),
                SizedBox(width: 15),
                Text(
                  relationship.sourceUser?.displayName ?? "",
                  style: AppTextStyle.titleLarge
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            relationship.status == AmityFollowStatus.ACCEPTED
                ? Container(
                    constraints: BoxConstraints(maxHeight: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.border_8),
                      border: Border.all(color: AppColors.primary),
                      color: AppColors.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                        child: Text(
                      "Following",
                      style: AppTextStyle.changePassText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary),
                    )),
                  )
                : Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: maxHeight * 0.04,
                          width: maxWidth * 0.23,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.border_8),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                    child: Text(
                                  "Decline",
                                  style: AppTextStyle.changePassText.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              )),
                        ),
                        SizedBox(width: maxWidth * 0.01),
                        SizedBox(
                          height: maxHeight * 0.04,
                          width: maxWidth * 0.23,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.border_8),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                    child: Text(
                                  "Accept",
                                  style: AppTextStyle.changePassText.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              )),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
