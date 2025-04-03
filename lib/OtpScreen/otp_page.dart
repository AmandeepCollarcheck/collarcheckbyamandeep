import 'package:collarchek/OtpScreen/otp_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_screen_header.dart';

class OtpPage extends StatelessWidget {
  const  OtpPage({super.key});
  @override
  Widget build(BuildContext context){
    return GetBuilder<OtpController>(
      builder: (controller){
        return SafeArea(
          child: Scaffold(
            backgroundColor: appScreenBackgroundColor,
            appBar: commonAppBar(context,onClick: (){
              controller.onBack(isLogin: controller.isLoginScreenData.value);
            }),
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    commonScreenHeader(headerName:appEnterOtp),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                         Obx((){
                           return controller.isEmailVerificationData.value?Text("$appWeHaveSentOTPOnYourEmail${controller.mobileNumberData.value}",style: AppTextStyles.font16W600.copyWith(color: appGreyBlackColor),textAlign: TextAlign.center,): Text("$appWeHaveSentOTP${controller.mobileNumberData.value}",style: AppTextStyles.font16W600.copyWith(color: appGreyBlackColor),textAlign: TextAlign.center,);
                         }),
                          SizedBox(height: 20,),
                          Form(key: controller.formKey,
                            child: PinCodeTextField(
                              controller: controller.otpController,
                              appContext: context,
                              obscureText: false,
                              length: 6,
                              onChanged: (value) {
                                controller.otpController.text = value; // 🔥 Ensure controller updates
                              },
                              onCompleted: (String value){
                                controller.loginButtonClick(context);
                              },
                              validator: (value) => value!.isEmpty ? appOtp+appIsRequired : null,
                              pinTheme: PinTheme(
                                fieldHeight: 40,
                                fieldWidth: 40,
                                activeColor: appPrimaryColor,
                                activeFillColor: appPrimaryColor,
                                inactiveColor: appGreyBlackColor,
                                disabledColor: appGreyBlackColor,
                                selectedFillColor: appPrimaryColor,
                                inactiveBorderWidth: 1,
                                selectedBorderWidth: 1,
                                disabledBorderWidth: 1,
                              ),
                              cursorColor: appPrimaryColor,
                              errorTextSpace: 30,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Obx(()=>RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                    children: [
                                      TextSpan(
                                        text:  appDidNotGetTheOTP,
                                        style: AppTextStyles.font16W600.copyWith(color: appBlackColor), // Normal text style
                                      ),
                                      controller.otpCountDownTimer.value==0?
                                      TextSpan(
                                        text: appResend,
                                        style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            controller.resendOtp(context);
                                          },
                                      ): TextSpan(
                                        text: "0.${controller.otpCountDownTimer.value.toString()} $appSec",
                                        style:  AppTextStyles.font14.copyWith(color: appPrimaryColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                           // controller.resendOtp(context);
                                          },
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.34,),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          commonButton(context, buttonName: controller.isEmailVerificationData.value?appVerifyEmail:appLogin, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor,buttonBorderColor: appPrimaryColor ,onClick: (){
                           if(controller.isEmailVerificationData.value){
                             controller.verifyEmailOtpAPiCall(context);
                           }else{
                             controller.loginButtonClick(context);
                           }

                          }),
                          SizedBox(height: 20,),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                              children: [
                                TextSpan(
                                  text: appDontHaveAnAccountt,
                                  style: AppTextStyles.font16W600.copyWith(color: appBlackColor), // Normal text style
                                ),
                                TextSpan(
                                  text: appSignUp,
                                  style:  AppTextStyles.font16W600Underline.copyWith(color: appPrimaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      controller.signUpButtonClick(context);
                                    },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}