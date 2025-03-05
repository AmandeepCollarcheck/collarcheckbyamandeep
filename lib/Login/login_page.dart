import 'package:collarchek/Login/login_controller.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_screen_header.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/image_path.dart';

class LoginScreen extends GetView<LoginControllers>{
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: appScreenBackgroundColor,
        appBar: commonAppBar(context,onClick: (){
          controller.backClick();
        }),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                commonScreenHeader(headerName: appLoginToYourAccount),
                SizedBox(height: 10,),
                Form(
                  key: controller.formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Obx(()=>commonTextFieldWithCountryCode(context,controller: controller.phoneController, hintText: appEnterPhoneNumber, countryFlag: controller.selectedCountryFlag.value,
                        selectedCountryFlag: (Map<String, String> newCountryData) {
                          controller.selectedCountryFlag.value=newCountryData['countryFlag'];
                          controller.countryCode.value="+${newCountryData['countryCode']}";
                        },validator: (value) => value!.isEmpty ? appPhoneNumber+appIsRequired : null,))),
                ),
                SizedBox(height: 20,),
                commonButton(context, buttonName: appSendOTP, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor,buttonBorderColor: appPrimaryColor ,onClick: (){
                  controller.sendOtpLogin(context);
                }),
                Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: appGreyBlackColor,
                      thickness: 1, // Line thickness
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      appContinue,
                        style: AppTextStyles.font14.copyWith(color: appGreyBlackColor,)
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: appGreyBlackColor,
                      thickness: 1, // Line thickness
                    ),
                  ),
                ],
              ),
            ),
                SizedBox(height: 20,),
                _commonSocialSignIN(context,socialName: appContinueWithGoogle,onClick: (){
                   controller.googleLogin();
                },socialIcon: appGoogleIcon),
                SizedBox(height: 10,),
                _commonSocialSignIN(context,socialName: appContinueWithFacebook,onClick: (){
                  ///Gooogle click
                },socialIcon: appFacebookIcon),
                SizedBox(height: 10,),
                _commonSocialSignIN(context,socialName: appContinueWithLinkedin,onClick: (){
                  ///Gooogle click
                },socialIcon: appLinkdinSvg),
                SizedBox(height: 10,),
                _commonSocialSignIN(context,socialName: appContinueWithApple,onClick: (){
                  ///Gooogle click
                },socialIcon: appGoogleIcon),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(appLinkdinSvg,height: 20,width: 20,),
                    SizedBox(width: 10,),
                   // Text(socialName,  style: AppTextStyles.font16.copyWith(color: appBlackColor,)),
                  ],
                ),

                SizedBox(height: 80,),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                          children: [
                            TextSpan(
                              text:  appDontHaveAnAccountt,
                              style: AppTextStyles.font14.copyWith(color: appBlackColor), // Normal text style
                            ),
                            TextSpan(
                              text: appSignUp,
                              style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.signUpButtonClick();
                                  // Navigate to Terms of Use page or any action
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
          ]),
        ),
      ),
    ));
  }

  _commonSocialSignIN(context,{required String socialName,required VoidCallback onClick,required String socialIcon}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        alignment: Alignment.center,
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: appGreyBlackColor,width: 1)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            socialIcon.contains(".svg")?SvgPicture.asset(socialIcon,height: 20,width: 20,):Image.asset(socialIcon,height: 20,width: 20,),
            SizedBox(width: 10,),
            Text(socialName,  style: AppTextStyles.font16.copyWith(color: appBlackColor,)),
          ],
        )
      ),
    );
  }


}