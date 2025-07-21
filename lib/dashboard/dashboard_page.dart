import 'package:collarchek/dashboard/dashboard_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart' show debounce;
import 'package:percent_indicator/circular_percent_indicator.dart';


import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class DashboardPage extends GetView<DashboardController>{
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: PopScope(
          canPop: false, // Prevents default back behavior
          onPopInvoked: (didPop) {
            if (!didPop) {
              onWillPop();
            }
          },
          child: GestureDetector(
            onHorizontalDragEnd: (details) => onSwipeBack(),
            child: Scaffold(
              backgroundColor: appBarBackgroundColor,
              // appBar: commonAppBar(onClick: co),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Obx(()=>commonSearchAppBar(
                          context,controller: controller.searchController,
                          actionButtonOne: appNotificationSVGIcon,
                          actionButtonTwo: appSearchIcon,
                          isSearchActive: controller.isSearchActive.value,
                          onChanged: (value){
                            // controller.openSearchScreen(context);

                          },
                          onTap: (){
                            controller.openSearchScreen(context);
                          },
                          onSearchIconClick: (bool isSearchClick) {
                            controller.isSearchActive.value=isSearchClick;
                            controller.getDashboardApiData();
                          })),
                    ),
                    SizedBox(height: 10,),
                    _profileWidget(context),
                    _recommendJobsWidget(context),
                    _verifyProfileClamNow(context),
                    _completeProfileForBetterSearch(context),
                    _jobsForYouWidget(context),
                    _topCompanies(),
                    allRightReservedWidget()

                  ],
                ),
              ),
            ),
          )
      )
    );
  }

  _recommendJobsWidget(context) {
    return  Obx((){
      if (controller.userHomeModel.value.data == null) {
        ///Add Simmer
        return Center();
      }
      var recommendJob = controller.userHomeModel.value.data!.recommendJob??[];
      return recommendJob!=null&&recommendJob.isNotEmpty?Container(
        color: appPrimaryBackgroundColor,

        padding: EdgeInsets.only(left: 20,top: 20,bottom: 20),
        child: Column(
          children: <Widget>[
            commonHeaderAndSeeAll(headerName: appRecommendJobs, seeAllClick: (){
              controller.openRecommendJobPage();
            },isShowViewAll: recommendJob.length > 4 ? true : false),
            SizedBox(height: 15,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(()=>Wrap(
                spacing: 10,
                children: List.generate(recommendJob.length>4?4:recommendJob.length??0, (index){
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == (recommendJob.length > 4 ? 3 : recommendJob.length - 1) ? 20.0 : 0.0,
                    //  right: index == recommendJob.length - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                    ),
                    child: commonCardWidget(context,
                        cardWidth: MediaQuery.of(context).size.width*0.8,
                        onClick: (){
                          controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                        },
                        image:  recommendJob[index].profile??"",
                        jobProfileName: capitalizeFirstLetter(recommendJob[index].jobTitle??""),
                        companyName: capitalizeFirstLetter(recommendJob[index].countryName??""),
                        salaryDetails: recommendJob[index].salaryName??"",
                        expDetails: recommendJob[index].experienceName??"",
                        programmingList: recommendJob[index].skill??[],
                        isExpanded: controller.isExpanded.value,
                        isApplied: recommendJob[index].apply??false,
                        onExpandChanged: () {
                          controller.isExpanded.value=!controller.isExpanded.value;
                        },
                        location: generateLocation(cityName: recommendJob[index].cityName??"", stateName: recommendJob[index].stateName??"", countryName: recommendJob[index].countryName??""),
                        timeAgo: calculateTimeDifference(createDate:  recommendJob[index].createDate??""),
                        isApplyClick: () {
                          controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                        }

                    ),
                  );
                }),
              )),
            ),
          ],
        ),
      ):Container();
    });
  }

  _jobsForYouWidget(context) {
    return Obx((){
      if(controller.userHomeModel.value==null){
        ///Add simmer
        return Center();
      }
      var jobForYou=controller.userHomeModel.value.data?.jobForYou??[];
      return jobForYou!=null&&jobForYou.isNotEmpty?Obx((){
        var jobList=controller.userHomeModel.value.data?.jobForYou??[];
        return Container(
          color: appWhiteColor,
          padding: EdgeInsets.only(left: 20,top: 5,bottom: 20),
          child: Column(
            children: <Widget>[
              commonHeaderAndSeeAll(headerName: appJobsForYou, seeAllClick: (){
                controller.openRecommendJobPage(isJobForYou: true,);
              },isShowViewAll: jobList.length>4?true:false),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Wrap(
                  spacing: 10,
                  children: List.generate(jobList.length>4?4:jobList.length, (index){
                    //controller.location.value="${jobList[index].cityName??""}, ${jobList[index].stateName??""}, ${jobList[index].companyName??""}";
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index == (jobList.length > 4 ? 3 : jobList.length - 1) ? 20.0 : 0.0
                       // right: index == jobList.length - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                      ),
                      child: commonCardWidget(context,
                          cardWidth: MediaQuery.of(context).size.width*0.8,
                          onClick: (){
                            controller.openJobDetailsPage( jobTitle: jobList[index].slug ??"");
                          },
                          image:   jobList[index].profile??"",
                          jobProfileName: capitalizeFirstLetter(jobList[index].jobTitle??""),
                          companyName: capitalizeFirstLetter(jobList[index].companyName??""),
                          salaryDetails: jobList[index].salaryName??"",
                          expDetails:  jobList[index].experienceName??"",
                          programmingList: jobList[index].skill??[],
                          isExpanded: controller.isExpanded.value,
                          isApplied: jobList[index].apply??false,
                          onExpandChanged: () {
                            controller.isExpanded.value=!controller.isExpanded.value;
                          },
                          location: generateLocation(cityName: jobList[index].cityName??"", stateName: jobList[index].stateName??"", countryName: jobList[index].countryName??""),
                          timeAgo: calculateTimeDifference(createDate: jobList[index].createDate??""), isApplyClick: () {  }

                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }):Container();
    });
  }

  _completeProfileForBetterSearch(context) {
    return Container(
      color: appWhiteColor,
      padding: EdgeInsets.only(left: 20,top: 15,bottom: 20),
      child: Column(
        children: <Widget>[
          commonHeaderAndSeeAll(headerName: appCompleteYourProfileForBetterReach, seeAllClick: (){

          },isShowViewAll: false),
          SizedBox(height: 10,),
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Obx((){
               var unCompleteProfile=controller.userHomeModel.value.data?.userDetail?.uncomplete??[];
               return Wrap(
                 spacing: 15,
                 children: List.generate(unCompleteProfile.length??0, (index){
                   return  Padding(
                     padding: EdgeInsets.only(
                       right: index == unCompleteProfile.length - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                     ),
                     child: betterReachWidget(
                         context,
                         headerText: unCompleteProfile[index],
                         profileCompletePercentage:"3",// controller.userProfileComplatationPercentage.value[index]??"",
                         onCardClick: (String data){

                           controller.unCompletedProfileWidget(data: data);

                         }
                     ),
                   );
                 }),
               );
             }),
           )
        ],
      ),
    );
  }

  _topCompanies() {
    return Obx((){
      if(controller.userHomeModel.value.data?.topIndustries==null){
        ///For Simmer
        return Center();
      }
      var topCompanies=controller.userHomeModel.value.data?.topIndustries??[];
      return

        topCompanies!=null&&topCompanies.isNotEmpty?Container(
        color: appPrimaryBackgroundColor,
        padding: EdgeInsets.only(left: 20,top: 15,bottom: 20),
        child: Column(
          children: <Widget>[
            commonHeaderAndSeeAll(headerName: appTopCompanies, seeAllClick: (){
              controller.openTopCompaniesPage();
            },isShowViewAll: topCompanies.length > 4 ? true : false),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 20,
                children: List.generate(topCompanies.length>4?4:topCompanies.length, (index){
                  var allTopCompanyList=topCompanies[index].images??[];
                  return  Padding(
                    padding: EdgeInsets.only(
                      right: index == (topCompanies.length > 4 ? 3 : topCompanies.length - 1) ? 20.0 : 0.0,
                      //right: index == topCompanies.length - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                    ),
                    child: topCompaniesWidget(jobTypeName: topCompanies[index].name??'', numberOfCompany: topCompanies[index].industryCount??'', allCompanyIcon: allTopCompanyList??[]),
                  );
                }),
              ),
            )
          ],
        ),
      ):Container();
    });
  }

  Widget _profileWidget(BuildContext context) {
    return Obx(() {
      final userDetail = controller.userHomeModel.value.data?.userDetail;

      // Handle null user data gracefully
      if (userDetail == null) {
        return Container(); // Show a placeholder or shimmer effect
      }

      final profileFName = userDetail.fName ?? "";
      final profileLName = userDetail.lName ?? "";
      final profileLImage = userDetail.profile ?? "";
      final profilePercentageText = userDetail.profilePercentage ?? "";
      final profileLPercentage = (double.tryParse(profilePercentageText.toString()) ?? 0.0) / 100;

      return GestureDetector(
        onTap: (){
          final myController = Get.find<BottomNavBarController>();
          myController.bottomNavCurrentIndex.value = 4;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: appPrimaryColor,
            border: Border.all(color: appBlackColor,width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProfileText(profileFName, profileLName),
              _buildProfileImage(profileLImage,"$profileFName $profileLName", profileLPercentage, profilePercentageText.toString()),
            ],
          ),
        ),
      );
    });
  }



// User's name and greeting message
  Widget _buildProfileText(String fName, String lName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fName.isNotEmpty || lName.isNotEmpty)
          Text(
            "Hi, $fName $lName!",
            style: AppTextStyles.font20W700.copyWith(color: appWhiteColor),
          ),
        const SizedBox(height: 5),
        Text(
          appReadyToJumpBack,
          style: AppTextStyles.font16.copyWith(color: appWhiteColor),
        ),
      ],
    );
  }

// Circular Profile Image with Progress Indicator
  Widget _buildProfileImage(String imageUrl,String initialName, double percentage, String percentageText,{double height=56.0,double width=56,double radius=30.0}) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: radius,
          lineWidth: 2.0,
          percent: percentage,
          center: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: commonImageWidget(image: imageUrl, initialName: initialName, height: height, width: width, borderRadius: 100,isBorderDisable: true),
            // child: imageUrl.isNotEmpty
            //     ? Image.network(imageUrl, fit: BoxFit.cover, height: height, width: width)
            //     : Image.asset(appDummyProfile, fit: BoxFit.cover, height: height, width: width),
          ),
          progressColor: Colors.green,
        ),
        Positioned(
          bottom: -4,
          right: 8,
            child: Container(
              alignment: Alignment.center,
              height: 18,
              width: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: appWhiteColor,
              ),
              child: Text(
                "$percentageText%",
                style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
              ),
            ),
        ),
      ],
    );
  }

  _verifyProfileClamNow( context) {
    return Obx((){
      final userDetail = controller.userHomeModel.value.data?.userDetail;

      // Handle null user data gracefully
      if (userDetail == null) {
        return Container(); // Show a placeholder or shimmer effect
      }

      final profileFName = userDetail.fName ?? "";
      final profileLName = userDetail.lName ?? "";
      final profileLImage = userDetail.profile ?? "";
      final profilePercentageText = userDetail.profilePercentage ?? "";
      final profileLPercentage = (double.tryParse(profilePercentageText.toString()) ?? 0.0) / 100;

      return profileLPercentage<75?Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: EdgeInsets.only(left: 10,top: 14,bottom: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  appPrimaryColor,
                  appPrimaryColor
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text(appVerifyYourProfileToClaim,style: AppTextStyles.font16W700.copyWith(color: appWhiteColor),)),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: <Widget>[
                      commonImageWidget(
                          image: profileLImage??"",
                          initialName: profileFName??"",
                          height: 66,
                          width: 66,
                          borderRadius: 100
                      ),
                      Positioned(
                        right: -4,
                        child: SvgPicture.asset(appVerifiedIcon,height: 30,width: 30,),
                      )
                    ],
                  ),
                ),

              ],
            ),
            GestureDetector(
              onTap: (){
                final BottomNavBarController controller = Get.find<BottomNavBarController>();
                controller.bottomNavCurrentIndex.value=4;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: appWhiteColor
                ),
                child:  Text(appVerifyNow,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
              ),
            )
          ],
        ),
      ):Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: EdgeInsets.only(left: 10,top: 14,bottom: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  appPrimaryColor,
                  appPrimaryColor
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Column(
                 children: <Widget>[
                   SizedBox(
                       width: MediaQuery.of(context).size.width*0.65,
                       child: Text(appYouAreATopCandidate,style: AppTextStyles.font16W700.copyWith(color: appWhiteColor),)),
                   SizedBox(
                       width: MediaQuery.of(context).size.width*0.62,
                       child: Text(appOnAverageVerifiedMembers,style: AppTextStyles.font12w500.copyWith(color: appWhiteColor),)),

                 ],
               ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: <Widget>[
                      _buildProfileImage(
                          profileLImage, "$profileFName $profileLName",profileLPercentage,
                          profilePercentageText.toString(),
                          height: 66,
                          width: 66,
                        radius: 32.0
                      ),
                      // commonImageWidget(
                      //     image: profileLImage??"",
                      //     initialName: profileFName??"",
                      //     height: 66,
                      //     width: 66,
                      //     borderRadius: 100
                      // ),
                      Positioned(
                        right: -10,
                        child: SvgPicture.asset(appVerifiedIcon,height: 30,width: 30,),
                      )
                    ],
                  ),
                ),

              ],
            ),
            GestureDetector(
              onTap: (){
                final BottomNavBarController controller = Get.find<BottomNavBarController>();
                controller.bottomNavCurrentIndex.value=4;
               },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: appWhiteColor
                ),
                child:  Text(appExploreNow,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
              ),
            )
          ],
        ),
      );
    });
  }




}