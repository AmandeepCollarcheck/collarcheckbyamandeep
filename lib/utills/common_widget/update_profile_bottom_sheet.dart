
import 'dart:io';

import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:dio/dio.dart' as dio;
import '../../api_provider/api_provider.dart';
import '../../models/city_list_model.dart';
import '../../models/company_all_details_data.dart';
import '../../models/company_user_details_model.dart';
import '../../models/save_user_profile_model.dart';
import '../../models/state_list_model.dart';
import '../app_colors.dart';
import '../app_key_constent.dart';
import '../app_route.dart';
import '../app_strings.dart';
import '../font_styles.dart';
import '../image_path.dart';
import 'add_new_job_model_sheet.dart';
import 'common_methods.dart';
import 'common_text_field.dart';
import 'image_multipart.dart';
late ProgressDialog progressDialog=ProgressDialog() ;
final formKey = GlobalKey<FormState>();
var stateListData=StateListModel().obs;
var cityListData=CityListModel().obs;
var nameOfCompanyController = TextEditingController();
var websiteController = TextEditingController();
var officeLocationController = TextEditingController();
var linkedInController = TextEditingController();
var youtubeController = TextEditingController();
var instagramController = TextEditingController();
var facebookController = TextEditingController();
var twitterController = TextEditingController();
var aboutCompanyController = TextEditingController();
var contactPersonController = TextEditingController();
var emailController = TextEditingController();
var alternativeEmailController = TextEditingController();
var phoneController = TextEditingController();
var alternativePhoneController = TextEditingController();
var listTabLabel = [
  appBasic, appAddress, appSocialAccounts
].obs;
var selectedContactPersonDropDown={"id":"0","name": appSelectContactPerson}.obs;
var selectedIndustryTypeDropDown={"id":"0","name": appSelectIndustryType}.obs;
var selectedInCorporationYearDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
var selectedEstimatedTurnOverDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
var selectedEmployeesRangeDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
var selectedCountry={'id':"0","name":appSelectCountry}.obs;
var selectedState={'id':"0","name":appSelectState}.obs;
var selectedCity={'id':"0","name":appSelectCity}.obs;
var selectedIndex=0.obs;
var isEmailVerified=false.obs;
var isPhoneVerified=false.obs;
Rx isAlternativeEmail=false.obs;
Rx isAlternativePhone=false.obs;
var profileImageData="".obs;
var selectedImage = Rx<File?>(null);
var ccId="".obs;
var isVerified=false.obs;
var emailVerified="".obs;
var phoneVerified="".obs;




