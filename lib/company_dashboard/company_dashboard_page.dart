import 'package:collarchek/company_dashboard/company_dashboard_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/common_widget/add_new_job_model_sheet.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_image_widget.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart' show AppTextStyles;
import '../utills/image_path.dart';

class CompanyDashboardPage extends GetView<CompanyDashboardControllers>{
  const CompanyDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appPrimaryBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ///Search Widget
                Container(
                  color: appWhiteColor,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Obx(()=>commonCompanySearchAppBar(
                      context,controller: controller.searchController,
                      actionButtonOne: appNotificationSVGIcon,
                      actionButtonTwo: appSearchIcon,
                      isSearchActive: controller.isSearchActive.value,
                      onChanged: (value){
                        // controller.openSearchScreen(context);
            
                      },
                      onAddEmployment: (){
                        //addNewJobForm(context, companyAllDetails: controller.designationListData.value);
                      },
                      onTap: (){
                        controller.openSearchScreen(context);
                      },
                      onSearchIconClick: (bool isSearchClick) {
                        controller.isSearchActive.value=isSearchClick;
            
                      })),
                ),
                Container(height: 10,color: appWhiteColor,),
                Column(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [appPrimaryColor,appBlueColor])
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Obx((){
                                        var profileData=controller.companyUserDetails.value.data;
                                        var companyName=profileData?.companyName??"";
                                        var initialName=profileData?.companyName??"";
                                        var profile=profileData?.profile??"";
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ///User name and profile image widget
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "$appHi,",
                                                          style: AppTextStyles.font20w500.copyWith(color: appWhiteColor),
                                                        ),
                                                        TextSpan(
                                                          text: ' $companyName !',
                                                          style: AppTextStyles.font20W700.copyWith(color: appWhiteColor),
                                                        ),
                                                      ],
                                                    ),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),

                                                  Text(appReadyToJumpBack,style: AppTextStyles.font16.copyWith(color: appWhiteColor),maxLines: 3,),
                                                ],
                                              ),
                                            ),
                                            commonImageWidget(image: profile??"", initialName: initialName??"", height: 60, width: 60, borderRadius: 14),
                                          ],
                                        );
                                      }),
                                      SizedBox(height: 30,),
                                      ///Number of count widget
                                      Obx((){
                                        var staticsData=controller.companyStaticsDetails.value.data;
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                _commonCardWidget(context,cardHeader: appPostedJobs, itemNumber: staticsData?.postedJobs.toString()??"0", itemNumberColor: appPrimaryColor, cardIcon: appCurrentEmploueeIcon),
                                                SizedBox(width: 12,),
                                                _commonCardWidget(context,cardHeader: appCurrentEmployees, itemNumber:  staticsData?.currentEmployies.toString()??"0", itemNumberColor: appSkyBlueColor, cardIcon: appCurrentEmploueeIcon)
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                _commonCardWidget(context,cardHeader: appApplication, itemNumber:  staticsData?.applications.toString()??"0", itemNumberColor: appBlueColor, cardIcon: appCurrentEmploueeIcon),
                                                SizedBox(width: 12,),
                                                _commonCardWidget(context,cardHeader: appEmployeeRequests, itemNumber:  staticsData?.followRequests?.length.toString()??"0", itemNumberColor: appLightYellowColor, cardIcon: appCurrentEmploueeIcon)
                                              ],
                                            ),
                                          ],
                                        );
                                      })
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),

                                ///Complete Your Profile Widget
                                _completeProfileForBetterSearch(context),
                                ///Employment Request
                                _employmentRequest(context),
                                Container(
                                  
                                  padding: EdgeInsets.all(20),
                                 color: appPrimaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.72,
                                            child: Text(appAddYourPreference,style: AppTextStyles.font12w500.copyWith(color: appWhiteColor),),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: appWhiteColor,width: 1)
                                            ),
                                            child: Text(appFindImmediateJoiners,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
                                          )
                                        ],
                                      ),
                                      commonImageWidget(image: "", initialName: "initialName", height: 60, width: 60, borderRadius: 14)
                                    ],
                                  ),
                                ),
                                ///All Application
                                _allApplicationList(context),
                                ///Most Viewed Jod
                                _mostViewedJobs(context),
                                /// Pending Employee Review
                                _pendingEmployeeReview(context),
                                ///recommended employees
                                _recommendedEmployees(context),
                                ///Spotlight your work culture
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [appPrimaryColor,appBlueColor])
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      commonImageWidget(image: "", initialName: "initialName", height: 66, width: 66, borderRadius: 14),
                                      SizedBox(width: 10,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.66,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(appSpotlightYourWorkCulture,style: AppTextStyles.font18w700.copyWith(color: appWhiteColor),),
                                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: AppTextStyles.font12w500.copyWith(color: appWhiteColor),),
                                            SizedBox(height: 10,),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: appWhiteColor,width: 1)
                                              ),
                                              child: Text(appAddYourCulture,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
                                            )

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ///People who reciently joined
                                _peopleWhoRecentlyJoined(context),
                                ///Save Condidate
                                //_savedCandidate(context),
                                ///_all Right resirved
                                _allRightReserved(context)



                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

  _commonCardWidget(
      context, {
        required cardHeader,
        required itemNumber,
        required Color itemNumberColor,
        required String cardIcon,
      }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 5),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cardHeader,
            style: AppTextStyles.font12.copyWith(color: appBlackColor),
            maxLines: 3,
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                itemNumber,
                style: AppTextStyles.font22w700.copyWith(color: itemNumberColor),
                maxLines: 3,
              ),
              cardIcon.contains(".svg")
                  ? SvgPicture.asset(cardIcon, height: 30, width: 30)
                  : Image.asset(cardIcon, height: 30, width: 30),
            ],
          ),
        ],
      ),
    );
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
              var unCompleteProfile=controller.companyUserDetails.value.data?.uncomplete??[];
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

                          controller.unCompletedProfileWidget(context,data: data);

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

  _employmentRequest(context) {
    return Obx((){
      var employmentListData=controller.companyStaticsDetails.value.data?.employementRequestList??[];
      if(employmentListData==null){
        ///Add simmer
        return Center();
      }

      return employmentListData!=null&&employmentListData.isNotEmpty?Obx((){
        return Container(
          color: appWhiteColor,
          padding: EdgeInsets.only(left: 10,bottom: 5),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: commonHeaderAndSeeAll(headerName: appEmployeeRequests, seeAllClick: (){
                  //controller.openRecommendJobPage(isJobForYou: true,);
                }),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Row(
                  children: List.generate(4/*jobList.length>4?4:jobList.length*/, (index){
                    //controller.location.value="${jobList[index].cityName??""}, ${jobList[index].stateName??""}, ${jobList[index].companyName??""}";
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == employmentListData.length - 1 ? 20.0 : 0.0, // ✅ Add padding to last index
                      ),
                      child: companyEmploymentRequestWidget(context,
                        profileImage: ''??"",
                        initialName:"Satyam Shukla ",
                        userName: "Satyam Shukla ",
                        ccId: "CCyeuue788"??'',
                        dataPosted: "asknfsjdjf",
                        designation: "Software Enginner",
                        onClick: () {
                          print("On click wor,");
                        },
                        jobStatus: 'Employment',
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

  _allApplicationList(context) {
    return Obx((){
      if(controller.companyStaticsDetails.value==null){
        ///Add simmer
        return Center();
      }
      var allApplicationData=controller.companyStaticsDetails.value.data?.allApplicationList??[];
      return allApplicationData!=null&&allApplicationData.isNotEmpty?Obx((){
        return Container(
          color: appPrimaryBackgroundColor,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: commonHeaderAndSeeAll(headerName: appAllApplications, seeAllClick: (){
                  //controller.openRecommendJobPage(isJobForYou: true,);
                }),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Wrap(
                  children: List.generate(10??0, (index){
                    return commonCompanyApplicantWidget(context,
                      profileImage: ""??"",
                      initialName:"Satyam Shukla",
                      userName: "Satyam Shukla",
                      ccId: "CCajksdjasd",
                      ratingStar: '10',
                      buttonName: "",
                      salary: "600 - 100 Lacs PA",
                      experienceYear: "3 years",
                      vaccancy: "12",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Published',
                      noOfVaccency: '10',
                      timeAgo: calculateTimeDifference(createDate:  "21-02-25"??""),
                      locations: 'Delhi, noida, lucknow',
                      email: 'satyam.shuklaasdsgdghsghd@mail.com',
                      phone: '+917705089308',
                      profileDesignation: 'Software Engenners',
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

  _mostViewedJobs(context) {
    return Obx((){
      if(controller.companyStaticsDetails.value==null){
        ///Add simmer
        return Center();
      }
      var mostViewedData=controller.companyStaticsDetails.value.data?.mostAppliedJob??[];
      return mostViewedData!=null&&mostViewedData.isNotEmpty?Container(
        color: appWhiteColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20,top: 15),
              child: commonHeaderAndSeeAll(headerName: appMostViewedJobs, seeAllClick: (){
                //controller.openRecommendJobPage(isJobForYou: true,);
              }),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return  mostViewedJos(
                          context,
                          designation: 'Software Enginner',
                          timeAgo: '8 hrs ago',
                          locations: 'Delhi, Noida',
                          noOfVaccency: '10'
                      );
                    },
                    separatorBuilder:(BuildContext context,int index){
                      return Container(
                        height: 1,color: appPrimaryBackgroundColor,
                      );
                    },
                    itemCount: 2
                )
            )
          ],
        ),
      ):Container();
    });
  }

  _pendingEmployeeReview(context) {
    return Obx((){
      if(controller.companyStaticsDetails.value==null){
        ///Add simmer
        return Center();
      }
      var pendingEmployeeReview=controller.companyStaticsDetails.value.data?.pendingReviewsList??[];
      return pendingEmployeeReview!=null&&pendingEmployeeReview.isNotEmpty?Obx((){
        return Container(
          color: appPrimaryBackgroundColor,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: commonHeaderAndSeeAll(headerName: appPendingEmployeeReviews, seeAllClick: (){
                  //controller.openRecommendJobPage(isJobForYou: true,);
                }),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Wrap(
                  spacing: 10,
                  children: List.generate(10??0, (index){
                    return commonEmployeeReviewWidget(context,
                      profileImage: ""??"",
                      initialName:"Satyam Shukla",
                      userName: "Satyam Shukla",
                      ccId: "CCajksdjasd",
                      ratingStar: '10',
                      buttonName: "",
                      salary: "600 - 100 Lacs PA",
                      experienceYear: "3 years",
                      vaccancy: "12",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Published',
                      noOfVaccency: '10',
                      timeAgo: calculateTimeDifference(createDate:  "21-02-25"??""),
                      locations: 'Delhi, noida, lucknow',
                      email: 'satyam.shuklaasdsgdghsghd@mail.com',
                      phone: '+917705089308',
                      profileDesignation: 'Software Engenners', date: '14 Mar 2025',
                    );
                  }),
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        );
      }):Container();
    });
  }

  _recommendedEmployees(context) {
    return Obx((){
      if(controller.companyStaticsDetails.value==null){
        ///Add simmer
        return Center();
      }
      var recommendedEmployee=controller.companyStaticsDetails.value.data?.recommendedEmployees??[];
      return recommendedEmployee!=null&&recommendedEmployee.isNotEmpty?Container(
        color: appWhiteColor,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: commonHeaderAndSeeAll(headerName: appRecommendedEmployees, seeAllClick: (){
                //controller.openRecommendJobPage(isJobForYou: true,);
              }),
            ),
            SizedBox(height: 15,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Wrap(
                spacing: 10,
                children: List.generate(recommendedEmployee.length??0, (index){
                  return companyRecommendedWidget(context,
                    profileImage: recommendedEmployee[index].profile??"",
                    initialName:recommendedEmployee[index].name??"",
                    userName: recommendedEmployee[index].name??"",
                    ccId: recommendedEmployee[index].individualId??"",
                    location: generateLocation(cityName: recommendedEmployee[index].cityName??"", stateName: recommendedEmployee[index].stateName??"", countryName: recommendedEmployee[index].countryName??"",),
                    designation: recommendedEmployee[index].designationName??"",
                    ratingBar: recommendedEmployee[index].totalRating??"0",
                  );
                }),
              ),
            ),
          ],
        ),
      ):Container();
    });
  }

  _peopleWhoRecentlyJoined(context) {
    return Obx((){
      if(controller.companyStaticsDetails.value==null){
        ///Add simmer
        return Center();
      }
      var recentlyJoinedData=controller.companyStaticsDetails.value.data?.recentJoinList??[];
      return recentlyJoinedData!=null&&recentlyJoinedData.isNotEmpty?Container(
        color: appWhiteColor,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: commonHeaderAndSeeAll(headerName: appPeopleWhoRecentlyJoined, seeAllClick: (){
                //controller.openRecommendJobPage(isJobForYou: true,);
              }),
            ),
            SizedBox(height: 15,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Wrap(
                spacing: 10,
                children: List.generate(recentlyJoinedData.length??0, (index){
                  return recentlyJoinedWidget(context,
                    profileImage: recentlyJoinedData[index].profile??"",
                    initialName:recentlyJoinedData[index].name??"",
                    userName: recentlyJoinedData[index].name??"",
                    ccId: recentlyJoinedData[index].individualId??"",
                    location: 'Delhi, noida, lucknow',
                    designation: recentlyJoinedData[index].designationName??"",
                    ratingBar: '10',
                  );
                }),
              ),
            ),
          ],
        ),
      ):Container();
    });
  }

  _savedCandidate( context) {
    // return Obx((){
    //   if(controller.userHomeModel.value==null){
    //     ///Add simmer
    //     return Center();
    //   }
    //   var jobForYou=controller.userHomeModel.value.data?.jobForYou??[];
    //   return jobForYou!=null&&jobForYou.isNotEmpty?Obx((){
    //     var jobList=controller.userHomeModel.value.data?.jobForYou??[];
    //     return Container(
    //       color: appPrimaryBackgroundColor,
    //       padding: EdgeInsets.all(10),
    //       child: Column(
    //         children: <Widget>[
    //           Padding(
    //             padding: EdgeInsets.only(left: 10),
    //             child: commonHeaderAndSeeAll(headerName: appSavedCandidates, seeAllClick: (){
    //               //controller.openRecommendJobPage(isJobForYou: true,);
    //             }),
    //           ),
    //           SizedBox(height: 15,),
    //           SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child:  Wrap(
    //               spacing: 10,
    //               children: List.generate(10??0, (index){
    //                 return savedCandidates(context,
    //                   profileImage: [appMessageSelectedSvg,appMessageSelectedSvg,appMessageSelectedSvg,appMessageSelectedSvg],
    //                   initialName:"Satyam Shukla",
    //                   designation: 'Software Engenners',
    //                   noOfJobs: '8',
    //                 );
    //               }),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }):Container();
    // });
  }

  _allRightReserved(context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: appWhiteColor,
      child: allRightReservedWidget(),
    );
  }


}