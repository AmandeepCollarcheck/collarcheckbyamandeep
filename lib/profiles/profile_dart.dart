import 'dart:io';

import 'package:collarchek/profiles/profile_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_methods.dart';
import 'package:collarchek/utills/common_widget/common_screen_header.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';

class ProfilePage extends GetView<ProfileControllers>{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                commonActiveSearchBar(
                    onClick: (){
                      controller.backButtonClick();
                    },
                    onShareClick: (){}, onFilterClick: (){}, leadingIcon: appBackSvgIcon, screenName: appBasicInformation, actionButton: ''),
                //SizedBox(height: 20,),
                _profileWidget(context),
                SizedBox(height: 20,),
                Container(
                  height: 1,
                  color: appPrimaryBackgroundColor,
                ),
                SizedBox(height: 20,),
                ///fIRST NAME lATS NAME
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            commonTextFieldTitle(headerName: appFirstName,isMendatory: true),
                            SizedBox(height: 5,),
                            commonTextField(controller: controller.firstNameController, hintText: appFirstName, validator: (value) => value!.isEmpty ? appFirstName+appIsRequired : null,),
                          ],
                        )
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                          child: Column(
                            children: <Widget>[
                              commonTextFieldTitle(headerName: appLastName,),
                              SizedBox(height: 5,),
                              commonTextField(controller: controller.lastNameController, hintText: appLastName, validator: (value) => value!.isEmpty ? appLastName+appIsRequired : null,),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ///eMAIL
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      Obx((){
                        var isVerify =controller.userProfileData.value.data?.emailVerified??"";
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
                               controller.verifyEmailIdApiCall();
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
                ),
                SizedBox(height: 10,),
                ///PHONE
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      Obx((){
                        var isVerify =controller.userProfileData.value.data?.phoneVerified??"";
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
                ),
                SizedBox(height: 10,),
                ///Date of Birh
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: Column(
                            children: <Widget>[
                              commonTextFieldTitle(headerName: appDateOfBirth,isMendatory: true),
                              SizedBox(height: 5,),
                              commonTextField(
                                controller: controller.dateOfBirthController,
                                hintText: appDateOfBirth,
                                validator: (value) => value!.isEmpty ? appDateOfBirth+appIsRequired : null,
                                isRealOnly: true,
                                onTap: (){
                                  selectDate(context,onSelectedDate: (String selectedDate) {
                                    controller.dateOfBirthController.text=selectedDate;
                                  });
                                }
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10,),
                      ///Accomodation
                      Flexible(
                          child: Column(
                            children: <Widget>[
                              commonTextFieldTitle(headerName: appAccomodationType,isMendatory: true),
                              SizedBox(height: 5,),
                              Obx((){
                                var accomodationdata=controller.allDropDownData.value.data?.accomodationList??[];
                                return accomodationdata!=null&&accomodationdata.isNotEmpty?customDropDown(
                                  hintText: appAccomodationType,
                                  item: [{'id':"0","name":appSelectAccomodation},
                                  ...accomodationdata.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                                  ],
                                  selectedValue: accomodationdata.any((datum)=>datum.id==controller.selectedAccodationType["id"])?controller.selectedAccodationType:{'id':"0","name":appSelectAccomodation},
                                  onChanged: (Map<String,dynamic>? selectedData) {
                                    controller.selectedAccodationType.value = {
                                      "id": selectedData?['id'].toString() ?? "0",
                                      "name": selectedData?['name'].toString() ?? appSelectAccomodation
                                    };
                                    controller.accomodationType.value=selectedData?['name'];
                                  },
                                  icon: appDropDownIcon,):Container();
                              }),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                ///cURRENT cOMPANY
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      ///Current Company
                      commonTextFieldTitle(headerName: appMyCurrentCompany,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var currentCompany=controller.allDropDownData.value.data?.companyList??[];
                        return currentCompany.isNotEmpty ? customDropDown(
                          hintText: appMyCurrentCompany,
                          item: [{"id": "0", "name": appSelectCompany},
                            ...currentCompany.map((datum) => {
                              "id": datum.id,
                              "name": datum.company,
                            })
                          ],
                          selectedValue: currentCompany.any((datum) => datum.id == controller.selectedCompany["id"]) ? controller.selectedCompany : {"id": "0", "name": appSelectCompany}, // Fallback if not found
                          onChanged: (Map<String, dynamic>? selectedData) {
                            if (selectedData != null) {
                              controller.selectedCompany.value = {
                                "id": selectedData?['id'].toString() ?? "0",
                                "name": selectedData?['name'].toString() ?? appSelectCompany
                              };

                              controller.myCurrentCompany.value = selectedData['name'];
                            }
                          },
                          icon: appDropDownIcon,
                        )
                            : Container();

                      }),
                      SizedBox(height: 10,),
                      ///Current Position
                      commonTextFieldTitle(headerName: appCurrentPosition,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var currentPosition=controller.allDropDownData.value.data?.designationList??[];
                        return currentPosition.isNotEmpty?customDropDown(
                          hintText: appCurrentPosition,
                          item: [{"id": "0", "name": appSelectPosition},
                            ...currentPosition.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                          ],
                          selectedValue: currentPosition.any((datum)=>datum.id==controller.selectedCurrentPosition["id"])?controller.selectedCurrentPosition: {"id": "0", "name": appSelectPosition},
                          onChanged: (Map<String,dynamic>? selectedData) {
                            controller.selectedCurrentPosition.value = {
                              "id": selectedData?['id'].toString() ?? "0",
                              "name": selectedData?['name'].toString() ?? appSelectPosition
                            };
                            controller.currentPosition.value=selectedData?['name'];
                          },
                          icon: appDropDownIcon,):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Work Status
                      commonTextFieldTitle(headerName: appWorkStatus,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var workStatus=controller.allDropDownData.value.data?.employementList??[];
                        return workStatus.isNotEmpty?customDropDown(
                          hintText: appWorkStatus,
                          item: [{'id':"0","name":appSelectWorkStatus},
                            ...workStatus.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? []
                          ],
                          selectedValue:workStatus.any((datum)=>datum.id==controller.selectedWorkStatus["id"])?controller.selectedWorkStatus:{'id':"0","name":appSelectWorkStatus},
                          onChanged: (Map<String,dynamic>? selectedData) {
                            controller.selectedWorkStatus.value = {
                              "id": selectedData?['id'].toString() ?? "0",
                              "name": selectedData?['name'].toString() ?? appSelectWorkStatus
                            };
                            controller.workStatus.value=selectedData?['name'];
                          },
                          icon: appDropDownIcon,):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Work Country Stata
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Column(
                                children: <Widget>[
                                  commonTextFieldTitle(headerName: appCountry,isMendatory: false),
                                  SizedBox(height: 5,),
                                  ///Country
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
                                        controller.getStateListApiCall(countryName: selectedData?['id']);
                                        controller.country.value=selectedData?['name'];
                                    }, icon: appDropDownIcon,):Container();
                                  })
                                ],
                              )
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            ///State
                              child: Column(
                                children: <Widget>[
                                  commonTextFieldTitle(headerName: appState,isMendatory: false),
                                  SizedBox(height: 5,),
                                  Obx((){
                                    var StateData=controller.stateListData.value.data??[];
                                    return StateData!=null&&StateData.isNotEmpty?customDropDown(
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
                                        controller.state.value=selectedData?['name'];
                                      },
                                      icon: appDropDownIcon,):Container();
                                  })
                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ///Residing City
                      commonTextFieldTitle(headerName: appResidingCity,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var residingCity=controller.cityListData.value.data??[];
                        return residingCity.isNotEmpty?customDropDown(
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
                            controller.residingCity.value=selectedData?['name'];
                          },
                          icon: appDropDownIcon,):Container();
                      }),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ///PresentAddress & Peramanent Address
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      ///Present Address
                      commonTextFieldTitle(headerName: appPresentAddress,isMendatory: true),
                      SizedBox(height: 5,),
                      commonTextField(controller: controller.presentController, hintText: appPresentAddress, validator: (value) => value!.isEmpty ? appPresentAddress+appIsRequired : null,maxLine: 5),
                      ///Paremanent Address
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          commonTextFieldTitle(headerName: appPermanentAddress,isMendatory: false),
                          Row(
                            children: <Widget>[
                              Obx(() => SizedBox(
                                height: 14,
                                width: 14,
                                child: Checkbox(
                                  activeColor: appPrimaryColor,
                                  checkColor: appWhiteColor,
                                  side: BorderSide(color:appPrimaryColor,width: 1 ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4), // Set border radius to 4
                                  ),
                                  value: controller.isSameAsCheck.value,
                                  onChanged: (value) {
                                    controller.isSameAsCheck.value = !controller.isSameAsCheck.value;
                                    controller.isPermanaentAddressSameAsPresentAddress();
                                  },
                                ),
                              )),
                              SizedBox(width: 5,),
                              Text(appSameAsPresent,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      commonTextField(controller: controller.permanentController, hintText: appPermanentAddress,maxLine: 5),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ///Resume
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      commonTextFieldTitle(headerName: appResume,isMendatory: true),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: (){
                          getFileFromGallery(context,onFilePickedData: (String pickedData) {
                            if(pickedData!=null){
                              controller.selectedResumeName.value=pickedData;
                            }
                          });
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                            color: appBlackColor,
                            strokeWidth: 1,
                          radius: Radius.circular(20),
                          child:Container(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(appUploadResume,height: 24,width: 24,),
                                  SizedBox(width: 10,),
                                  Text(appUpdateResume,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                ],
                              )
                          )
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(appSupportedFormats,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                      SizedBox(height: 10,),
                      Obx((){
                        return controller.selectedResumeName.value.isNotEmpty? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appPrimaryBackgroundColor
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Obx((){
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width*0.7,
                                    child: Text(controller.selectedResumeName.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                              }),
                              GestureDetector(
                                onTap:(){
                                  controller.selectedResumeName.value="";
                                   },
                                  child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                            ],
                          ),
                        ):Container();
                      })
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ///Profile Urls
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: <Widget>[
                      ///Linkdin
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
                      ///Tumblr
                      // commonTextFieldTitle(headerName: appTumblr,isMendatory: false),
                      // SizedBox(height: 5,),
                      // commonTextField(controller: controller.tumblrController, hintText: appTumblrProfileURL),
                      // SizedBox(height: 10,),
                      ///Discord
                      // commonTextFieldTitle(headerName: appDiscord,isMendatory: false),
                      // SizedBox(height: 5,),
                      // commonTextField(controller: controller.discordController, hintText: appDiscordProfileURL),
                      // SizedBox(height: 10,),
                      ///Twitter
                      commonTextFieldTitle(headerName: appTwitter,isMendatory: false),
                      SizedBox(height: 5,),
                      commonTextField(controller: controller.twitterController, hintText: appTwitterProfileURL),
                      SizedBox(height: 10,),
                      ///Zook
                      // commonTextFieldTitle(headerName: appZoom,isMendatory: false),
                      // SizedBox(height: 5,),
                      // commonTextField(controller: controller.zoomController, hintText: appZoomProfileURL),
                      // SizedBox(height: 10,),
                      // ///Snapshot
                      // commonTextFieldTitle(headerName: appSnapchat,isMendatory: false),
                      // SizedBox(height: 5,),
                      // commonTextField(controller: controller.snapshotController, hintText: appSnapchatProfileURL),
                      // SizedBox(height: 10,),
                    ],
                  ),
                ),
                ///Submit button
                SizedBox(height: 20,),
                commonButton(context,
                    buttonName: appSave,
                    buttonBackgroundColor: appPrimaryColor,
                    textColor: appWhiteColor,
                    buttonBorderColor: appPrimaryColor,
                    onClick: (){
                      controller.saveUserProfile(context);
                    }
                ),
                SizedBox(height: 30,),




              ],
            ),
          ),
        ),
      ),
    );
  }

  _profileWidget(context) {
    return Obx((){
      var profileImage=controller.userProfileData.value.data?.profile??"";
      if(controller.selectedImage.value!=null){
        profileImage=null;
      }

      var userFirstName=controller.userProfileData.value.data?.fname??"";
      var userLastName=controller.userProfileData.value.data?.lname??'';
      var userIndividualId=controller.userProfileData.value.data?.individualId??"";
      var isUserVerified=controller.userProfileData.value.data?.isVerified??false;
      return Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                profileImage!=null&&profileImage.isNotEmpty?ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(profileImage??"",height: 80,width: 80,fit: BoxFit.cover,),
                ):controller.selectedImage.value!=null?Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [controller.getRandomColor(),controller.getRandomColor()]
                      )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(controller.selectedImage.value!,height: 80,
                      width: 80,fit: BoxFit.cover,),
                  )
                ):Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [controller.getRandomColor(),controller.getRandomColor()]
                      )
                  ),
                  child: userFirstName.isNotEmpty?Text(getInitialsWithSpace(input: "$userFirstName $userLastName"??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)):Container(),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
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
                        child: SvgPicture.asset(appCameraSvgIcon,height: 30,width: 30,))
                ),
              ],

            ),
            SizedBox(width: 20,),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$userFirstName $userLastName",style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
                  Text("$appId: $userIndividualId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor)),
                  isUserVerified?Text("($appVerificationPending)",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor)):Container(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

}