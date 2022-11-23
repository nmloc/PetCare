import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/widgets/customTextField.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController _communityNameController =
      TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        title: Text(
          'Create community',
          style: AppTextStyle.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: const Color(0xff030303)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
            color: AppColors.white,
            width: maxWidth,
            height: maxHeight * 0.88,
            child: Column(
              children: [
                SizedBox(height: maxHeight * 0.04),
                SizedBox(
                  height: Dimens.maxHeight_015,
                  width: Dimens.maxHeight_015,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(Images.defaultAvatarImage),
                      ),
                      // Obx(() {
                      //   if (controller.isLoading.value) {
                      //     return const CircleAvatar(
                      //       backgroundImage: AssetImage(Images.imageDefault),
                      //       child: Center(
                      //           child: CircularProgressIndicator(
                      //         backgroundColor: Colors.white,
                      //       )),
                      //     );
                      //   } else {
                      //     if (controller.imageURL.length != 0) {
                      //       return CachedNetworkImage(
                      //         imageUrl: controller.imageURL,
                      //         fit: BoxFit.cover,
                      //         imageBuilder: (context, imageProvider) =>
                      //             CircleAvatar(
                      //           backgroundColor: Colors.white,
                      //           backgroundImage: imageProvider,
                      //         ),
                      //         placeholder: (context, url) => const CircleAvatar(
                      //           backgroundImage:
                      //               AssetImage(Images.defaultAvatarImage),
                      //           child: Center(
                      //               child: CircularProgressIndicator(
                      //             backgroundColor: Colors.white,
                      //           )),
                      //         ),
                      //         errorWidget: (context, url, error) =>
                      //             const Icon(Icons.error),
                      //       );
                      //     } else {
                      //       return const CircleAvatar(
                      //         backgroundImage:
                      //             AssetImage(Images.defaultAvatarImage),
                      //       );
                      //     }
                      //   }
                      // }),
                      Positioned(
                        left: maxHeight * 0.11,
                        bottom: 0,
                        child: SizedBox(
                          height: maxHeight * 0.04,
                          width: maxHeight * 0.04,
                          child: Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                Get.bottomSheet(
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text(
                                            'Camera',
                                            style: AppTextStyle.titleMedium
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text(
                                            'Gallery',
                                            style: AppTextStyle.titleMedium
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColors.white,
                                  size: maxHeight * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: maxHeight * 0.04),
                CustomTextField(
                  fieldName: "Community name",
                  controllerName: _communityNameController,
                  enabled: true,
                ),
                SizedBox(height: maxHeight * 0.003),
                CustomTextField(
                  fieldName: "About (optional)",
                  controllerName: _aboutController,
                  enabled: true,
                ),
                SizedBox(height: maxHeight * 0.003),
                CustomTextField(
                  fieldName: "Category",
                  controllerName: _categoryController,
                  enabled: true,
                ),
                SizedBox(height: maxHeight * 0.25),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: maxWidth * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: maxHeight * 0.07,
                        width: maxWidth * 0.4,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimens.border_8),
                                color: AppColors.red,
                              ),
                              child: Center(
                                  child: Text(
                                "Discard",
                                style: AppTextStyle.changePassText.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              )),
                            )),
                      ),
                      SizedBox(width: maxWidth * 0.03),
                      SizedBox(
                        height: maxHeight * 0.07,
                        width: maxWidth * 0.4,
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
                                "Create",
                                style: AppTextStyle.changePassText.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              )),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
