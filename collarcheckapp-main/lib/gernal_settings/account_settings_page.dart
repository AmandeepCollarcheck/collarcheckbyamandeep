import 'package:collarchek/api_provider/api_constant.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../models/saveaccount_model/reason_delete_account.dart';
import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/font_styles.dart';
import 'account_settings_controller.dart';

class AccountSettingsPage extends GetView<AccountSettingController> {
  AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Back Button
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Get.offNamed(AppRoutes.bottomNavBar)),
                  SizedBox(width: 8),
                  Text(
                    "Account Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // "Allow messaging" label
              Row(
                children: [
                  Text(
                    "Allow messaging",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.info_outline, size: 18, color: Colors.grey),
                ],
              ),

              SizedBox(height: 10),

              // Radio Buttons
              Obx(() => Column(
                    children: [
                      RadioListTile<String>(
                        title: Text("No one"),
                        value: 'no_one',
                        groupValue: controller.selectedOption.value,
                        onChanged: (val) {
                          controller.selectedOption.value = val!;
                        },
                      ),
                      RadioListTile<String>(
                        title: Text("Everyone"),
                        value: 'everyone',
                        groupValue: controller.selectedOption.value,
                        onChanged: (val) {
                          controller.selectedOption.value = val!;
                        },
                      ),
                      RadioListTile<String>(
                        title: Text("All Companies"),
                        value: 'all_companies',
                        groupValue: controller.selectedOption.value,
                        onChanged: (val) {
                          controller.selectedOption.value = val!;
                        },
                      ),
                    ],
                  )),

              SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // Call controller function or API to save setting
                    // controller.saveMessagingPreference(selectedOption.value);
                    //Get.snackbar("Success", "Settings saved!");

                    controller.postsaveaccountApiCall();
                  },
                  child: Text("Save Settings",
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              SizedBox(height: 30),

              // Close Account Option
              Text("Do you want to close your account?"),
              GestureDetector(
                onTap: () {
                  showCloseAccountDialog(
                      context, controller); // Define this in controller
                },
                child: Text(
                  "Close My Account",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCloseAccountDialog(
      BuildContext context, AccountSettingController controller) {
    Get.defaultDialog(

      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(0),
      radius: 12,
      title: '',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [


          Align(
              alignment: Alignment.topRight,
              child: CupertinoButton(

                onPressed: () {


                  Get.back();
                },
                child: Padding(padding: EdgeInsets.only(right: 10),

                    child:
                SvgPicture.asset(appCloseIconWithCircularBorderSvgIcon,height: 25,width: 25,color: Colors.black,)),
              )
          ),




          Center(
              child: Image.asset(
            appalertBox,
            width: 40,
            height: 40,
          )),
          SizedBox(height: 10),
          Center(
              child: Text(
            "Are you sure you want to close your account?",
            style: AppTextStyles.semiBold.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          )),
          SizedBox(height: 20),
          Obx(() => Padding(
            padding: EdgeInsets.all(20),
            child: DropdownButtonFormField<String>(
            
                isExpanded: true,
                  value: controller.selectedReasonName.value.isEmpty
                      ? null
                      : controller.selectedReasonName.value,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    hintText: "Select Reason",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  hint: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
            
                      child:
                  Text("Select Reason")),
                  items: controller.deleteAccountOptionsList.map((reason) {
                    return DropdownMenuItem<String>(
                      value: reason.name,
                      child: Text(
                        reason.name ?? '',
                        style: AppTextStyles.medium.copyWith(color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedReasonName.value = value ?? '';
            
                    // Find and store corresponding ID
                    final matchedItem =
                        controller.deleteAccountOptionsList.firstWhere(
                      (element) => element.name == value,
                      orElse: () => ReasonOptionsList(id: '', name: ''),
                    );
            
                    controller.selectedReasonId.value = matchedItem.id ?? '';
            
                    print(
                        "Selected reason id: ${controller.selectedReasonId.value}");
                  },
                ),
          )),
          SizedBox(height: 10),
          Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Please describe your reason",


                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Default border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // When not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // ✅ When focused
                ),
              ),
              style: AppTextStyles.medium.copyWith(color: Colors.black),
              textAlign: TextAlign.left,

            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () => controller.deleteAccountApi(),
                  child: Container(
                    margin: EdgeInsets.only(),

                    alignment: Alignment.centerRight,
                    // ensures text aligns to the right

                    child: Text(closemyaccount,
                        style: TextStyle(
                          color: appRedColor,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.right),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: commonButton(context,
                    buttonName: cancel,
                    buttonBackgroundColor: appPrimaryColor,
                    textColor: appWhiteColor,
                    buttonBorderColor: appPrimaryColor, onClick: () {
                  // controller.saveUserProfile(context);
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
