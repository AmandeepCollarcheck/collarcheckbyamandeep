import 'package:collarchek/account_verification/account_verification_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/image_path.dart';

class AccountVerificationPage extends GetView<AccountVerificationControllers>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx((){
            var isPhoneVerified=controller.isPhoneVerified??"";
            var isEmailVerified=controller.isEmailVerified??"";
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                commonActiveSearchBar(
                  onClick: (){
                    controller.backButtonClick(context);
                  },
                  leadingIcon: appBackSvgIcon,
                  screenName: appAccountVerification,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          commonTextFieldTitle(headerName: appVerifyMobile,isMendatory: true),
                          isPhoneVerified=="1"?Row(
                            children: <Widget>[
                              SvgPicture.asset(appVerifiedIcon,height: 16,width: 16,),
                              SizedBox(width: 3,),
                              Text(appMobileVerified,style: AppTextStyles.font14W500.copyWith(color: appGreenColor),)
                            ],
                          ):Container()
                        ],
                      ),
                      SizedBox(height: 5,),
                      commonTextField(controller: controller.companyPhoneController,keyboardType: TextInputType.emailAddress , hintText: appVerifyMobile, isRealOnly: true),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          commonTextFieldTitle(headerName: appVerifyEmail,isMendatory: true),
                          isEmailVerified=="1"?Row(
                            children: <Widget>[
                              SvgPicture.asset(appVerifiedIcon,height: 16,width: 16,),
                              SizedBox(width: 3,),
                              Text(appMobileVerified,style: AppTextStyles.font14W500.copyWith(color: appGreenColor),)
                            ],
                          ):Container()
                        ],
                      ),

                      SizedBox(height: 5,),
                      commonTextField(controller: controller.companyEmailController,keyboardType: TextInputType.emailAddress , hintText: appEmailId, isRealOnly: true),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                isEmailVerified=="1"?Container():SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: commonButton(
                      context,
                      buttonName: appVerifyEmail,
                      buttonBackgroundColor: appPrimaryColor,
                      textColor: appWhiteColor,
                      buttonBorderColor: appPrimaryColor,
                      onClick: (){
                        controller.verifyEmailIdApiCall();

                      }
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

}