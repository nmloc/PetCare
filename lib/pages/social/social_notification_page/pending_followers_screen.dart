import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PendingFollowersScreen extends StatefulWidget {
  const PendingFollowersScreen({super.key});

  @override
  State<PendingFollowersScreen> createState() => _PendingFollowersScreenState();
}

class _PendingFollowersScreenState extends State<PendingFollowersScreen> {
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            SizedBox(height: maxHeight * 0.02),
            SizedBox(
              height: maxHeight * 0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("images/golden2.jpg"),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Jack",
                        style: AppTextStyle.titleLarge.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
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
                                      borderRadius: BorderRadius.circular(
                                          Dimens.border_8),
                                      color: AppColors.primary,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Follow",
                                      style:
                                          AppTextStyle.changePassText.copyWith(
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
              ),
            ),
            SizedBox(
              height: maxHeight * 0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("images/golden2.jpg"),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Kenvin",
                        style: AppTextStyle.titleLarge.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
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
                                      borderRadius: BorderRadius.circular(
                                          Dimens.border_8),
                                      color: AppColors.primary,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Follow",
                                      style:
                                          AppTextStyle.changePassText.copyWith(
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
              ),
            ),
            SizedBox(
              height: maxHeight * 0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("images/golden2.jpg"),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "May",
                        style: AppTextStyle.titleLarge.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
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
                                      borderRadius: BorderRadius.circular(
                                          Dimens.border_8),
                                      border: Border.all(
                                          width: 1, color: AppColors.primary),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Followed",
                                      style: AppTextStyle.changePassText
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary),
                                    )),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
