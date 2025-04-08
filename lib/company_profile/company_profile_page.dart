import 'package:collarchek/company_profile/company_profile_controllers.dart';
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
                          Obx(() => SingleChildScrollView(
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
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _childWithKey(controller.homeKey, _homeWidgetTabView(context)),
                              _childWithKey(controller.jobOpeningKey, _jobOpeningTabView(context)),
                              _childWithKey(controller.galleryKey, _galleryWidget(context)),
                              _childWithKey(controller.companyKey, _similarCompanyWidget(context)),
                              _childWithKey(controller.similerProfile, _simillerProfileWidget(context)),
                            ],
                          ),),
                      ),





                        ],
                      )

                  )
              )
            ],
          ),
        )
    );
  }

  _profileWidget(BuildContext context) {
    return  Container(
      child: Column(
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
                    child: commonImageWidget(image: "", initialName: "initialName", height: 100, width: 100, borderRadius: 14),
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
                Text("Abc TECHNOLOGy d d d d d d d d d d d d d d d d d",style: AppTextStyles.font20W700.copyWith(color: appBlackColor),maxLines: 3,),
                Text("$appId: ${"CCE3553664"}",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),maxLines: 1,),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(appMyConnectionIconSvg,height: 16,width: 16,color: appBlackColor,),
                        SizedBox(width: 4,),
                        Text("${206} $appEmployees",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                      ],
                    ),
                    SizedBox(width: 8,),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      height: 18,width: 1,color: appGreyBlackColor,),
                    SizedBox(width: 5,),
                    Row(
                      children: <Widget>[
                        Text("${"3K"} $appFollowerText",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appDesignationSvgIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text("Advertising Services",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appEmail,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text("satyam@gmail.com",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appPhoneIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text("+917705089308",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(appLocationsSvgIcon,height: 20,width: 20,),
                    SizedBox(width: 4,),
                    Text(generateLocation(cityName: "Noida", stateName: "Delhi", countryName: "India"),style: AppTextStyles.font14W500.copyWith(color: appBlackColor),maxLines: 1,),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _childWithKey(GlobalKey key, Widget child) {
    return Container(
      key: key,
      child: child,
    );
  }


  _homeWidgetTabView(context) {
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
                    child: commonReadMoreWidget(context, trimLine: 5,message: "ABC Tech is a company specializing in financial software solutions, primarily catering to the banking and software industries. Founded in 2000, it offers innovative products for digital , available both on cloud and on-premise platforms. Their services enable clients to introduce a wide range of financial offerings.... read more", textStyle: AppTextStyles.font14.copyWith(color: appGreyBlackColor)),
                    // SizedBox(height: 20,),,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(appBasicDetails,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                        SizedBox(height: 20,),
                        Column(
                          children: <Widget>[
                            jonInfoCard(context,icon1: appEmail, header1: appEmailText, description1: 'satyam@gmail.com', icon2: appPhoneIcon, header2: appPhone, description2: '+917780987867'),
                            SizedBox(height: 10,),
                            jonInfoCard(context,icon1: appDobIcon, header1: appDOBText, description1: '29 jan 1996', icon2: appLocationsSvgIcon, header2: appLocation, description2: 'Delhi,India'),
                            SizedBox(height: 10,),
                            jonInfoCard(context,icon1: appCompanyIcon, header1: appCompany, description1: 'Quality', icon2: appDesignationSvgIcon, header2: appDesignation, description2: 'Project Manager'),
                            SizedBox(height: 10,),
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
  }

  _jobOpeningTabView(context) {
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
          Container(
            margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Obx(()=>Wrap(
                runSpacing: 10,
                children: List.generate(2??0, (index){
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == 10 - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                    ),
                    child: commonCardWidget(context,
                        cardWidth: MediaQuery.of(context).size.width*0.9,
                        onClick: (){
                          //controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                        },
                        image:  ""??"",
                        isCompanyProfile:true,
                        jobProfileName: "Software Enginner"??"",
                        companyName: "Narula Expert",
                        salaryDetails: "6 Laks-10 Lakd"??"",
                        expDetails: "7-11 year",
                        programmingList: [],
                        isExpanded: controller.isExpanded.value,
                        onExpandChanged: () {
                          controller.isExpanded.value=!controller.isExpanded.value;
                        },
                        location: generateLocation(cityName:"Noida"??"", stateName: "Delhi"??"", countryName: "India"??""),
                        timeAgo: calculateTimeDifference(createDate:  "03-04-2024"??""),
                        isApplyClick: () {
                          //controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                        }

                    ),
                  );
                }),
              )),
            ),
          )
        ],
      ),
    );
  }

  _galleryWidget(context) {
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

        ],
      ),
    );
  }

  Widget _similarCompanyWidget(context) {
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
            children: List.generate(10??0, (index){
              return commonTopCompaniesWidget(context,
                image: "",
                location: generateLocation(cityName: "noida"??"", stateName: "Delhi"??"", countryName: "India"??""),//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                name: capitalizeFirstLetter("Narula expert"??""),
                id:"CCID%^%DI"??"",// allTopCompanies[index]['individual_id']??"",
                jobTitle: "",
                onClick: (){
                  // var userId=controller.userProfileData.value.data?.id??"";
                  // controller.companyFollowApiCall(context,companyId:companyProfile[index].id??"", userId: userId??"" );

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
               // isFollowing:companyProfile[index].followingData?.requestSend??false,



              );
            }),
          )
        ],
      ),
    );
  }

  Widget _simillerProfileWidget(context) {

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
            children: List.generate(5??0, (index){
              return commonTopCompaniesWidget(context,
                image: "",
                location: generateLocation(cityName:"Npida"??"", stateName: "Delhi"??"", countryName: "india"??""),
                name: capitalizeFirstLetter("Satyam Shukla"??""),
                id:"CCDD^&&DD"??"",
                jobTitle: capitalizeFirstLetter("Software export"??""),
                onClick: (){
                  // var userId=controller.userProfileData.value.data?.id??"";
                  // controller.companyFollowApiCall(context,companyId:userId??"" , userId:similarProfile[index].id??"" );

                },
                isSimilerProfile:true,
                isFollowData: false, onMessageClick: (){
                  // Get.offNamed(
                  //     AppRoutes.chat,
                  //     arguments: {
                  //       screenName:profileDetails,
                  //       messageReceiverName:similarProfile[index].name??"",
                  //       profileImageData:similarProfile[index].profile??"",
                  //       receiverId:similarProfile[index].id??"",
                  //       senderId:userId??"",
                  //
                  //     });
                },
              );
            }),
          )
        ],
      ),
    );
  }



}

