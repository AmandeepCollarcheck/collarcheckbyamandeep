import 'package:collarchek/StartSignUp/start_signup_controller.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_button.dart';

import '../utills/common_widget/common_screen_header.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';

class StartSignUpPage extends GetView<StartUpSignupController>{
   const StartSignUpPage({super.key});
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: appScreenBackgroundColor,
        appBar: commonAppBar(context,onClick: (){
          controller.backClick();
        }),

        body: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.25),
              commonScreenHeader(headerName: appContinueAsa),
              commonButton(context, buttonName: appCompany, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor,buttonBorderColor: appPrimaryColor ,onClick: (){
               controller.companySignUpClick();
              }),
              SizedBox(height: 10,),
              commonButton(context, buttonName: appIndividual, buttonBackgroundColor: appWhiteColor, textColor: appPrimaryColor,buttonBorderColor: appPrimaryColor ,onClick: (){
                controller.individualSignUpClick();
              }),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 40),
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
                              text:  appAlreadyHaveAnAccount,
                              style: AppTextStyles.font14.copyWith(color: appBlackColor), // Normal text style
                            ),
                            TextSpan(
                              text: appLogin,
                              style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                 controller.loginButtonClick();
                                  // Navigate to Terms of Use page or any action
                                },
                            ),
                            TextSpan(
                              text:  appHere,
                              style: AppTextStyles.font14.copyWith(color: appBlackColor), // Normal text style
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
        ),
      ),
    );
  }
}