updateProfileBottomSheet(context,{required CompanyAllDetailsData companyAllDetails,required String screenName,required  CompanyUserDetailsModel companyUserDetails}) {

  updateProfileData(context, companyUserDetails: companyUserDetails,);


  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: appWhiteColor,
    context: context,
    builder: (BuildContext context) {
      return Wrap(
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
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(listTabLabel.length, (index) {
                      final isSelected = selectedIndex.value == index;
                      return GestureDetector(
                        onTap: () => selectedIndex.value = index,
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
                            listTabLabel[index],
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
                    child: Column(
                      children: <Widget>[
                        _updateProfileWidget(
                          context,
                          profileImage: profileImageData.value,
                          userName: nameOfCompanyController.text,
                        ),
                        const SizedBox(height: 20),
                        Container(height: 1,color: appPrimaryBackgroundColor,),
                        const SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              commonTextFieldTitle(headerName: appNameOfCompany,isMendatory: true),
                              SizedBox(height: 5,),
                              commonTextField(controller: nameOfCompanyController, hintText: appNameOfCompany, validator: (value) => value!.isEmpty ? appNameOfCompany+appIsRequired : null,),
                              SizedBox(height: 10,),
                              ///eMAIL
                              Column(
                                children: <Widget>[
                                  Obx((){
                                    var isVerify =emailVerified??"";
                                    if(isVerify=="1"){
                                      isEmailVerified.value=true;
                                    }else{
                                      isEmailVerified.value=false;
                                    }
                                    return  commonTextFieldTitleWithVerification(headerName: appEmailId,isMendatory: true,isVerify: isEmailVerified.value,onVerifyClick: (){

                                      Get.offNamed(AppRoutes.accountVerification);
                                      return showVerifyEmailWidget(
                                          context,
                                          controller: emailController,
                                          hintText: appRegisteredYourEmailId,
                                          onClickVerified: (String data) {
                                            // verifyEmailIdApiCall();
                                          });
                                    });
                                  }),
                                  SizedBox(height: 5,),
                                  commonTextField(controller: emailController, hintText: appEmailId, validator: (value) => value!.isEmpty ? appEmailId+appIsRequired : null,),
                                  Obx(()=>isAlternativeEmail.value?SizedBox(height: 10,):SizedBox(height: 5,),),
                                  Obx((){
                                    return isAlternativeEmail.value?commonTextField(controller: alternativeEmailController, hintText: appAlternativeEmail):GestureDetector(
                                      onTap: (){
                                        isAlternativeEmail.value=!isAlternativeEmail.value;
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
                                    var isVerify =phoneVerified??"";
                                    if(isVerify=="1"){
                                      isPhoneVerified.value=true;
                                    }else{
                                      isPhoneVerified.value=false;
                                    }
                                    return commonTextFieldTitleWithVerification(headerName: appPhone,isMendatory: true,isVerify: isPhoneVerified.value,onVerifyClick: (){},isMobile: true);

                                  }),
                                  SizedBox(height: 5,),
                                  commonTextField(controller: phoneController, hintText: appPhone, validator: (value) => value!.isEmpty ? appPhone+appIsRequired : null,),
                                  Obx(()=>isAlternativePhone.value?SizedBox(height: 10,):SizedBox(height: 5,),),
                                  Obx((){
                                    return isAlternativePhone.value?commonTextField(controller: alternativePhoneController, hintText: appAlternativePhone):GestureDetector(
                                      onTap: (){
                                        isAlternativePhone.value=!isAlternativePhone.value;
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
                              commonTextField(controller: websiteController, hintText: appWebsite,),
                              SizedBox(height: 10,),
                              ///About Company
                              commonTextFieldTitle(headerName: appAboutCompany,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: aboutCompanyController, hintText: appAboutCompany,maxLine: 4),
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
                              commonTextField(controller: contactPersonController, hintText: appContactPersonName,),
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
                                var industryTypeList=companyAllDetails.data?.industryList??[];

                                return industryTypeList!=null&&industryTypeList.isNotEmpty?customDropDown(
                                    hintText: appSelectDesignation,
                                    item: [{"id":"0","name": appSelectIndustryType},
                                      ...industryTypeList.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                    ],
                                    selectedValue: industryTypeList.any((datum)=>datum.id==selectedIndustryTypeDropDown["id"])?selectedIndustryTypeDropDown:{"id":"0","name": appSelectIndustryType},
                                    onChanged: (Map<String,dynamic>? selectedData){
                                      if(selectedData!=null){
                                        selectedIndustryTypeDropDown.value={
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
                                var incorporateYear=companyAllDetails.data?.industryList??[];

                                return incorporateYear!=null&&incorporateYear.isNotEmpty?customDropDown(
                                    hintText: appSelectDesignation,
                                    item: [{"id":"0","name": appSelectIncorporateYear},
                                      ...incorporateYear.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                    ],
                                    selectedValue: incorporateYear.any((datum)=>datum.id==selectedInCorporationYearDropDown["id"])?selectedInCorporationYearDropDown:{"id":"0","name": appSelectIncorporateYear},
                                    onChanged: (Map<String,dynamic>? selectedData){
                                      if(selectedData!=null){
                                        selectedInCorporationYearDropDown.value={
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
                                var estimatedTurnOver=companyAllDetails.data?.industryList??[];

                                return estimatedTurnOver!=null&&estimatedTurnOver.isNotEmpty?customDropDown(
                                    hintText: appSelectDesignation,
                                    item: [{"id":"0","name": appSelectEstimatedTurnOver},
                                      ...estimatedTurnOver.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                    ],
                                    selectedValue: estimatedTurnOver.any((datum)=>datum.id==selectedEstimatedTurnOverDropDown["id"])?selectedEstimatedTurnOverDropDown:{"id":"0","name": appSelectEstimatedTurnOver},
                                    onChanged: (Map<String,dynamic>? selectedData){
                                      if(selectedData!=null){
                                        selectedEstimatedTurnOverDropDown.value={
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
                                var employeeRange=companyAllDetails.data?.industryList??[];

                                return employeeRange!=null&&employeeRange.isNotEmpty?customDropDown(
                                    hintText: appSelectDesignation,
                                    item: [{"id":"0","name": appSelectEmployeeRange},
                                      ...employeeRange.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                    ],
                                    selectedValue: employeeRange.any((datum)=>datum.id==selectedEmployeesRangeDropDown["id"])?selectedEmployeesRangeDropDown:{"id":"0","name": appSelectEmployeeRange},
                                    onChanged: (Map<String,dynamic>? selectedData){
                                      if(selectedData!=null){
                                        selectedEmployeesRangeDropDown.value={
                                          "id": selectedData?['id'].toString() ?? "0",
                                          "name": selectedData?['name'].toString() ?? appSelectEmployeeRange
                                        };
                                      }
                                    },
                                    icon: appDropDownIcon
                                ):Container();
                              }),
                              SizedBox(height: 10,),
                              ///Work Country Stata
                              Obx((){
                                var countryData=companyAllDetails.data?.countryList??[];
                                return Column(
                                  children: <Widget>[
                                    commonTextFieldTitle(headerName: appCountry,isMendatory: false),
                                    SizedBox(height: 5,),
                                    customDropDown(
                                      hintText: appCountry,
                                      item: [{'id':"0","name":appSelectCountry},
                                        ...countryData.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                      ],
                                      selectedValue: countryData.any((datum)=>datum.id==selectedCountry["id"])?selectedCountry:{'id':"0","name":appSelectCountry},
                                      onChanged: (Map<String,dynamic>? selectedData) {
                                        selectedCountry.value = {
                                          "id": selectedData?['id'].toString() ?? "0",
                                          "name": selectedData?['name'].toString() ?? appSelectCountry
                                        };
                                        getStateListApiCall(countryName: selectedData?['id']);
                                      }, icon: appDropDownIcon,)

                                  ],
                                );
                              }),
                              SizedBox(width: 10,),
                              ///Stata
                              Obx((){
                                var StateData=stateListData.value.data??[];
                                return StateData.isNotEmpty?Column(
                                  children: <Widget>[
                                    commonTextFieldTitle(headerName: appState,isMendatory: false),
                                    SizedBox(height: 5,),
                                    customDropDown(
                                      hintText: appAccomodationType,
                                      item:[{'id':"0","name":appSelectState},
                                        ...StateData.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                      ],
                                      selectedValue:StateData.any((datum)=>datum.id==selectedState["id"])?selectedState:{'id':"0","name":appSelectState},
                                      onChanged: (Map<String,dynamic>? selectedData) {
                                        selectedState.value = {
                                          "id": selectedData?['id'].toString() ?? "0",
                                          "name": selectedData?['name'].toString() ?? appSelectState
                                        };
                                        getCityListApiCall(stateName:  selectedData?['id']);

                                      },
                                      icon: appDropDownIcon,)
                                  ],
                                ):Container();
                              }),
                              SizedBox(height: 10,),
                              ///City
                              Obx((){
                                var residingCity=cityListData.value.data??[];
                                return residingCity.isNotEmpty?Column(
                                  children: <Widget>[
                                    commonTextFieldTitle(headerName: appResidingCity,isMendatory: false),
                                    SizedBox(height: 5,),
                                    customDropDown(
                                      hintText: appResidingCity,
                                      item: [{'id':"0","name":appSelectCity},
                                        ...residingCity.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                      ],
                                      selectedValue: residingCity.any((detum)=>detum.id==selectedCity["id"])?selectedCity:{'id':"0","name":appSelectCity},
                                      onChanged: (Map<String,dynamic>? selectedData) {
                                        selectedCity.value = {
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
                              commonTextField(controller: officeLocationController, hintText: appOfficeLocation,maxLine: 4),
                              SizedBox(height: 10,),
                              ///Linkdin
                              commonTextFieldTitle(headerName: appLinkedIn,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: linkedInController, hintText: appLinkedInProfileURL),
                              SizedBox(height: 10,),
                              ///Youtube
                              commonTextFieldTitle(headerName: appYoutube,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: youtubeController, hintText: appYoutubeProfileURL),
                              SizedBox(height: 10,),

                              ///Instagram
                              commonTextFieldTitle(headerName: appInstagram,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: instagramController, hintText: appInstagramProfileURL),
                              SizedBox(height: 10,),
                              ///Facebook

                              commonTextFieldTitle(headerName: appFacebook,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: facebookController, hintText: appFacebookProfileURL),
                              SizedBox(height: 10,),
                              ///Twitter
                              commonTextFieldTitle(headerName: appTwitter,isMendatory: false),
                              SizedBox(height: 5,),
                              commonTextField(controller: twitterController, hintText: appTwitterProfileURL),
                              SizedBox(height: 10,),
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
                              validateAllTextFiled(context);
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
      );
    },
  );
}

void validateAllTextFiled(context) {
  keyboardDismiss(context);
  if(nameOfCompanyController.text==null||nameOfCompanyController.text.isEmpty){
    showToast(appPleaseNameOfCompany);
  }else if(emailController.text==null||emailController.text.isEmpty){
    showToast(appPleaseEnterValidName);
  }else if(phoneController.text==null||phoneController.text.isEmpty){
    showToast(appPleaseEnterValidPhone);
  }else if(contactPersonController.text==null||contactPersonController.text.isEmpty){
    showToast(appPleaseEnterContactPersonName);
  }else if(isInvalidSelection(selectedIndustryTypeDropDown.value, appSelectIndustryType)){
    showToast(appSelectIndustryType);
  }else{
    _updateProfileDetails(context);
  }
}

void _updateProfileDetails(context) async{
  try{
    progressDialog.show();
    var selectedImageFile = await convertFileToMultipart(selectedImage.value?.path??"");
    var formData = dio.FormData.fromMap({
      "company_name": nameOfCompanyController.text??"",
      "contact_person": contactPersonController.text??"",
      "email": emailController.text??"",
      "phone": phoneController.text??"",
      "slug": null,
      "incorporate_date": selectedInCorporationYearDropDown.value['name'],
      "turnover": selectedEstimatedTurnOverDropDown.value['name'],
      "linkdin": linkedInController.text??"",
      "youtube": youtubeController.text??"",
      "instagram": instagramController.text??"",
      "facebook": facebookController.text??"",
      "twitter": twitterController.text??"",
      "present_address": officeLocationController.text??"",
      "profile_description": aboutCompanyController.text??"",
      "website": websiteController.text??"",
      "country": selectedCountry.value['id'],
      "state": selectedState.value['id'],
      "city": selectedCity.value['id'],
      "industry": selectedIndustryTypeDropDown.value['id'],
      "profile": selectedImageFile
    });
    SaveUserProfileModel saveUserProfileModel = await ApiProvider.baseWithToken().companyUpdateProfile(formData);
    if(saveUserProfileModel.status==true){
      progressDialog.dismissLoader();
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else{
      showToast(saveUserProfileModel.messages??"");
    }
    progressDialog.dismissLoader();
  }on HttpException catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.message);
  } catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.toString());
  }
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
                    selectedImage.value=cameraCapturedImage;
                  }
                }, onGalleryCapturedData: (File galleryCaptureImage) {
                  if(galleryCaptureImage.path!=null&&galleryCaptureImage.path.isNotEmpty){
                    selectedImage.value=galleryCaptureImage;
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
              child: Text(nameOfCompanyController.text,style: AppTextStyles.font20W700.copyWith(color: appBlackColor),)),
          Row(
            children: <Widget>[
              Text("$appId: ${ccId.value} ",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
              SvgPicture.asset(appCCIDSvg,height: 14,width: 14,)
            ],
          ),
          isVerified.value?Container():Text("($appVerificationPending)",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),),
        ],
      )
    ],
  );
}
///State list Api
void getStateListApiCall({required String countryName}) async{
  try {
    progressDialog.show();
    StateListModel stateListModel = await ApiProvider.base().stateList(countryName: countryName);
    if(stateListModel.status==true){
      stateListData.value.data?.clear();
      stateListData.value=stateListModel;
      if(stateListData.value.data!=null&&stateListData.value.data!.isNotEmpty){
        progressDialog.dismissLoader();
      }
    }else{
      showToast(somethingWentWrong);
    }
    progressDialog.dismissLoader();
  } on HttpException catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.message);
  } catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.toString());
  }
}
///City list api
void getCityListApiCall({required String stateName}) async{
  try {
    progressDialog.show();
    CityListModel cityListModel = await ApiProvider.base().cityList(stateName: stateName);
    if(cityListModel.status==true){
      cityListData.value.data?.clear();
      cityListData.value=cityListModel;
    }else{
      showToast(somethingWentWrong);
    }
    progressDialog.dismissLoader();
  } on HttpException catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.message);
  } catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.toString());
  }

}

updateProfileData(context,{required  CompanyUserDetailsModel companyUserDetails}){
  progressDialog.show();
  profileImageData.value=companyUserDetails.data?.profile??"";
  ccId.value=companyUserDetails.data?.individualId??"";
  isVerified.value=companyUserDetails.data?.isVerified??false;
  emailVerified.value=companyUserDetails.data?.emailVerified??"";
  phoneVerified.value=companyUserDetails.data?.phoneVerified??"";
  selectedIndustryTypeDropDown.value={
    "id":companyUserDetails.data?.industry??"0",
    "name": companyUserDetails.data?.industryName??appSelectIndustryType
  };
  selectedInCorporationYearDropDown.value={
    "id":companyUserDetails.data?.incorporateDate??"0",
    "name": companyUserDetails.data?.incorporateDate??appSelectIncorporateYear
  };
  selectedEstimatedTurnOverDropDown.value={
    "id":companyUserDetails.data?.turnover??"0",
    "name": companyUserDetails.data?.turnoverName??appSelectEstimatedTurnOver
  };
  selectedEmployeesRangeDropDown.value={
    "id":companyUserDetails.data?.companySize??"0",
    "name": companyUserDetails.data?.companySizeName??appSelectEmployeeRange
  };
   selectedCountry.value={
     'id':companyUserDetails.data?.country??"0",
     "name":companyUserDetails.data?.countryName??appSelectCountry
   };
   selectedState.value={
     'id':companyUserDetails.data?.state??"0",
     "name":companyUserDetails.data?.stateName??appSelectState
   };
   selectedCity.value={
     'id':companyUserDetails.data?.city??"0",
     "name":companyUserDetails.data?.cityName??appSelectCity
   };
  nameOfCompanyController.text=companyUserDetails.data?.companyName??"";
  emailController.text=companyUserDetails.data?.email??"";
  alternativeEmailController.text=companyUserDetails.data?.emailAlternate??"";
  phoneController.text=companyUserDetails.data?.phone??"";
  alternativePhoneController.text=companyUserDetails.data?.secondPhone??"";
  websiteController.text=companyUserDetails.data?.website??"";
  aboutCompanyController.text=companyUserDetails.data?.description??"";
  contactPersonController.text=companyUserDetails.data?.contactPerson??"";
  officeLocationController.text=companyUserDetails.data?.presentAddress??"";
  linkedInController.text=companyUserDetails.data?.linkdin??"";
  youtubeController.text=companyUserDetails.data?.youtube??"";
  instagramController.text=companyUserDetails.data?.instagram??"";
  twitterController.text=companyUserDetails.data?.twitter??"";
  progressDialog.dismissLoader();
}