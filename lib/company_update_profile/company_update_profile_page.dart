import 'dart:io';

import 'package:collarchek/company_update_profile/company_update_profile_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_image_widget.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class CompanyUpdateProfilePage extends GetView<CompanyUpdateProfileControllers>{
  const CompanyUpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                appBackIconSvg,
                                height: 12,
                                width: 12,
                                color: appBlackColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              appUpdateYourProfiles,
                              style: AppTextStyles.font20w600.copyWith(color: appBlackColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(() => SingleChildScrollView(
                          controller: controller.scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(controller.listTabLabel.length, (index) {
                              final isSelected = controller.selectedIndex.value == index;
                              return GestureDetector(
                                //onTap: () => selectedIndex.value = index,
                                onTap: () {
                                  controller.selectedIndex.value = index;
                                  controller.scrollToSection(index);
                                },

                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isSelected ? appPrimaryColor : appPrimaryBackgroundColor,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    controller.listTabLabel[index],
                                    style: AppTextStyles.font14.copyWith(
                                      color: isSelected ? appPrimaryColor : appBlackColor,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.64,
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              children: <Widget>[
                                _updateProfileWidget(
                                  context,
                                  profileImage: controller.profileImageData.value,
                                  userName: controller.nameOfCompanyController.text,
                                ),
                                const SizedBox(height: 20),
                                Container(height: 1,color: appPrimaryBackgroundColor,),
                                const SizedBox(height: 20),
                                Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        key: controller.sectionKeys[0],
                                        child: Column(
                                          children: <Widget>[
                                            commonTextFieldTitle(headerName: appNameOfCompany,isMendatory: true),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.nameOfCompanyController, hintText: appNameOfCompany, validator: (value) => value!.isEmpty ? appNameOfCompany+appIsRequired : null,),
                                            SizedBox(height: 10,),
                                            ///eMAIL
                                            Column(
                                              children: <Widget>[
                                                Obx((){
                                                  var isVerify =controller.emailVerified??"";
                                                  if(isVerify=="1"){
                                                    controller.isEmailVerified.value=true;
                                                  }else{
                                                    controller.isEmailVerified.value=false;
                                                  }
                                                  return  commonTextFieldTitleWithVerification(headerName: appEmailId,isMendatory: true,isVerify: controller.isEmailVerified.value,onVerifyClick: (){

                                                    Get.offNamed(AppRoutes.accountVerification);
                                                    return showVerifyEmailWidget(
                                                        context,
                                                        controller: controller.emailController,
                                                        hintText: appRegisteredYourEmailId,
                                                        onClickVerified: (String data) {
                                                          // verifyEmailIdApiCall();
                                                        });
                                                  });
                                                }),
                                                SizedBox(height: 5,),
                                                commonTextField(controller: controller.emailController, hintText: appEmailId, validator: (value) => value!.isEmpty ? appEmailId+appIsRequired : null,),
                                                Obx(()=>controller.isAlternativeEmail.value?SizedBox(height: 10,):SizedBox(height: 5,),),
                                                Obx((){
                                                  return controller.isAlternativeEmail.value?commonTextField(controller: controller.alternativeEmailController, hintText: appAlternativeEmail):GestureDetector(
                                                    onTap: (){
                                                      controller.isAlternativeEmail.value=!controller.isAlternativeEmail.value;
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.topRight,
                                                      child: Text("+ $appAlternativeEmail",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                                    ),
                                                  );
                                                }),

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            ///PHONE
                                            Column(
                                              children: <Widget>[
                                                Obx((){
                                                  var isVerify =controller.phoneVerified??"";
                                                  if(isVerify=="1"){
                                                    controller.isPhoneVerified.value=true;
                                                  }else{
                                                    controller.isPhoneVerified.value=false;
                                                  }
                                                  return commonTextFieldTitleWithVerification(headerName: appPhone,isMendatory: true,isVerify: controller.isPhoneVerified.value,onVerifyClick: (){},isMobile: true);

                                                }),
                                                SizedBox(height: 5,),
                                                commonTextField(controller: controller.phoneController, hintText: appPhone, validator: (value) => value!.isEmpty ? appPhone+appIsRequired : null,),
                                                Obx(()=>controller.isAlternativePhone.value?SizedBox(height: 10,):SizedBox(height: 5,),),
                                                Obx((){
                                                  return controller.isAlternativePhone.value?commonTextField(controller: controller.alternativePhoneController, hintText: appAlternativePhone):GestureDetector(
                                                    onTap: (){
                                                      controller.isAlternativePhone.value=!controller.isAlternativePhone.value;
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.topRight,
                                                      child: Text("+ $appAlternativePhone",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                                    ),
                                                  );
                                                }),

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            ///Website
                                            commonTextFieldTitle(headerName: appWebsite,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.websiteController, hintText: appWebsite,),
                                            SizedBox(height: 10,),
                                            ///About Company
                                            commonTextFieldTitle(headerName: appAboutCompany,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.aboutCompanyController, hintText: appAboutCompany,maxLine: 4),
                                            SizedBox(height: 3,),
                                            Row(
                                              children: <Widget>[
                                                SvgPicture.asset(appAISvg,height: 16,width: 16,),
                                                Text(appReWriteWithAi,style: AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            ///Contact Person
                                            commonTextFieldTitle(headerName: appContactPersonName,isMendatory: true),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.contactPersonController, hintText: appContactPersonName,),
                                            // Obx((){
                                            //   var contactPerson=companyAllDetails.data?.industryList??[];
                                            //
                                            //   return contactPerson!=null&&contactPerson.isNotEmpty?customDropDown(
                                            //       hintText: appSelectDesignation,
                                            //       item: [{"id":"0","name": appSelectContactPerson},
                                            //         ...contactPerson.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                            //       ],
                                            //       selectedValue: contactPerson.any((datum)=>datum.id==selectedContactPersonDropDown["id"])?selectedContactPersonDropDown:{"id":"0","name": appSelectContactPerson},
                                            //       onChanged: (Map<String,dynamic>? selectedData){
                                            //         if(selectedData!=null){
                                            //           selectedContactPersonDropDown.value={
                                            //             "id": selectedData?['id'].toString() ?? "0",
                                            //             "name": selectedData?['name'].toString() ?? appSelectIndustryType
                                            //           };
                                            //         }
                                            //       },
                                            //       icon: appDropDownIcon
                                            //   ):Container();
                                            // }),
                                            SizedBox(height: 10,),
                                            ///Industry Type
                                            commonTextFieldTitle(headerName: appIndustryType,isMendatory: true),
                                            SizedBox(height: 5,),
                                            Obx((){
                                              var industryTypeList=controller.companyAllDetails.value.data?.industryList??[];

                                              return industryTypeList!=null&&industryTypeList.isNotEmpty?customDropDown(
                                                  hintText: appSelectDesignation,
                                                  item: [{"id":"0","name": appSelectIndustryType},
                                                    ...industryTypeList.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                                  ],
                                                  selectedValue: industryTypeList.any((datum)=>datum.id==controller.selectedIndustryTypeDropDown["id"])?controller.selectedIndustryTypeDropDown:{"id":"0","name": appSelectIndustryType},
                                                  onChanged: (Map<String,dynamic>? selectedData){
                                                    if(selectedData!=null){
                                                      controller.selectedIndustryTypeDropDown.value={
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectIndustryType
                                                      };
                                                    }
                                                  },
                                                  icon: appDropDownIcon
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                            ///IncorporateYear
                                            commonTextFieldTitle(headerName: appIncorporationYear,isMendatory: false),
                                            SizedBox(height: 5,),
                                            Obx((){
                                              var incorporateYear=controller.companyAllDetails.value.data?.industryList??[];

                                              return incorporateYear!=null&&incorporateYear.isNotEmpty?customDropDown(
                                                  hintText: appSelectDesignation,
                                                  item: [{"id":"0","name": appSelectIncorporateYear},
                                                    ...incorporateYear.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                                  ],
                                                  selectedValue: incorporateYear.any((datum)=>datum.id==controller.selectedInCorporationYearDropDown["id"])?controller.selectedInCorporationYearDropDown:{"id":"0","name": appSelectIncorporateYear},
                                                  onChanged: (Map<String,dynamic>? selectedData){
                                                    if(selectedData!=null){
                                                      controller.selectedInCorporationYearDropDown.value={
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectIncorporateYear
                                                      };
                                                    }
                                                  },
                                                  icon: appDropDownIcon
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                            ///Estimated turnover
                                            commonTextFieldTitle(headerName: appEstimatedTurnOver,isMendatory: false),
                                            SizedBox(height: 5,),
                                            Obx((){
                                              var estimatedTurnOver=controller.companyAllDetails.value.data?.industryList??[];

                                              return estimatedTurnOver!=null&&estimatedTurnOver.isNotEmpty?customDropDown(
                                                  hintText: appSelectDesignation,
                                                  item: [{"id":"0","name": appSelectEstimatedTurnOver},
                                                    ...estimatedTurnOver.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                                  ],
                                                  selectedValue: estimatedTurnOver.any((datum)=>datum.id==controller.selectedEstimatedTurnOverDropDown["id"])?controller.selectedEstimatedTurnOverDropDown:{"id":"0","name": appSelectEstimatedTurnOver},
                                                  onChanged: (Map<String,dynamic>? selectedData){
                                                    if(selectedData!=null){
                                                      controller.selectedEstimatedTurnOverDropDown.value={
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectEstimatedTurnOver
                                                      };
                                                    }
                                                  },
                                                  icon: appDropDownIcon
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                            ///Employee range
                                            commonTextFieldTitle(headerName: appEmployeeRange,isMendatory: false),
                                            SizedBox(height: 5,),
                                            Obx((){
                                              var employeeRange=controller.companyAllDetails.value.data?.industryList??[];

                                              return employeeRange!=null&&employeeRange.isNotEmpty?customDropDown(
                                                  hintText: appSelectDesignation,
                                                  item: [{"id":"0","name": appSelectEmployeeRange},
                                                    ...employeeRange.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                                  ],
                                                  selectedValue: employeeRange.any((datum)=>datum.id==controller.selectedEmployeesRangeDropDown["id"])?controller.selectedEmployeesRangeDropDown:{"id":"0","name": appSelectEmployeeRange},
                                                  onChanged: (Map<String,dynamic>? selectedData){
                                                    if(selectedData!=null){
                                                      controller.selectedEmployeesRangeDropDown.value={
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectEmployeeRange
                                                      };
                                                    }
                                                  },
                                                  icon: appDropDownIcon
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      ),
                                      ///Work Country Stata
                                      Container(
                                        key: controller.sectionKeys[1],
                                        child: Column(
                                          children: <Widget>[
                                            Obx((){
                                              var countryData=controller.companyAllDetails.value.data?.countryList??[];
                                              return Column(
                                                children: <Widget>[
                                                  commonTextFieldTitle(headerName: appCountry,isMendatory: false),
                                                  SizedBox(height: 5,),
                                                  customDropDown(
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
                                                      controller.getStateListApiCall(countryName: selectedData?['id']);
                                                    }, icon: appDropDownIcon,)

                                                ],
                                              );
                                            }),
                                            SizedBox(width: 10,),
                                            ///Stata
                                            Obx((){
                                              var StateData=controller.stateListData.value.data??[];
                                              return StateData.isNotEmpty?Column(
                                                children: <Widget>[
                                                  commonTextFieldTitle(headerName: appState,isMendatory: false),
                                                  SizedBox(height: 5,),
                                                  customDropDown(
                                                    hintText: appAccomodationType,
                                                    item:[{'id':"0","name":appSelectState},
                                                      ...StateData.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                                    ],
                                                    selectedValue:StateData.any((datum)=>datum.id==controller.selectedState["id"])?controller.selectedState:{'id':"0","name":appSelectState},
                                                    onChanged: (Map<String,dynamic>? selectedData) {
                                                      controller.selectedState.value = {
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectState
                                                      };
                                                      controller.getCityListApiCall(stateName:  selectedData?['id']);

                                                    },
                                                    icon: appDropDownIcon,)
                                                ],
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                            ///City
                                            Obx((){
                                              var residingCity=controller.cityListData.value.data??[];
                                              return residingCity.isNotEmpty?Column(
                                                children: <Widget>[
                                                  commonTextFieldTitle(headerName: appResidingCity,isMendatory: false),
                                                  SizedBox(height: 5,),
                                                  customDropDown(
                                                    hintText: appResidingCity,
                                                    item: [{'id':"0","name":appSelectCity},
                                                      ...residingCity.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                                    ],
                                                    selectedValue: residingCity.any((detum)=>detum.id==controller.selectedCity["id"])?controller.selectedCity:{'id':"0","name":appSelectCity},
                                                    onChanged: (Map<String,dynamic>? selectedData) {
                                                      controller.selectedCity.value = {
                                                        "id": selectedData?['id'].toString() ?? "0",
                                                        "name": selectedData?['name'].toString() ?? appSelectCity
                                                      };

                                                    },
                                                    icon: appDropDownIcon,)
                                                ],
                                              ):Container();
                                            }),
                                            SizedBox(height: 10,),
                                            ///Office location
                                            commonTextFieldTitle(headerName: appOfficeLocation,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.officeLocationController, hintText: appOfficeLocation,maxLine: 4),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      ),
                                      ///Linkdin
                                      Container(
                                        key: controller.sectionKeys[2],
                                        child: Column(
                                          children: <Widget>[
                                            commonTextFieldTitle(headerName: appLinkedIn,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.linkedInController, hintText: appLinkedInProfileURL),
                                            SizedBox(height: 10,),
                                            ///Youtube
                                            commonTextFieldTitle(headerName: appYoutube,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.youtubeController, hintText: appYoutubeProfileURL),
                                            SizedBox(height: 10,),

                                            ///Instagram
                                            commonTextFieldTitle(headerName: appInstagram,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.instagramController, hintText: appInstagramProfileURL),
                                            SizedBox(height: 10,),
                                            ///Facebook

                                            commonTextFieldTitle(headerName: appFacebook,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.facebookController, hintText: appFacebookProfileURL),
                                            SizedBox(height: 10,),
                                            ///Twitter
                                            commonTextFieldTitle(headerName: appTwitter,isMendatory: false),
                                            SizedBox(height: 5,),
                                            commonTextField(controller: controller.twitterController, hintText: appTwitterProfileURL),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                commonButton(
                                    context,
                                    isPaddingDisabled: true,
                                    buttonName: appSave,
                                    buttonBackgroundColor: appPrimaryColor,
                                    textColor: appWhiteColor,
                                    buttonBorderColor: appPrimaryColor,
                                    onClick: (){
                                      controller.validateAllTextFiled(context);
                                    }
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateProfileWidget(context,{required String profileImage,required String userName}) {
    return Row(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            commonImageWidget(image: profileImage, initialName: userName, height: 100, width: 100, borderRadius: 14),
            Positioned(
                bottom: -6,
                right: -6,
                child: GestureDetector(
                  onTap: (){
                    openCameraOrGallery(context, onCameraCapturedData: (File cameraCapturedImage ) {
                      if(cameraCapturedImage.path!=null&&cameraCapturedImage.path.isNotEmpty){
                        controller.selectedImage.value=cameraCapturedImage;
                      }
                    }, onGalleryCapturedData: (File galleryCaptureImage) {
                      if(galleryCaptureImage.path!=null&&galleryCaptureImage.path.isNotEmpty){
                        controller.selectedImage.value=galleryCaptureImage;
                      }
                    });
                  },
                  child: commonImageWidget(image: appCameraIconSvg, initialName: "", height: 30, width: 30, borderRadius: 100),
                )
            )
          ],
        ),
        SizedBox(width: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width*0.56,
                child: Text(controller.nameOfCompanyController.text,style: AppTextStyles.font20W700.copyWith(color: appBlackColor),)),
            Row(
              children: <Widget>[
                Text("$appId: ${controller.ccId.value} ",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                SvgPicture.asset(appCCIDSvg,height: 14,width: 14,)
              ],
            ),
            controller.isVerified.value?Container():Text("($appVerificationPending)",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),),
          ],
        )
      ],
    );
  }

}