import 'dart:math';

import 'package:collarchek/StartUp/startup_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/image_path.dart';

class StartUpScreen extends GetView<StartUpControllers>{
  const StartUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: appScreenBackgroundColor,
        body: Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 20),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(appStartupImage,height: 308,),
              SizedBox(height: 10,),
              Column(
                children: <Widget>[
                  Text(appCreateYourCollarCheckAccount,style: AppTextStyles.font28.copyWith(color: appBlackColor,),textAlign: TextAlign.center,),
                  Text(appNameContent,style:AppTextStyles.semiBold.copyWith(color: appGreyBlackColor),textAlign: TextAlign.center,)
                ],
              ),
              SizedBox(height: 20,),
              commonButton(context, buttonName: appSignUp, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor,buttonBorderColor: appPrimaryColor ,onClick: (){
                controller.signUpButtonClick();
              }),
              SizedBox(height: 20,),
              commonButton(context, buttonName: appLogin, buttonBackgroundColor: appWhiteColor, textColor: appPrimaryColor,buttonBorderColor: appPrimaryColor ,onClick: (){
                controller.loginClick();
              }),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
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
                              text: appByContinuingYouAgreeToOur,
                              style: AppTextStyles.font14.copyWith(color: appBlackColor), // Normal text style
                            ),
                            TextSpan(
                              text: appTermsOfUse,
                              style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Terms of Use clicked");
                                  // Navigate to Terms of Use page or any action
                                },
                            ),
                            TextSpan(
                              text:  appAnd,
                              style: AppTextStyles.font14.copyWith(color: appBlackColor),
                            ),
                            TextSpan(
                              text: appPrivacyPolicy,
                              style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Privacy Policy clicked");
                                  // Navigate to Privacy Policy page or any action
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}