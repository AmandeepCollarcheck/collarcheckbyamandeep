import 'package:collarchek/profile_details/profile_details_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:dotted_line_flutter/dotted_line_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';

class ProfileDetailsPage extends GetView<ProfileDetailsControllers>{
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: commonAppBarWithSettingAndShareOption(leadingIcon: appBackSvgIcon, onClick: () {  }, onSettingsClick: () {  }),
              ),
              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child:_profileWidget(context),
              ),
              SizedBox(height: 10,),
              Container(
                height: 1,
                color: appPrimaryBackgroundColor,
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    _detailsCard(image: appCompanyIcon, title: 'Webx pvt ltd'),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _detailsCard(image: appEmail, title: 'satyam@gmail.com'),
                        SizedBox(width: 10,),
                        _detailsCard(image: appPhoneIcon, title: '+91999939393939'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    _detailsCard(image: appLocationsSvgIcon, title: 'noida,delji'),
                  ],
                ),
              ),
              ///Buttons
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  commonButtonWithIcon(context, buttonName: appFollowFound, buttonBackgroundColor: appWhiteColor, textColor: appPrimaryColor, buttonBorderColor: appPrimaryColor, onClick: (){}, image: appFollowSvgIcon),
                  SizedBox(width: 10,),
                  commonButtonWithIcon(context, buttonName: appMessageFound, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor, buttonBorderColor: appPrimaryColor, onClick: (){}, image: appMessagesSvgIcon)
                ],
              ),
              SizedBox(height: 16,),
              Container(
                height: 1,
                color: appPrimaryBackgroundColor,
              ),
              SizedBox(height: 16,),
              _tabBarDetails(context),
              SizedBox(height: 20,),
              ///Certificates
              Container(
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
                          Text(appCertifications,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                          Row(
                            children:<Widget> [
                              SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                              SizedBox(width: 5,),
                              Text(appAddCertificates,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: appPrimaryBackgroundColor,
                    ),
                    SingleChildScrollView(
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 20,
                        children: List.generate(2, (index){
                          return Container(
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
                                    Image.asset(appCertificatesImageData,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: SvgPicture.asset(appEditIconWhiteBG,height: 30,width: 30,),
                                    )

                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: Text("Computer Engineering",style: AppTextStyles.font14.copyWith(color: appBlackColor),)),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: Text("From : Delhi Univercity to 1st Feb 2025 to 20th Feb 2025",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ///Skills
              Container(
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
                          Row(
                            children:<Widget> [
                              SvgPicture.asset(appEditIcon,height: 14,width: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: appPrimaryBackgroundColor,
                    ),
                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 10,
                        children: List.generate(2, (index){
                          return Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.2,
                                    child: Text("MSQ",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                                 Row(
                                   children: <Widget>[
                                     LinearPercentIndicator(
                                       width: MediaQuery.of(context).size.width*0.5,
                                       lineHeight: 4.0,
                                       percent: 0.5,
                                       barRadius: Radius.circular(10),
                                       backgroundColor: appPrimaryBackgroundColor,
                                       progressColor: appPrimaryColor,
                                     ),
                                     SizedBox(width: 3,),
                                    Text("2/5",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                                   ],
                                 )

                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ///Languages
              Container(
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
                          Row(
                            children:<Widget> [
                              SvgPicture.asset(appEditIcon,height: 14,width: 14,),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: appPrimaryBackgroundColor,
                    ),
                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 10,
                        children: List.generate(2, (index){
                          return Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                    width:MediaQuery.of(context).size.width*0.2,
                                    child: Text("Hindi",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    child: Text("Verbal",style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                                    Row(
                                      children: <Widget>[
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          lineHeight: 4.0,
                                          percent: 0.5,
                                          barRadius: Radius.circular(10),
                                          backgroundColor: appPrimaryBackgroundColor,
                                          progressColor: appPrimaryColor,
                                        ),
                                        SizedBox(width: 3,),
                                        Text("2/5",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        width:MediaQuery.of(context).size.width*0.3,
                                        child: Text("Writtern",style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                                    Row(
                                      children: <Widget>[
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          lineHeight: 4.0,
                                          percent: 0.5,
                                          barRadius: Radius.circular(10),
                                          backgroundColor: appPrimaryBackgroundColor,
                                          progressColor: appPrimaryColor,
                                        ),
                                        SizedBox(width: 3,),
                                        Text("2/5",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                                      ],
                                    ),

                                  ],
                                )

                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              ///CompanyProfile
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                color: appPrimaryBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(appCompanyProfiles,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                    SizedBox(height: 5,),
                    Wrap(
                      runSpacing: 5,
                      children: List.generate(10, (index){
                        return commonTopCompaniesWidget(context,
                            image: appCompanyImage,
                            location: "noida,delhi",//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                            name: "HCL TECH",//capitalizeFirstLetter(allTopCompanies[index]['industry_name']??""),
                            id:"CC123456",// allTopCompanies[index]['individual_id']??"",
                            jobTitle: 'Computer Software/Engineering',
                            onClick: (){},
                            isFollowData: true


                        );
                      }),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              ///Similer Profile
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                color: appWhiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(appSimilarProfiles,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                    SizedBox(height: 5,),
                    Wrap(
                      runSpacing: 5,
                      children: List.generate(10, (index){
                        return commonTopCompaniesWidget(context,
                            image: appCompanyImage,
                            location: "noida,delhi",//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                            name: "HCL TECH",//capitalizeFirstLetter(allTopCompanies[index]['industry_name']??""),
                            id:"CC123456",// allTopCompanies[index]['individual_id']??"",
                            jobTitle: 'Computer Software/Engineering',
                            onClick: (){},
                            isFollowData: false,
                        );
                      }),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              allRightReservedWidget(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  _profileWidget(context) {
    return Obx((){
      var profileImage=controller.userProfileData.value.data?.profile??"";
      var userFirstName=controller.userProfileData.value.data?.fname??"";
      var userLastName=controller.userProfileData.value.data?.lname??'';
      var userIndividualId=controller.userProfileData.value.data?.individualId??"";
      var isUserVerified=controller.userProfileData.value.data?.isVerified??false;
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            profileImage!=null&&profileImage.isNotEmpty?ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(profileImage??"",height: 100,width: 100,),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.58,
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

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: <Widget>[
                      //     SizedBox(
                      //       width:MediaQuery.of(context).size.width*0.48,
                      //         child: Text("$userFirstName $userLastName sasdhf shdfhs shdfh",style: AppTextStyles.font20W700.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                      //     SvgPicture.asset(appVerifiedIcon,height: 20,width: 20,)
                      //   ],
                      // ),
                      GestureDetector(
                          onTap:(){
                            Get.offNamed(AppRoutes.profile);
                          },
                          child: SvgPicture.asset(appEditIcon,height: 20,width: 20,))
                    ],
                  ),
                  Text("$appId: $userIndividualId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appStarIcon,height: 16,width: 16,),
                      SizedBox(width: 5,),
                      Text("4.3 stars | 555 reviews",style: AppTextStyles.font12w500.copyWith(color: appBlackColor)),
                    ],
                  ),
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
        ),
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

 Widget _tabBarDetails(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: appWhiteColor,
            padding:EdgeInsets.zero,
            child: TabBar(
              isScrollable: true,
              dividerColor: appWhiteColor,
              indicatorColor: appPrimaryColor,
              //padding: EdgeInsets.only(bottom: 10),
              //indicatorPadding: EdgeInsets.only(top: 10),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: controller.tabController,
              tabs: List.generate(controller.listTabLabel.length, (index){
                return Text(controller.listTabLabel[index],style: AppTextStyles.font14.copyWith(color: appBlackColor),);
              }),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            color: appWhiteColor,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: <Widget>[
                _homeTabDetails(context),
                Text("dfg"),


                _portFolioTabDetails(context),
                _educationTabDetails(context)
              ],
            ),
          ),
        ],
      ),
    );
 }

  _homeTabDetails(context) {
    return Container(
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
                Text(appHome,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                SvgPicture.asset(appEditIcon,height: 22,width: 22,)
              ],
            ),
          ),
          Container(
            height: 1,
            color: appPrimaryBackgroundColor,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Text("Wipro Limited (NYSE: WIT, BSE: 507685, NSE: WIPRO) is a leading technology services and consulting company focused on building innovative solutions that address clients’ most complex digital transformation needs. Leveraging our holistic portfolio of capabilities in consulting, design, engineering, and operations, we help clients realize their boldest ambitions and build future-ready, sustainable businesses",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),)),
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
                    SvgPicture.asset(appLinkedinSvgIcon,height: 26,width: 26,),
                    SizedBox(width: 10,),
                    SvgPicture.asset(appFacebookSvgIcon,height: 26,width: 26,),
                    SizedBox(width: 10,),
                    SvgPicture.asset(appXIcon,height: 26,width: 26,),
                    SizedBox(width: 10,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _educationTabDetails(context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: appPrimaryBackgroundColor,width: 1)
        ),
      child:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(appEducation,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                Row(
                  children:<Widget> [
                    SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                    SizedBox(width: 5,),
                    Text(appAddEducation,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: appPrimaryBackgroundColor,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context,int index){
                return SizedBox(height: 50,);
              },
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context,int index){
                return Column(
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
                              child: Text("2025",style: AppTextStyles.font12.copyWith(color: appPrimaryColor)),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.62,
                                    child: Text("Graduation",style: AppTextStyles.font16W600.copyWith(color: appBlackColor))),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.62,
                                    child: Text("Shri Ram College of commerce jfsjd sdf wsfsd asd" ,style: AppTextStyles.font14.copyWith(color: appPrimaryColor))),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.62,
                                    child: Text("5th Jun 2024 to 15th Feb 2025 (Expected) hrhs sjfhs sjfdh",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor))),
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: SvgPicture.asset(appEditIcon,height: 22,width: 22),
                          ),
                        )
                      ],
                    ),
            
                  ],
                );
              },
            ),
          )
        ],
      )
    );
  }

  _portFolioTabDetails(context) {
    return Container(
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
                Row(
                  children:<Widget> [
                    SvgPicture.asset(appExpendedIconIcon,height: 14,width: 14,),
                    SizedBox(width: 5,),
                    Text(appAddPortfolio,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: appPrimaryBackgroundColor,
          ),
          SingleChildScrollView(
            child: Wrap(
              spacing: 15,
              runSpacing: 20,
              children: List.generate(3+1, (index){
                if (index == 3) {
                  // Add extra text at the end
                  return _addNewPortfolio(context);
                }
                return Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: appPrimaryBackgroundColor,width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.asset(appDummyImageData,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SvgPicture.asset(appEditIconWhiteBG,height: 30,width: 30,),
                          )

                        ],
                      ),
                      Text("SQL",style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                      Text("SQL",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  _addNewPortfolio(context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SvgPicture.asset(appPortfolioImage,height: MediaQuery.of(context).size.height*0.1,width:MediaQuery.of(context).size.width*0.4 ,fit: BoxFit.cover,),
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(appEditIconWhiteBG,height: 30,width: 30,),
              )

            ],
          ),
          Text("SQL",style: AppTextStyles.font14.copyWith(color: appBlackColor),),
          Text("SQL",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
        ],
      ),
    );
  }

}