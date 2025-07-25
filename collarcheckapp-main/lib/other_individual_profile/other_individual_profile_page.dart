import 'package:collarchek/profile_details/profile_details_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:dotted_line_flutter/dotted_line_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_progress_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/common_widget/update_profile_individual_bottom_sheet.dart';
import '../utills/font_styles.dart';
import 'other_individula_profile_controllers.dart';

class OtherIndividualProfilePage extends GetView<OtherIndividualProfileControllers>{
  const OtherIndividualProfilePage({super.key});

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
            children: [
              /// **SliverAppBar inside NestedScrollView**
              Expanded(
                child: NestedScrollView(
                  controller: controller.scrollController,
                  headerSliverBuilder: (contextData, innerBoxIsScrolled) {
                    return [

                      SliverToBoxAdapter(
                        child: Container(
                          key:  controller.headerKey,
                          color: appScreenBackgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                 margin: EdgeInsets.only(top: 20),
                                height:60,
                                child: controller.isEmployeeProfileDate.value?commonActiveSearchBar(
                                    leadingIcon: appBackSvgIcon,
                                    screenName: appEmployeeProfiles,
                                    isFilterShow: false,
                                    actionButton: appFilterMore,
                                    onClick: (){
                                      controller.backButton(context);
                                    },
                                    onShareClick: (){},
                                    onFilterClick:(){
                                    },
                                    isScreenNameShow: true,
                                    isShowShare: false
                                ):commonAppBarWithSettingAndShareOptionWithBackButton(context,
                                  leadingIcon: appBackSvgIcon,
                                  onClick: () {},
                                  onSettingsClick: () {},
                                  onBackClick: () {
                                    controller.backButton(context);
                                  },
                                ),
                              ),
                              Container(
                                color: appScreenBackgroundColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //controller.isEmployeeProfileDate.value?SizedBox(height: 0): SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: _profileWidget(context),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 1,
                                      color: appPrimaryBackgroundColor,
                                    ),
                                    Obx(() {
                                      var stillWorkingCompany = controller.userProfileData.value.data?.stillWorkingCompanyName ?? "";
                                      var email = controller.userProfileData.value.data?.email ?? "";
                                      var phone = controller.userProfileData.value.data?.phone ?? "";
                                      var city = controller.userProfileData.value.data?.city ?? "";
                                      var state = controller.userProfileData.value.data?.stateName ?? "";
                                      var country = controller.userProfileData.value.data?.countryName ?? "";

                                      return Container(
                                        padding: EdgeInsets.only(left: 30, right: 20),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            if (stillWorkingCompany.isNotEmpty)
                                              _detailsCard(image: appCompanyIcon, title: stillWorkingCompany),
                                            SizedBox(height: 5),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                if (email.isNotEmpty) _detailsCard(image: appEmail, title: email),
                                                if (email.isNotEmpty) SizedBox(width: 10),
                                                if (phone.isNotEmpty) _detailsCard(image: appPhoneIcon, title: phone),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            if (state.isNotEmpty)
                                              _detailsCard(
                                                image: appLocationsSvgIcon,
                                                title: generateLocation(cityName: city, stateName: state, countryName: country),
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 10),
                                    Obx(() {
                                      var isVerified = controller.userProfileData.value.data?.isVerified ?? false;
                                      return isVerified
                                          ? Container()
                                          : Container(
                                        decoration: BoxDecoration(
                                          color: appGreyColor.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        margin: EdgeInsets.only(left: 20, right: 20),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(appVerifiedIcon, height: 26, width: 26),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(appVerifyYourProfile,
                                                    style: AppTextStyles.font16W600.copyWith(color: appBlackColor)),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.72,
                                                  child: Text(appOnAverage,
                                                      style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: appPrimaryColor,
                                                  ),
                                                  child: Text(appVerifyNow,
                                                      style: AppTextStyles.font12.copyWith(color: appWhiteColor)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 10),
                                    Obx((){
                                      return controller.userProfileData.value.data?.id.toString()!=controller.userIdData.value?Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child: commonButton(
                                                isPaddingDisabled: true,
                                                context,
                                                buttonName: appFollowFound,
                                                buttonBackgroundColor: appWhiteColor,
                                                textColor: appPrimaryColor,
                                                buttonBorderColor: appPrimaryColor,
                                                onClick: (){

                                                }
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child: commonButton(
                                                context,
                                                isPaddingDisabled: true,
                                                buttonName: appMessageFound,
                                                buttonBackgroundColor: appPrimaryColor,
                                                textColor: appWhiteColor,
                                                buttonBorderColor: appPrimaryColor,
                                                onClick: (){

                                                }
                                            ),
                                          ),
                                        ],
                                      ):Container();

                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    //margin: EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(height: 20),

                        /// **TabBarView below the TabBar**
                        Expanded(
                          child: Obx((){
                            var allData=controller.userProfileData.value.data;
                            return SingleChildScrollView(
                              controller: controller.isScrollEnabled.value ? controller.scrollControllerForTabSelection : null,
                              physics: controller.isScrollEnabled.value ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                              child: Container(
                                key: controller.bodyKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _childWithKey(controller.sectionKeys[0], _homeTabDetails(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[1], _employmentHistory(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[2], _portFolioTabDetails(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[3], _educationTabDetails(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[4], _certificateWidget(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[5], _skillsWidget(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[6], _languageWidget(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[7], _companyProfile(context)),
                                    SizedBox(height: 20,),
                                    _childWithKey(controller.sectionKeys[8], _similarProfile(context)),
                                    _commonWidgetData(context)


                                  ],
                                ),
                              ),
                            );
                          }),)

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _profileWidget(context) {
    return Obx((){
      var profileData=controller.userProfileData.value.data;
      if (profileData == null) {
        return Container(); // Show a placeholder or shimmer effect
      }
      var profileImage=profileData?.profile??"";
      var userFirstName=profileData?.fname??"";
      var userLastName=profileData?.lname??'';
      var userIndividualId=profileData?.individualId??"";
      var isUserVerified=profileData?.isVerified??false;
      var ratings=profileData.totalRating?.rating.toString()??"0";
      var review=profileData.totalRating?.noofrecord.toString()??"0";
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          profileImage!=null&&profileImage.isNotEmpty?ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(profileImage??"",height: 80,width: 80,fit: BoxFit.cover,),
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
            child: Text(getInitialsWithSpace(input: "$userFirstName $userLastName"),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
          ),
          SizedBox(width: 10,),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.63,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.56,
                        child: isUserVerified?RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$userFirstName $userLastName",
                                style: AppTextStyles.font20W700.copyWith(color: appBlackColor),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SvgPicture.asset(
                                  appVerifiedIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                        ):Text("$userFirstName $userLastName",style: AppTextStyles.font20W700.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                      ),
                      GestureDetector(
                          onTap:(){
                            // Get.offNamed(AppRoutes.profile,arguments: {screenName:profileDetails});
                            individualUpdateProfileBottomSheet(context);
                          },
                          child: SvgPicture.asset(appEditIcon,height: 20,width: 20,))
                    ],
                  ),
                ),
                Text("$appId: $userIndividualId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Star + rating
                    ratings.isNotEmpty&&ratings!="0.0"&&ratings!="0"?Row(
                      children: <Widget>[
                        SvgPicture.asset(appStarIcon, height: 16, width: 16),
                        SizedBox(width: 5),
                        Text(
                          formatRating(ratings),
                          style: AppTextStyles.font12w500.copyWith(color: appBlackColor),
                        ),
                        SizedBox(width: 5),
                      ],
                    ):Container(),

                    // Separator only when both available
                    ( ratings.isNotEmpty&&ratings!="0.0"&&ratings!="0")&&(review.isNotEmpty&&review!="0.0"&&review!="0")?Text(
                      "|",
                      style: AppTextStyles.font12w500.copyWith(color: appBlackColor),
                    ):Container(),
                    SizedBox(width: 5),

                    // Review count
                    review.isNotEmpty&&review!="0.0"&&review!="0"?Text(
                      "$review ${review == "1" ? appReview : appReviews}",
                      style: AppTextStyles.font12w500.copyWith(color: appBlackColor),
                    ):Container(),
                  ],
                ) ,


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     SvgPicture.asset(appStarIcon,height: 16,width: 16,),
                //     SizedBox(width: 5,),
                //     Text("${formatRating(ratings)} $appStar | $review ${review=="0"||review=="1"?appReview:appReviews}",style: AppTextStyles.font12w500.copyWith(color: appBlackColor)),
                //   ],
                // ),
                ///Followers
                controller.userProfileData.value.data?.followData?.follower!=0?SizedBox(height: 5,):SizedBox(height: 0,),
                Obx((){
                  var followersData=controller.userProfileData.value.data?.followData?.follower??'';
                  return followersData!=0?Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appFollowers,height: 20,width: 20,),
                      SizedBox(width: 5,),
                      Text("$followersData ${followersData == 1 ?appFollowerText : appFollowersText}",style: AppTextStyles.font14W500.copyWith(color: appBlackColor)),
                    ],
                  ):Container();
                }),
                ///Designation
                SizedBox(height: 5,),
                Obx((){
                  var desegination=controller.userProfileData.value.data?.countryName??'';
                  return desegination!=null&&desegination.isNotEmpty?Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appDesignationSvgIcon,height: 20,width: 20,),
                      SizedBox(width: 5,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.54,
                          child: Text("Sr. Frontend Dev",style: AppTextStyles.font14W500.copyWith(color: appBlackColor))),
                    ],
                  ):Container();
                }),
                // isUserVerified?Container():Text("($appVerificationPending)",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor)),
              ],
            ),
          )
        ],
      );
    });
  }

  _detailsCard({required String image,required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(image,height: 20,width: 20,),
        SizedBox(width: 5,),
        Text(title,style: AppTextStyles.font14W500.copyWith(color: appBlackColor)),
      ],
    );
  }




  ///Home Tab
  _homeTabDetails(context) {
    return Obx((){
      var profileHomeTabData=controller.userProfileData.value.data;
      var profileDescription=profileHomeTabData?.profileDescription??"";
      var linkdinData=profileHomeTabData?.linkdin??"";
      var instagramData=profileHomeTabData?.instagram??"";
      var youtubeData=profileHomeTabData?.youtube??"";
      var facebookData=profileHomeTabData?.facebook??"";
      var tumblrData=profileHomeTabData?.tumblr??"";
      var discordData=profileHomeTabData?.discord??"";
      var twitterData=profileHomeTabData?.twitter??"";
      var zoomData=profileHomeTabData?.zoom??"";
      var anapchatData=profileHomeTabData?.snapchat??"";
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
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
                        controller.isOtherUserProfileCheck==false? GestureDetector(
                          onTap: (){
                            if(profileDescription.isNotEmpty){
                              Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails,isEdit:true,filledProfileDescriptionData:profileDescription??""});
                            }else{
                              Get.offNamed(AppRoutes.about,arguments: {screenName:profileDetails});
                            }

                          },
                          child: SvgPicture.asset(appEditIcon,height: 22,width: 22,),
                        ):Container()
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: appPrimaryBackgroundColor,
                  ),
                  profileDescription.isNotEmpty?Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Text(profileDescription??"",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),)
                  ):noDataAvailableFoundWidget(context, header: appNoDescriptionFound, details: appNoDataFound,),
                  // SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(appBasicDetails,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                        SizedBox(height: 20,),
                        Column(
                          children: <Widget>[
                            jonInfoCard(context,icon1: appEmail, header1: appEmailText, description1: profileHomeTabData?.email??"", icon2: appPhoneIcon, header2: appPhone, description2: profileHomeTabData?.phone??""),
                            SizedBox(height: 10,),
                            jonInfoCard(context,icon1: appDobIcon, header1: appDOBText, description1: profileHomeTabData?.dob??"", icon2: appLocationsSvgIcon, header2: appLocation, description2: generateLocation(cityName: profileHomeTabData?.cityName??"", stateName: profileHomeTabData?.stateName??"", countryName: profileHomeTabData?.countryName??"")),
                            SizedBox(height: 10,),
                            jonInfoCard(context,icon1: appCompanyIcon, header1: appCompany, description1: profileHomeTabData?.stillWorkingCompanyName??"", icon2: appDesignationSvgIcon, header2: appDesignation, description2: profileHomeTabData?.stillWorkingPositionName??""),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ([
                    linkdinData,
                    instagramData,
                    youtubeData,
                    facebookData,
                    tumblrData,
                    discordData,
                    twitterData,
                    zoomData,
                    anapchatData,
                  ].any((element) => element.isNotEmpty))
                      ? Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          appSocialNetwork,
                          style: AppTextStyles.font16W600.copyWith(color: appBlackColor),
                        ),
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(appLinkdinNewSvg, height: 26, width: 26),
                            SizedBox(width: 10),
                            SvgPicture.asset(appFacebookSvgIcon, height: 26, width: 26),
                            SizedBox(width: 10),
                            SvgPicture.asset(appXIcon, height: 26, width: 26),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  )
                      : SizedBox.shrink()

