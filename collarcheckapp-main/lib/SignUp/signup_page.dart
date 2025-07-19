import 'package:collarchek/SignUp/signup_controllers.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_screen_header.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class SignUpPage extends GetView<SignUpControllers>{
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context){
    return PopScope(
      canPop: false, // Prevents default back behavior
      onPopInvoked: (didPop) {
        if (!didPop) {
          onWillPop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appScreenBackgroundColor,
          appBar: commonAppBar(context,onClick: (){
            controller.backButtonClick();
          }),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  commonScreenHeader(headerName: controller.isCompanyProfile.value==false?"$appSignUpAsACompany$appIndividual":"$appSignUpAsACompany$appCompany"),

                  Form(
                    key: controller.formKey,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          ///For Individual
                          controller.isCompanyProfile.value==false?commonTextField(controller: controller.firstNameController, hintText: appFirstName, validator: (value) => value!.isEmpty ? appFirstName+appIsRequired : null,inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.deny(RegExp(r'[^\sa-zA-Z]')),
                          ]):Container(),
                          controller.isCompanyProfile.value==false?SizedBox(height: 10,):SizedBox(height: 0,),
                          controller.isCompanyProfile.value==false?commonTextField(controller: controller.lastNameController, hintText: appLastName, validator: (value) => value!.isEmpty ? appLastName+appIsRequired : null,inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.deny(RegExp(r'[^\sa-zA-Z]')),
                          ]):Container(),


                          ///For Company
                          ///For Company
                          controller.isCompanyProfile.value == true
                              ? commonTextField(
                              controller: controller.companyController,
                              hintText: appCompanyName,
                              validator: (value) => value!.isEmpty
                                  ? appCompanyName + appIsRequired
                                  : null,
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(30),
                                // Max 30 characters
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+')),
                                // No leading spaces
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9 &-]')),
                                // Allowed characters
                              ])
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),




                          SizedBox(height: 10,),
                          Obx(()=>commonTextFieldWithCountryCode(context,countryFlag:
                          controller.selectedCountryFlag.value, controller: controller.phoneController,
                              hintText:  appPhoneNumber, validator: (value) =>
                              value!.isEmpty ? appPhoneNumber+appIsRequired : null,
                              selectedCountryFlag: (Map<String, String> newCountryData) {
                                controller.selectedCountryFlag.value=newCountryData['countryFlag'];
                                controller.countryCode.value="+${newCountryData['countryCode']}";
                              }),),
                          // commonTextField(controller: controller.phoneController, hintText: appPhoneNumber),
                          SizedBox(height: 10,),
                          ///For Company
                          ///company email
                          controller.isCompanyProfile.value == true
                              ? commonTextField(
                            controller: controller.companyEmailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: appCompanyEmail,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '$appCompanyEmail$appIsRequired';
                              }

                              // Trim input first
                              final trimmed = value.trim();

                              // ✅ Must start with a letter
                              if (!RegExp(r'^[a-zA-Z]')
                                  .hasMatch(trimmed)) {
                                return 'Email must start with a letter';
                              }

                              // ✅ Must match full pattern: start with letter, valid email, ends with .com
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z][\w.+-]*@[a-zA-Z0-9.-]+\.(com)$');
                              if (!emailRegex.hasMatch(trimmed)) {
                                return 'Enter a valid email with .com domain only';
                              }

                              return null;
                            },
                            inputFormatter: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'^\s+')),
                              // No leading space
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'[a-zA-Z0-9@._+\-]') // Allow valid characters only
                              ),
                            ],
                          )
                              : Container(),
                          ///For Individual
                          controller.isCompanyProfile.value==false?commonTextField(controller: controller.companyEmailController,keyboardType: TextInputType.emailAddress , hintText: appEmailId, validator: (value) => value!.isEmpty ? appEmailId+appIsRequired : null,inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                            FilteringTextInputFormatter.deny(RegExp(r'[^\w\s]{2,}')),
                          ]):Container(),
                          SizedBox(height: 10,),
                          ///For Company
                          /*  controller.isCompanyProfile.value==true?commonTextField(controller: controller.countryController,keyboardType: TextInputType.text ,hintText: appCountryId, validator: (value) => value!.isEmpty ? appCountryId+appIsRequired : null,inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.deny(RegExp(r'[^\sa-zA-Z]')),
                          ]):Container(),

                          ///For Individual
                          controller.isCompanyProfile.value==false?commonTextField(controller: controller.countryController,keyboardType: TextInputType.text , hintText: appCountryId, validator: (value) => value!.isEmpty ? appEmailId+appIsRequired : null,inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.deny(RegExp(r'[^\sa-zA-Z]')),
                          ]):Container(),*/

                          Obx((){
                            var countryData=controller.countryListData.value.data??[];
                            return countryData.isNotEmpty?customDropDown(
                              hintText: appCountry,
                              item: [{'id':"0","name":appSelectCountry},
                                ...countryData.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                              ],
                              selectedValue: countryData.any((datum)=>datum.id==controller.selectedCountry["id"])?controller.selectedCountry:{'id':"0","name":appSelectCountry},
                              onChanged: (Map<String,dynamic>? selectedData) {
                                controller.selectedCountry.value = {
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCountry
                                };
                                /* controller.getStateListApiCall(countryName: selectedData?['id']);
                                controller.country.value=selectedData?['name'];*/
                              }, icon: appDropDownIcon,):Container();
                          }),

                          SizedBox(height: 10,),
                          commonTextField(controller: controller.referralCodeController, hintText: appReferralCode),
                          SizedBox(height: 20,),

                          _termConditionsWidget(context),
                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),
                  commonButton(context, buttonName: appSendOTP, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor, buttonBorderColor: appPrimaryColor, onClick: (){
                    if (!controller.isTermCheck.value) {
                      // Show a warning: Terms not accepted
                      Get.snackbar(
                        'Terms Required',
                        'Please accept the terms and conditions to continue.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        duration: Duration(seconds: 2),
                      );
                      return;
                    }
                    if(controller.isCompanyProfile.value==false){
                      ///Individual SignUp
                      //controller.sendOtpButtonClick(context);

                      controller.sendOtpButtonSignup(context);
                    }else{

                      controller.sendOtpButtonSignup(context);
                      // controller.companySignUpSendOtpButton(context);
                    }

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

                  ///For Company
                  controller.isCompanyProfile.value==true?_commonSocialSignIN(context,socialName:
                  appSignUpWithGoogle,onClick: (){
                    controller.googleLogin();
                    ///Gooogle click
                  },socialIcon: appGoogleIcon):Container(),
                  ///For Individual
                  controller.isCompanyProfile.value==false?_socialWidget():Container(),


                  SizedBox(height: 30,),
                  Container(
                    //margin: EdgeInsets.only(bottom: 30),
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
                                    //  controller.loginButtonClick();

                                    print("login page off");
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _termConditionsWidget(context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() => SizedBox(
            height: 14,
            width: 14,
            child: Checkbox(
              activeColor: appPrimaryColor,
              checkColor: appWhiteColor,
              side: BorderSide(color:appGreyBlackColor,width: 1 ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Set border radius to 4
              ),
              value: controller.isTermCheck.value,
              onChanged: (value) {
                controller.isTermCheck.value = !controller.isTermCheck.value;


              },
            ),
          )),
          SizedBox(width: 10,),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width*0.82,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: appGreyBlackColor), // Default text style
                children: [
                  TextSpan(
                    text:  appByCheckingYouAgreeTerms,
                    style: AppTextStyles.font14.copyWith(color: appGreyBlackColor), // Normal text style
                  ),
                  TextSpan(
                    text: appPrivacyPolicy,
                    style:  AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // controller.signUpButtonClick();
                        // Navigate to Terms of Use page or any action
                      },
                  ),
                  TextSpan(
                    text:  appOfCollarCheck,
                    style: AppTextStyles.font14.copyWith(color: appGreyBlackColor), // Normal text style
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
              Image.asset(socialIcon,height: 20,width: 20,),
              SizedBox(width: 10,),
              Text(socialName,  style: AppTextStyles.font16.copyWith(color: appBlackColor,)),
            ],
          )
      ),
    );
  }

  _socialWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _socialIconWidget(socialIcon: appGoogleNewSvg, onClick: () {
          controller.googleLogin();
        }),
        SizedBox(width: 20,),
        _socialIconWidget(socialIcon: appFacebookNewSvg, onClick: () {
          controller.facebookLogin();
        }),
        SizedBox(width: 20,),
        _socialIconWidget(socialIcon: appLinkdinNewSvg, onClick: () {
          controller.linkedinLogin();
        }),
        SizedBox(width: 20,),
        _socialIconWidget(socialIcon: appAppleNewSvg, onClick: () {  }),
      ],
    );
  }

  _socialIconWidget({required String socialIcon,required Function onClick}) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: appGreyBlackColor,width: 1.0)
        ),
        child: SvgPicture.asset(socialIcon,height: 40,width: 40,),
      ),
    );
  }




}