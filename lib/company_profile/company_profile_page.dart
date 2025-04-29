import 'package:collarchek/company_profile/company_profile_controllers.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:scroll_to_animate_tab/scroll_to_animate_tab.dart';
import '../models/company_profile_details_model.dart';
import '../utills/app_colors.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/image_path.dart';

class CompanyProfilePage extends GetView<CompanyProfileControllers>{
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: PopScope(
          canPop: false, // Prevents default back behavior
          onPopInvoked: (didPop) {
            if (!didPop) {
              onWillPop();
            }
          },
          child: Scaffold(
            backgroundColor: appScreenBackgroundColor,
            body: Column(
              children: <Widget>[
                Expanded(
                    child: NestedScrollView(
                        controller: controller.scrollController,
                        headerSliverBuilder: (contextData, innerBoxIsScrolled) {
                          return [
                            SliverToBoxAdapter(
                              child: Container(
                                color: appScreenBackgroundColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      height:60,
                                      child: commonAppBarWithSettingAndShareOption(context,
                                        leadingIcon: appBackSvgIcon,
                                        onClick: () {},
                                        onSettingsClick: () {},
                                      ),
                                    ),
                                    Container(
                                      child: _profileWidget(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ];
                        },
                        // body:ScrollToAnimateTab(
                        //     activeTabDecoration: TabDecoration(
                        //         textStyle: AppTextStyles.font14.copyWith(
                        //           color:  appPrimaryColor,
                        //           fontWeight:  FontWeight.bold,
                        //         ),
                        //         decoration: BoxDecoration(
                        //             // border: Border.all(color: Colors.black),
                        //             // borderRadius: const BorderRadius.all(Radius.circular(5))
                        //         )
                        //     ),
                        //     inActiveTabDecoration: TabDecoration(
                        //         textStyle: AppTextStyles.font14.copyWith(
                        //           color:  appBlackColor,
                        //           fontWeight:  FontWeight.normal,
                        //         ),
                        //         decoration: BoxDecoration(
                        //             // border: Border.all(color: Colors.black12),
                        //             // borderRadius: const BorderRadius.all(Radius.circular(5))
                        //         )
                        //     ),
                        //     tabs: [
                        //       ScrollableList(
                        //           label: appAbout,
                        //           body: _homeWidgetTabView(context)
                        //       ),
                        //       ScrollableList(
                        //           label: appJobOpening,
                        //           body: _jobOpeningTabView(context)
                        //       ),
                        //       ScrollableList(
                        //           label: appGallery,
                        //           body: _galleryWidget(context)
                        //       ),
                        //       ScrollableList(
                        //           label: appPerksAndBenefits,
                        //           body: Container(
                        //             child: Text("asj"),
                        //           )
                        //       ),
                        //       ScrollableList(
                        //           label: appSimilarCompanies,
                        //           body: _similarCompanyWidget(context)
                        //       ),
                        //       ScrollableList(
                        //           label: appEmployeeProfiles,
                        //           body:_simillerProfileWidget(context)
                        //       ),
                        //     ]
                        // )

                        body:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Container(height: 1, color: appPrimaryBackgroundColor),
                            ///Custom tab
                            Obx((){
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(controller.listTabLabel.length, (index) {
                                    final isSelected = controller.selectedIndex.value == index;

                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectedIndex.value = index;
                                        controller.scrollToSection(index);

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: isSelected ? appPrimaryColor : appPrimaryBackgroundColor,
                                              width:  isSelected ?2:1,
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
                              );
                            }),

                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Obx((){
                                  var allData=controller.companyProfileData.value.data;
                                  var benefitsData=allData?.allBenefits??[];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _childWithKey(controller.homeKey, _homeWidgetTabView(context)),
                                      _childWithKey(controller.jobOpeningKey, _jobOpeningTabView(context)),
                                      _childWithKey(controller.galleryKey, _galleryWidget(context)),
                                      _childWithKey(controller.benifits, _perksAndBebefitsWidget(context, allBenefits: benefitsData??[])),
                                      _childWithKey(controller.companyKey, _similarCompanyWidget(context)),
                                      _childWithKey(controller.similerProfile, _simillerProfileWidget(context)),

                                    ],
                                  );
                                }),),
                            ),





                          ],
                        )

                    )
                )
              ],
            ),
          ),
        )
    );
  }
  _perksAndBebefitsWidget(context,{required List allBenefits}){
    List<List> chunks = [];

    for (int i = 0; i < allBenefits.length; i += 2) {
      int end = (i + 2 < allBenefits.length) ? i + 2 : allBenefits.length;
      chunks.add(allBenefits.sublist(i, end));
    }
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      decoration: BoxDecoration(
          border: Border.all(color: appPrimaryBackgroundColor,width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(appPerksAndBenefits,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(AppRoutes.companyBenefit,arguments: {screenName:companyProfileScreen});
                  },
                  child: SvgPicture.asset(appEditIcon,height: 20,width: 20,),
                )
              ],
            ),
          ),
          Container(height: 1,color: appPrimaryBackgroundColor,),
          chunks.isNotEmpty?Column(
            children: List.generate(chunks.length, (rowIndex) {
              List rowItems = chunks[rowIndex];
              return Row(
                children: List.generate(rowItems.length, (index) {
                  var item = rowItems[index];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Row(
                        children: [
                          commonImageWidget(
                              image: item.image,
                              initialName: item.name,
                              height: 30,
                              width: 30,
                              borderRadius: 0,
                              isBorderDisable: true
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              item.name ?? "",
                              style: AppTextStyles.font14.copyWith(color: appBlackColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
          ):Container(
            child: noDataAvailableFoundWidget(context, header: appGallery, details: appNoGalleryData),
          )
        ],
      ),
    );
  }






  _profileWidget(BuildContext context) {
    return  Obx((){
      var profileData=controller.companyProfileData.value.data;
      if (profileData == null) {
        return Container();
      }
      var isProfileVerified=profileData.isVerified??false;
      var location=generateLocation(cityName: profileData.cityName??"", stateName: profileData.stateName??"", countryName: profileData.countryName??"");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [appPrimaryColor,appBlueColor])
                ),
              ),
              Positioned(
                  top: 40,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: commonImageWidget(
                        image: profileData.profile??"",
                        initialName: profileData.companyName??"",
                        height: 100, width: 100, borderRadius: 14
                    ),
                  )
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.font20W700.copyWith(color: appBlackColor),
                    children: [
                      TextSpan(
                        text: profileData.companyName??"",
                      ),
                      if (isProfileVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: SvgPicture.asset(
                              appVerifiedIcon,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("$appId: ${profileData.individualId??""}",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),maxLines: 1,),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    profileData.totalEmployee!=0?Row(
                      children: <Widget>[
                        SvgPicture.asset(appMyConnectionIconSvg,height: 16,width: 16,color: appBlackColor,),
                        SizedBox(width: 4,),
                        Text("${profileData.totalEmployee??""} ${profileData.totalEmployee.toString()=="1"?appEmployee:appEmployees}",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                      ],
                    ):Container(),
                    SizedBox(width: 8,),
                    profileData.totalEmployee!=0&&profileData.followData?.follower!=0?Container(
                      margin: EdgeInsets.only(top: 2),
                      height: 18,width: 1,color: appGreyBlackColor,):Container(),
                    SizedBox(width: 5,),
                    profileData.followData?.follower!=0?Row(
                      children: <Widget>[
                        Text("${profileData.followData?.follower} $appFollowerText",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                      ],
                    ):Container(),
                  ],
                ),
                profileData.industryName!=null&&profileData.industryName!.isNotEmpty?SizedBox(height: 4,):SizedBox(height: 0,),
                profileData.industryName!=null&&profileData.industryName!.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appDesignationSvgIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text(profileData.industryName??"",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ):Container(),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appEmail,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text(profileData.email??"",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appPhoneIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text(profileData.phone??"",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
                SizedBox(height: 4,),
                 location.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appLocationsSvgIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text(location),
                  ],
                ):Container(),
              ],
            ),
          )
        ],
      );
    });
  }

  _childWithKey(GlobalKey key, Widget child) {
    return Container(
      key: key,
      child: child,
    );
  }


  _homeWidgetTabView(context) {
    return Obx((){
      var about=controller.companyProfileData.value.data?.profileDescription??"";
      var email=controller.companyProfileData.value.data?.email??"";
      var phone=controller.companyProfileData.value.data?.phone??"";
      //var dob=controller.companyProfileData.value.data?.do??"";
      var location=generateLocation(cityName: controller.companyProfileData.value.data?.cityName??"", stateName: controller.companyProfileData.value.data?.stateName??"", countryName: controller.companyProfileData.value.data?.countryName??"");
      var company=controller.companyProfileData.value.data?.companyName??"";
      var companyFounded="1993 Founded"??"";
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: appPrimaryBackgroundColor,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(appAbout,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          GestureDetector(
                            onTap: (){
                              // if(profileDescription.isNotEmpty){
                              //   Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails,isEdit:true,filledProfileDescriptionData:profileDescription??""});
                              // }else{
                              //   Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails});
                              // }

                            },
                            child: SvgPicture.asset(appEditIcon,height: 22,width: 22,),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: appPrimaryBackgroundColor,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: commonReadMoreWidget(context, trimLine: 5,message: about??"", textStyle: AppTextStyles.font14.copyWith(color: appGreyBlackColor)),
                      // SizedBox(height: 20,),,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(appBasicDetails,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          SizedBox(height: 10,),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(appAppIndustoryIconSvg,height: 22,width: 22,),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(appIndustry,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                      Text(company,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(appEmail,height: 22,width: 22,),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(appEmailText,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                      Text(email,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  phone.isNotEmpty?Row(
                                    children: <Widget>[
                                      SvgPicture.asset(appPhoneIcon,height: 22,width: 22,),
                                      SizedBox(width: 8,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(appPhone,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                          Text(phone,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                        ],
                                      )
                                    ],
                                  ):Container(),
                                  companyFounded.isNotEmpty?Row(
                                    children: <Widget>[
                                      SvgPicture.asset(appCompanyIcon,height: 22,width: 22,),
                                      SizedBox(width: 8,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(appCompanyFounded,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                          Text(companyFounded,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                        ],
                                      )
                                    ],
                                  ):Container(),
                                ],
                              ),

                              location.isNotEmpty?SizedBox(height: 5,):SizedBox(height: 0,),
                              location.isNotEmpty?Row(
                                children: <Widget>[
                                  SvgPicture.asset(appLocationsSvgIcon,height: 22,width: 22,),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(appLocation,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                      Text(location,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                    ],
                                  )
                                ],
                              ):Container(),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(appSocialNetwork,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          Row(
                            children: <Widget>[
                              SvgPicture.asset(appLinkdinNewSvg,height: 26,width: 26,),
                              SizedBox(width: 10,),
                              SvgPicture.asset(appFacebookSvgIcon,height: 26,width: 26,),
                              SizedBox(width: 10,),
                              SvgPicture.asset(appXIcon,height: 26,width: 26,),
                              SizedBox(width: 10,),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _jobOpeningTabView(context) {
    return Obx((){
      var jobOpeningData=controller.companyProfileData.value.data?.alljob??[];
      return Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: appPrimaryBackgroundColor,width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(appJobOpening,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                  GestureDetector(
                    onTap: (){
                      // if(profileDescription.isNotEmpty){
                      //   Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails,isEdit:true,filledProfileDescriptionData:profileDescription??""});
                      // }else{
                      //   Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails});
                      // }

                    },
                    child: SvgPicture.asset(appEditIcon,height: 22,width: 22,),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            jobOpeningData.isNotEmpty?Container(
              margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child:Wrap(
                  runSpacing: 10,
                  children: List.generate(jobOpeningData.length??0, (index){
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == 10 - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                      ),
                      child: commonCardWidget(context,
                          cardWidth: MediaQuery.of(context).size.width*0.9,
                          onClick: (){
                            //controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                          },
                          image:  jobOpeningData[index].profile??"",
                          isCompanyProfile:true,
                          jobProfileName:  jobOpeningData[index].designationName??"",
                          companyName:  jobOpeningData[index].countryName??"",
                          salaryDetails:  jobOpeningData[index].salaryName??"",
                          expDetails: jobOpeningData[index].experienceName??"",
                          programmingList: [],
                          isExpanded: controller.isExpanded.value,
                          onExpandChanged: () {
                            controller.isExpanded.value=!controller.isExpanded.value;
                          },
                          location: generateLocation(cityName:jobOpeningData[index].cityName??"", stateName: jobOpeningData[index].stateName??"", countryName: jobOpeningData[index].countryName??""),
                          timeAgo: calculateTimeDifference(createDate:  jobOpeningData[index].createDate??""),
                          isApplyClick: () {
                            //controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                          }

                      ),
                    );
                  }),
                ),
              ),
            ):Container(
              child: noDataAvailableFoundWidget(context, header: appGallery, details: appNoGalleryData),
            )
          ],
        ),
      );
    });
  }

  _galleryWidget(context,) {
    return Obx((){
      var appGalleryData=controller.companyProfileData.value.data?.allGallery??[];
      return Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: appPrimaryBackgroundColor,width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(appGallery,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                  GestureDetector(
                    onTap: (){
                      Get.offNamed(AppRoutes.addGallery,arguments: {screenName:companyProfileScreen});

                    },
                    child: SvgPicture.asset(appEditIcon,height: 22,width: 22,),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            appGalleryData.isNotEmpty?Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Wrap(
                    spacing:15,
                    children: List.generate(appGalleryData.length>2?2:appGalleryData.length, (index){
                      return commonImageWidget(image: appGalleryData[index].image??"", initialName:  appGalleryData[index].name??"", height: MediaQuery.of(context).size.height*0.1, width: MediaQuery.of(context).size.width*0.4, borderRadius: 5,borderColor: appPrimaryBackgroundColor);
                    }),
                  ),
                  SizedBox(height: 8,),
                  Wrap(
                    spacing:5,
                    children: List.generate(appGalleryData.length, (index){
                      return Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index==0?appPrimaryColor:appGreyWhiteColor
                        ),
                        height: 5,width: 5,
                      );
                    }),
                  ),
                ],
              ),
            ):Container(
              child: noDataAvailableFoundWidget(context, header: appGallery, details: appNoGalleryData),
            )

          ],
        ),
      );
    });
  }

  Widget _similarCompanyWidget(context) {
    return Obx((){
      var companyProfile=controller.companyProfileData.value.data?.topCompany??[];
      return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        color: appPrimaryBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(appCompanyProfiles,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
            SizedBox(height: 5,),
            Wrap(
              runSpacing: 5,
              children: List.generate(companyProfile.length??0, (index){
                return commonTopCompaniesWidget(context,
                  image: companyProfile[index].profile??"",
                  location: generateLocation(cityName: companyProfile[index].cityName??"", stateName: companyProfile[index].stateName??"", countryName: companyProfile[index].countryName??"",),//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                  name: capitalizeFirstLetter(companyProfile[index].name??"",),
                  id:companyProfile[index].individualId??"",// allTopCompanies[index]['individual_id']??"",
                  jobTitle: "",
                  onClick: (){
                    var userId=controller.companyProfileData.value.data?.id??"";
                    controller.companyFollowApiCall(context,companyId:userId??"" , userId:companyProfile[index].id??"" );

                  },
                  isFollowData: true, onMessageClick: (){
                    // Get.offNamed(
                    //     AppRoutes.chat,
                    //     arguments: {
                    //       screenName:profileDetails,
                    //       messageReceiverName:companyProfile[index].name??"",
                    //       profileImageData:companyProfile[index].profile??"",
                    //       receiverId:companyProfile[index].id??"",
                    //       senderId:userId??"",
                    //
                    //     });
                  },
                  isProfileVerified: companyProfile[index].isVerified??false,
                  cardWidth: MediaQuery.of(context).size.width,
                  onProfileClick: (){
                    Get.offNamed(AppRoutes.otherCompanyProfilePage,arguments: {screenName:companyProfileScreen,slugId:companyProfile[index].slug??""});
                  }
                  // isFollowing:companyProfile[index].followingData?.requestSend??false,



                );
              }),
            )
          ],
        ),
      );
    });
  }

  Widget _simillerProfileWidget(context) {

    return Obx((){
      var simillerUserData=controller.companyProfileData.value.data?.topUser??[];
      return Container(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        color: appWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(appEmployeeProfiles,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
            SizedBox(height: 5,),
            Wrap(
              runSpacing: 5,
              children: List.generate(simillerUserData.length??0, (index){
                return commonTopCompaniesWidget(context,
                  image: simillerUserData[index].profile??"",
                  location: generateLocation(cityName:simillerUserData[index].cityName??"", stateName: simillerUserData[index].stateName??"", countryName: simillerUserData[index].countryName??""),
                  name: capitalizeFirstLetter(simillerUserData[index].name??"",),
                  id:simillerUserData[index].individualId??"",
                  jobTitle: capitalizeFirstLetter(simillerUserData[index].designationName??"",),
                  onClick: (){
                    // var userId=controller.userProfileData.value.data?.id??"";
                    // controller.companyFollowApiCall(context,companyId:userId??"" , userId:similarProfile[index].id??"" );

                  },
                  isSimilerProfile:true,
                  isProfileVerified: simillerUserData[index].isVerified??false,
                  cardWidth: MediaQuery.of(context).size.width,
                  onProfileClick: (){
                    Get.offNamed(AppRoutes.otherIndividualProfilePage,arguments: {screenName:companyProfileScreen,slugId:simillerUserData[index].slug??""});
                  },
                  isFollowData: false, onMessageClick: (){
                    Get.offNamed(
                        AppRoutes.chat,
                        arguments: {
                          screenName:profileDetails,
                          messageReceiverName:simillerUserData[index].name??"",
                          profileImageData:simillerUserData[index].profile??"",
                          receiverId:simillerUserData[index].id??"",
                          senderId:userId??"",

                        });
                  },
                );
              }),
            )
          ],
        ),
      );
    });
  }



}