                  // Container(
                  //   padding: EdgeInsets.only(left: 10,right: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(appSocialNetwork,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                  //       Row(
                  //         children: <Widget>[
                  //           SvgPicture.asset(appLinkdinNewSvg,height: 26,width: 26,),
                  //           SizedBox(width: 10,),
                  //           SvgPicture.asset(appFacebookSvgIcon,height: 26,width: 26,),
                  //           SizedBox(width: 10,),
                  //           SvgPicture.asset(appXIcon,height: 26,width: 26,),
                  //           SizedBox(width: 10,),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            //_commonWidgetData(context)
          ],
        ),
      );
    });
  }

  ///Education Tab
  _educationTabDetails(context) {
    return Obx((){
      var educationDetails=controller.educationListData.value.data??[];
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appPrimaryBackgroundColor,width: 1)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(appEducation,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                        controller.isOtherUserProfileCheck==false?GestureDetector(
                          onTap: (){
                            Get.offNamed(AppRoutes.educations,arguments: {screenName:profileDetails});
                          },
                          child: Row(
                            children:<Widget> [
                              SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                              SizedBox(width: 5,),
                              Text(appAddEducation,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: appPrimaryBackgroundColor,
                  ),
                  educationDetails.isNotEmpty?Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context,int index){
                        return SizedBox(height: 50,);
                      },
                      itemCount: educationDetails.length??0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context,int index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: appPrimaryColor,width: 1)
                                      ),
                                      child: educationDetails[index].endingDate!=null?Text(dateTimeYear(date: educationDetails[index].endingDate??""),style: AppTextStyles.font12.copyWith(color: appPrimaryColor)):Container(),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.62,
                                            child: Text(educationDetails[index].course??"",style: AppTextStyles.font16W600.copyWith(color: appBlackColor))),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.62,
                                            child: Text(educationDetails[index].university??"" ,style: AppTextStyles.font14.copyWith(color: appPrimaryColor))),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.62,
                                            child: Row(
                                              children: <Widget>[
                                                Text(formatDate(date: educationDetails[index].startingDate??""),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)),
                                                Text(" $appTo ",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)),
                                                educationDetails[index].ongoing==true?Text(appPursuing,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)): Text(formatDate(date: educationDetails[index].endingDate??""),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor))
                                              ],
                                            )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                controller.isOtherUserProfileCheck==false?GestureDetector(
                                  onTap: (){
                                    Get.offNamed(AppRoutes.educations,arguments: {screenName:profileDetails,isEdit:true,isEditItemId:educationDetails[index].id});

                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: SvgPicture.asset(appEditIcon,height: 22,width: 22),
                                  ),
                                ):Container()
                              ],
                            ),

                          ],
                        );
                      },
                    ),
                  ):noDataAvailableFoundWidget(context, header: appNoEducationFound, details: appAddEducation,),
                ],
              ),
            ),
            //_commonWidgetData(context)
          ],
        ),
      );
    });
  }

  ///Portfolio Tab
  _portFolioTabDetails(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appPrimaryBackgroundColor,width: 1)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(appPortfolio,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                      controller.isOtherUserProfileCheck==false?GestureDetector(
                        onTap: (){
                          Get.offNamed(AppRoutes.addPortfolio,arguments: {screenName:profileDetails});
                        },
                        child: Row(
                          children:<Widget> [
                            SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                            SizedBox(width: 5,),
                            Text(appAddPortfolio,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                          ],
                        ),
                      ):Container()
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: appPrimaryBackgroundColor,
                ),
                SingleChildScrollView(
                  child: Obx((){
                    var portfolioData=controller.portfolioData.value.data??[];
                    return portfolioData.isNotEmpty?Wrap(
                      spacing: 15,
                      runSpacing: 20,
                      children: List.generate(portfolioData.length, (index){
                        return Container(
                          width: MediaQuery.of(context).size.width*0.40,
                          padding: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                          margin: EdgeInsets.only(bottom: 5,left: 5,top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: appPrimaryBackgroundColor,width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  portfolioData[index].image!.isNotEmpty?Image.network(portfolioData[index].image!,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,):Image.asset(appDummyImageData,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,),
                                  controller.isOtherUserProfileCheck==false?Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                        onTap:(){
                                          Get.offNamed(AppRoutes.addPortfolio,arguments: {screenName:profileDetails,isEdit:true,isEditItemId:portfolioData[index].id??""});
                                        },
                                        child: SvgPicture.asset(appEditIconWhiteBG,height: 30,width: 30,)),
                                  ):Container()

                                ],
                              ),
                              Text(portfolioData[index].title??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                              Text(portfolioData[index].description??"",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,),
                            ],
                          ),
                        );
                      }),
                    ):noDataAvailableFoundWidget(context, header: appNoPortfolioFound, details: appAddPortfolio);
                  }),
                ),
              ],
            ),
          ),
          // _commonWidgetData(context)
        ],
      ),
    );
  }


  /// Employment History
  _employmentHistory(context) {
    return Obx((){
      var employmentHistory=controller.employmentHistoryData.value.data??[];
      return SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appPrimaryBackgroundColor,width: 1)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(appEmploymentHistory,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                        controller.isOtherUserProfileCheck==false? GestureDetector(
                          onTap: (){
                            Get.offNamed(AppRoutes.employmentHistory,arguments: {screenName:profileDetails});
                          },
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(appAddIcon,height: 12,width: 12,),
                              SizedBox(width: 5,),
                              Text(appAddEmployement,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                            ],
                          ),
                        ):Container()
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: appPrimaryBackgroundColor,
                  ),
                  employmentHistory.isNotEmpty?Wrap(
                    children: List.generate(employmentHistory.length??0, (index){
                      return Container(
                        padding: EdgeInsets.only(left: 10,right: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildExperienceCard(
                                  context,
                                  isProfileVerification: true,//employmentHistory[index].v??false,
                                  companyName: employmentHistory[index].company??"",
                                  companyDetails: checkEmploymentIsPresentOfNot(joiningDate: employmentHistory[index].joiningDate??"", tillEmploymentDate: employmentHistory[index].workedTillDate
                                      ??"", isStillWorking: employmentHistory[index].stillWorking.toString()??"0"),
                                  companyImage: employmentHistory[index].companyLogo??appCompanyImage,
                                  experienceDetails: employmentHistory[index].lists??[],
                                  isExpended: controller.isExpendedSkills.value??false,
                                  onExpendEnable: (){
                                    controller.isExpendedSkills.value=!controller.isExpendedSkills.value;
                                  },
                                  employmentHistoryId: employmentHistory[index].id??"",
                                )

                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  ):noDataAvailableFoundWidget(context, header: appNoEmploymentHistory, details: appAddEmployement),
                ],
              ),
            ),
            // _commonWidgetData(context)
          ],
        ),
      );
    });
  }

  _certificateWidget(context){
    return  ///Certificates
      Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: <Widget>[
            Obx((){
              var certificatesData=controller.allCertificatesData.value.data??[];
              return Container(
                // margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(top: 10,bottom: 10,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: appPrimaryBackgroundColor,width: 1)
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(appCertifications,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          controller.isOtherUserProfileCheck==false?GestureDetector(
                            onTap: (){
                              Get.offNamed(AppRoutes.addCertificates,arguments: {screenName:profileDetails});
                            },
                            child: Row(
                              children:<Widget> [
                                SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                                SizedBox(width: 5,),
                                Text(appAddCertificates,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                              ],
                            ),
                          ):Container()
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: appPrimaryBackgroundColor,
                    ),
                    certificatesData.isNotEmpty?SingleChildScrollView(
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 20,
                        children: List.generate(certificatesData.length??0, (index){
                          return Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            margin: EdgeInsets.only(bottom: 10,top: 10),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: appPrimaryBackgroundColor,width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    certificatesData.isNotEmpty&&certificatesData[index].document!.isNotEmpty?Image.network(certificatesData[index].document?[0],height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,):Image.asset(appCertificatesImageData,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,),
                                    controller.isOtherUserProfileCheck==false?Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Row(
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: (){
                                                  controller.deleteCertificates(context, certificatesId: certificatesData[index].id??"",);

                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5
                                                  ),
                                                  decoration: BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    borderRadius: BorderRadius.circular(100.0),
                                                    color: appPrimaryBackgroundColor,
                                                    border: Border.all(color: appPrimaryBackgroundColor,width: 1),
                                                  ),
                                                  child: SvgPicture.asset(appDeleteSvgIcon,height: 15,width: 15,color: appPrimaryColor,),
                                                )),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                                onTap: (){
                                                  Get.offNamed(AppRoutes.addCertificates,arguments: {screenName:profileDetails,isEdit:true,isEditItemId:certificatesData[index].id});
                                                },
                                                child: SvgPicture.asset(appEditIconWhiteBG,height: 25,width: 25,)),
                                          ],
                                        )
                                    ):Container()

                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: Text(certificatesData[index].course??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),)),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: Text(certificatesData[index].university??"",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)),

                                Row(
                                  children: <Widget>[
                                    certificatesData[index].startDate!=null?Container(
                                        padding: EdgeInsets.all(5),
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Text("From : ${certificatesData[index].startDate??""}",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)):Container(),
                                    Text(" To ",style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),),
                                    certificatesData[index].ongoing==true?Container(
                                        padding: EdgeInsets.all(5),
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Text(appOngoing,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),)):certificatesData[index].endDate!=null?Container(
                                        padding: EdgeInsets.all(5),
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Text("From : ${certificatesData[index].startDate??""}",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)):Container(),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ):Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: appPrimaryColor,width: 1)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(appNoCertificateFound,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          Text(appAddCertificates,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }),

          ],
        ),
      );
  }

  _skillsWidget(context){
    return ///Skills
      Obx((){
        var skillsData=controller.allSkillsData.value.data??[];
        return Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(top: 10,bottom: 10,),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: appPrimaryBackgroundColor,width: 1)
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(appSkills,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                    controller.isOtherUserProfileCheck==false?GestureDetector(
                      onTap: (){
                        Get.offNamed(AppRoutes.skills,arguments: {screenName:profileDetails});
                      },
                      child: Row(
                        children:<Widget> [
                          SvgPicture.asset(appEditIcon,height: 14,width: 14,),
                        ],
                      ),
                    ):Container()
                  ],
                ),
              ),
              Container(
                height: 1,
                color: appPrimaryBackgroundColor,
              ),
              SizedBox(height: 10,),
              skillsData.isNotEmpty?SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  children: List.generate(skillsData.length??0, (index){
                    return Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              width:MediaQuery.of(context).size.width*0.45,
                              child: Text(skillsData[index].skill??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                          Row(
                            children: <Widget>[
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width*0.3,
                                lineHeight: 4.0,
                                percent: handleIndecaterPercentage(devident: skillsData[index].rating??"", devider: progressBarMaxValue),
                                barRadius: Radius.circular(10),
                                backgroundColor: appPrimaryBackgroundColor,
                                progressColor: appPrimaryColor,
                              ),
                              SizedBox(width: 3,),
                              Text("${skillsData[index].rating??""}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                            ],
                          )

                        ],
                      ),
                    );
                  }),
                ),
              ):Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appPrimaryColor,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(appNoSkillsFound,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                    Text(appAddSkills,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),),

                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        );
      });
  }
  _languageWidget(context){
    return ///Languages
      Obx((){
        var languageData=controller.languageDate.value.data??[];
        return Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(top: 10,bottom: 10,),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: appPrimaryBackgroundColor,width: 1)
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(appLanguage,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                    controller.isOtherUserProfileCheck==false?GestureDetector(
                      onTap: (){
                        Get.offNamed(AppRoutes.language,arguments: {screenName:profileDetails,});
                      },
                      child: Row(
                        children:<Widget> [
                          SvgPicture.asset(appEditIcon,height: 14,width: 14,),
                        ],
                      ),
                    ):Container()
                  ],
                ),
              ),
              Container(
                height: 1,
                color: appPrimaryBackgroundColor,
              ),
              SizedBox(height: 10,),
              languageData.isNotEmpty?SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  children: List.generate(languageData.length??0, (index){
                    return Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              width:MediaQuery.of(context).size.width*0.38,
                              child: Text(languageData[index].languageName??'',style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width:MediaQuery.of(context).size.width*0.3,
                                  child: Text(appVerbal,style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                              Row(
                                children: <Widget>[
                                  LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    lineHeight: 4.0,
                                    percent: handleIndecaterPercentage(devident: languageData[index].verbal??'', devider: progressBarMaxValue??''),
                                    barRadius: Radius.circular(10),
                                    backgroundColor: appPrimaryBackgroundColor,
                                    progressColor: appPrimaryColor,
                                  ),
                                  SizedBox(width: 3,),
                                  Text("${languageData[index].verbal??''}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width:MediaQuery.of(context).size.width*0.3,
                                  child: Text(appWritten,style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                              Row(
                                children: <Widget>[
                                  LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    lineHeight: 4.0,
                                    percent: handleIndecaterPercentage(devident: languageData[index].written??'', devider:progressBarMaxValue??''),
                                    barRadius: Radius.circular(10),
                                    backgroundColor: appPrimaryBackgroundColor,
                                    progressColor: appPrimaryColor,
                                  ),
                                  SizedBox(width: 3,),
                                  Text("${languageData[index].written??''}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                                ],
                              ),

                            ],
                          )

                        ],
                      ),
                    );
                  }),
                ),
              ):Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appPrimaryColor,width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(appNoLanguagesFound,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                    Text(appAddLanguage,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),),

                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        );
      });
  }

  _companyProfile(context){
    return Obx((){
      var companyProfile=controller.userProfileData.value.data?.topCompany??[];
      var userId=controller.userProfileData.value.data?.id??"";
      return  companyProfile.isNotEmpty?Container(

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
                  image: companyProfile[index].profile??appCompanyImage,
                  location: generateLocation(cityName: companyProfile[index].cityName??"", stateName: companyProfile[index].stateName??"", countryName: companyProfile[index].countryName??""),//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                  name: capitalizeFirstLetter(companyProfile[index].name??""),
                  id:companyProfile[index].individualId??"",// allTopCompanies[index]['individual_id']??"",
                  jobTitle: capitalizeFirstLetter(companyProfile[index].designationName??""),
                  onProfileClick: (){
                    Get.offNamed(AppRoutes.otherCompanyProfilePage,arguments: {screenName:otherUserProfileScreen,slugId:companyProfile[index].slug??"",isEmployeeProfile:true,selfSlugId: controller.slugDataId.value.isNotEmpty?controller.slugDataId.value:controller.slugData});
                  },
                  onClick: (){
                    var userId=controller.userProfileData.value.data?.id??"";
                    controller.companyFollowApiCall(context,companyId:companyProfile[index].id??"", userId: userId??"" );

                  },
                  isFollowData: true, onMessageClick: (){
                    Get.offNamed(
                        AppRoutes.chat,
                        arguments: {
                          screenName:profileDetails,
                          messageReceiverName:companyProfile[index].name??"",
                          profileImageData:companyProfile[index].profile??"",
                          receiverId:companyProfile[index].id??"",
                          senderId:userId??"",

                        });
                  },
                  isFollowing:companyProfile[index].following?.requestSend??false,
                  isProfileVerified: false,
                  cardWidth: MediaQuery.of(context).size.width*0.94,



                );
              }),
            )
          ],
        ),
      ):Container();
    });
  }
  _similarProfile(context){
    return  Obx((){
      var similarProfile=controller.userProfileData.value.data?.topUser??[];
      var userId=controller.userProfileData.value.data?.id??"";
      return similarProfile.isNotEmpty?Container(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        color: appWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(appSimilarProfiles,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
            SizedBox(height: 5,),
            Wrap(
              runSpacing: 5,
              children: List.generate(similarProfile.length??0, (index){
                return commonTopCompaniesWidget(context,
                  image: similarProfile[index].profile??appCompanyImage,
                  location: generateLocation(cityName: similarProfile[index].cityName??"", stateName: similarProfile[index].stateName??"", countryName: similarProfile[index].countryName??""),
                  name: capitalizeFirstLetter(similarProfile[index].name??""),
                  id:similarProfile[index].individualId??"",
                  jobTitle: capitalizeFirstLetter(similarProfile[index].designationName??""),
                  onProfileClick: (){
                  controller.slugDataId.value=similarProfile[index].slug??"";
                  Future.delayed(Duration(milliseconds: 500), ()async {
                    controller.getProfileApiCall();
                  });
                   // Get.offNamed(AppRoutes.otherIndividualProfilePage,arguments: {slugId:similarProfile[index].slug??"",screenName:otherUserProfileScreen,isEmployeeProfile:true});
                  },
                  onClick: (){
                    var userId=controller.userProfileData.value.data?.id??"";
                    controller.companyFollowApiCall(context,companyId:userId??"" , userId:similarProfile[index].id??"" );

                  },
                  isSimilerProfile:true,
                  isProfileVerified: false,
                  cardWidth: MediaQuery.of(context).size.width*0.94,
                  isFollowData: false, onMessageClick: (){
                    Get.offNamed(
                        AppRoutes.chat,
                        arguments: {
                          screenName:profileDetails,
                          messageReceiverName:similarProfile[index].name??"",
                          profileImageData:similarProfile[index].profile??"",
                          receiverId:similarProfile[index].id??"",
                          senderId:userId??"",

                        });
                  },
                );
              }),
            )
          ],
        ),
      ):Container();
    });
  }
  _commonWidgetData(context) {
    return Container(
      alignment: Alignment.center,
      child: allRightReservedWidget(),
    );
  }

  _childWithKey(GlobalKey key, Widget child) {
    return Container(
      key: key,
      child: child,
    );
  }

}

