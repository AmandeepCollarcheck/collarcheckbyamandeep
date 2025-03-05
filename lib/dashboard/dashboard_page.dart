import 'package:collarchek/dashboard/dashboard_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

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
                    onSearchIconClick: (bool isSearchClick) {
                      controller.isSearchActive.value=isSearchClick;
                    })),
              ),
              SizedBox(height: 20,),
              _recommendJobsWidget(context),
              _completeProfileForBetterSearch(),
              _jobsForYouWidget(context),
              _topCompanies(),
              allRightReservedWidget()

            ],
          ),
        ),
      ),
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
            }),
            SizedBox(height: 15,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(()=>Wrap(
                spacing: 10,
                children: List.generate(recommendJob.length??0, (index){
                  return commonCardWidget(context,
                      cardWidth: MediaQuery.of(context).size.width*0.9,
                      onClick: (){
                        controller.openJobDetailsPage( jobTitle: recommendJob[index].slug ??"");
                      },
                      image:  recommendJob[index].profile??appCompanyImage,
                      jobProfileName: capitalizeFirstLetter(recommendJob[index].jobTitle??""),
                      companyName: capitalizeFirstLetter(recommendJob[index].countryName??""),
                      salaryDetails: recommendJob[index].salaryName??"",
                      expDetails: recommendJob[index].experienceName??"",
                      programmingList: recommendJob[index].skill??[],
                      isExpanded: controller.isExpanded.value,
                      onExpandChanged: () {
                        controller.isExpanded.value=!controller.isExpanded.value;
                      },
                      location: generateLocation(cityName: recommendJob[index].cityName??"", stateName: recommendJob[index].stateName??"", countryName: recommendJob[index].countryName??""),
                      timeAgo: calculateTimeDifference(createDate:  recommendJob[index].createDate??""),
                      isApplyClick: () {  }

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
              }),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Wrap(
                  spacing: 10,
                  children: List.generate(jobList.length>4?4:jobList.length, (index){
                    controller.location.value="${jobList[index].cityName??""}, ${jobList[index].stateName??""}, ${jobList[index].companyName??""}";
                    return commonCardWidget(context,
                        cardWidth: MediaQuery.of(context).size.width*0.9,
                        onClick: (){
                          controller.openJobDetailsPage( jobTitle: jobList[index].slug ??"");
                        },
                        image:   jobList[index].profile??appCompanyImage,
                        jobProfileName: capitalizeFirstLetter(jobList[index].jobTitle??""),
                        companyName: capitalizeFirstLetter(jobList[index].companyName??""),
                        salaryDetails: jobList[index].salaryName??"",
                        expDetails:  jobList[index].experienceName??"",
                        programmingList: jobList[index].skill??[],
                        isExpanded: controller.isExpanded.value,
                        onExpandChanged: () {
                          controller.isExpanded.value=!controller.isExpanded.value;
                        },
                        location: capitalizeFirstLetter(controller.location.value),
                        timeAgo: calculateTimeDifference(createDate: jobList[index].createDate??""), isApplyClick: () {  }

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

  _completeProfileForBetterSearch() {
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
             child: Wrap(
               spacing: 20,
               children: List.generate(10, (index){
                 return  betterReachWidget(headerText: 'Verify your Email Address ', profileCompletePercentage: '3');
               }),
             ),
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
      return topCompanies!=null&&topCompanies.isNotEmpty?Container(
        color: appPrimaryBackgroundColor,
        padding: EdgeInsets.only(left: 20,top: 15,bottom: 20),
        child: Column(
          children: <Widget>[
            commonHeaderAndSeeAll(headerName: appTopCompanies, seeAllClick: (){
              controller.openTopCompaniesPage();
            }),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 20,
                children: List.generate(topCompanies.length??0, (index){
                  var allTopCompanyList=topCompanies[index].images??[];
                  return  topCompaniesWidget(jobTypeName: topCompanies[index].name??'', numberOfCompany: topCompanies[index].industryCount??'', allCompanyIcon: allTopCompanyList??[]);
                }),
              ),
            )
          ],
        ),
      ):Container();
    });
  }



}