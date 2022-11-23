import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/customers.dart';
import '../utils/data_bucket.dart';

class UserInformationController extends GetxController {
  @override
  void onInit() async {
    await _getData();
    super.onInit();
  }

  static Customer customerList = DataBucket.getInstance().getCustomerList();
  static AmityUser amityUser = AmityCoreClient.getCurrentUser();
  Rx<DateTime> pickedDate = customerList.dateofbirth.obs;
  RxBool enabled = false.obs;
  RxString customerGender = customerList.gender.obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController()
    ..text = amityUser.displayName ?? "";
  final TextEditingController userIDController = TextEditingController()
    ..text = amityUser.userId ?? "";
  final TextEditingController descriptionController = TextEditingController()
    ..text = amityUser.description ?? "";
  void setSelected(String value) {
    customerGender.value = value;
  }

  Future<void> _getData() async {
    print("USERCTRL: " + amityUser.toString());
    fullNameController.text = UserInformationController.customerList.fullname;
    print("Full name:" + fullNameController.text);
    phoneNumberController.text =
        UserInformationController.customerList.phonenumber;
    addressController.text = UserInformationController.customerList.address;
    displayNameController.text = amityUser.displayName ?? "";
    userIDController.text = amityUser.userId ?? "";
    descriptionController.text = amityUser.description ?? "";
  }
}
