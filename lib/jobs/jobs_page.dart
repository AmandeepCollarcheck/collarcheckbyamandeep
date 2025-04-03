import 'package:collarchek/jobs/jobs_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';

class JobsPage extends GetView<JobControllers>{
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
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

                  })),
            ),
            SizedBox(height: 20,),
            Container(
              color: appWhiteColor,
              padding:EdgeInsets.zero,
              child: TabBar(
                labelPadding: EdgeInsets.only(bottom: 10),
                isScrollable: false,
                dividerColor: appWhiteColor,
                indicatorColor: appPrimaryColor,
                indicatorWeight: 2,
                // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller.tabController,
                tabs: List.generate(controller.listTabLabel.length, (index){
                  return Text(controller.listTabLabel[index],style: AppTextStyles.font14.copyWith(color: appBlackColor),);
                }),
              ),
            ),
            Expanded(
              child: Container(
                color: appPrimaryBackgroundColor,
                //height: MediaQuery.of(context).size.height ,
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: <Widget>[

                    _jobForYou(context),
                    _appledJobs(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _jobForYou( context) {
    return  Obx((){
      var allJobs=controller.userRecommendedJobForYou.value.data?.alljobList??[];
      return allJobs.isNotEmpty?SingleChildScrollView(
        child: Container(
            color: appPrimaryBackgroundColor,
            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(()=>RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                        children: [
                          TextSpan(
                            text:  (controller.userRecommendedJobForYou.value.data?.alljobList?.length??0).toString()??"0",
                            style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                          ),
                          TextSpan(
                            text: appJobFound,
                            style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                                // Navigate to Terms of Use page or any action
                              },
                          ),
                        ],
                      ),
                    ),),
                    GestureDetector(
                      onTap: (){
                        openShortItemFilter(context, onShort: (int value) {
                          controller.shortDataList(value: value);
                        });
                      },
                      child: SvgPicture.asset(appShortIconSvg,height: 20,width: 20,),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Obx(() {
                  final jobList = controller.userRecommendedJobForYou.value.data?.alljobList ?? [];
                  return Wrap(
                    runSpacing: 10,
                    children: List.generate(jobList.length, (index) {
                      return jobList.isNotEmpty?commonCardWidget(
                        context,
                        cardWidth: MediaQuery.of(context).size.width,
                        onClick: () {
                          controller.openJobDetails(jobTitle: jobList[index].slug ??"",);
                        },
                        image: jobList[index].profile ??"",
                        jobProfileName: jobList[index].departmentName ?? "",
                        companyName: jobList[index].companyName ?? "",
                        salaryDetails: jobList[index].salaryName ?? "",
                        expDetails: jobList[index].experienceName ?? "",
                        programmingList: controller.isExpanded.value?jobList[index].skill??[]:jobList[index].skill!.take(3).toList(),
                        isExpanded: controller.isExpanded.value,
                        onExpandChanged: () {
                          controller.isExpanded.value = !controller.isExpanded.value;
                        },
                        location: generateLocation(cityName: jobList[index].cityName ?? "", stateName: jobList[index].stateName ?? "", countryName: jobList[index].countryName ?? ""),//jobList[index].experienceName ?? "",
                        timeAgo: calculateTimeDifference(createDate: jobList[index].createDate ?? ""), isApplyClick: () {  },
                      ):Container(
                        child: Center(
                            child: Text("jh")
                        ),
                      );
                    }),
                  );
                })

              ],
            )
        ),
      ):SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
        )
      );
    });
  }

  _appledJobs(context) {
    return  Obx((){
      var allAppliedJob=controller.appliedJobs.value.data?.jobsApplieds??[];
      return allAppliedJob.isNotEmpty?SingleChildScrollView(
        child: Container(
            color: appPrimaryBackgroundColor,
            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(()=>RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                        children: [
                          TextSpan(
                            text:  (controller.appliedJobs.value.data?.jobsApplieds?.length??0).toString()??"0",
                            style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                          ),
                          TextSpan(
                            text: appJobFound,
                            style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                                // Navigate to Terms of Use page or any action
                              },
                          ),
                        ],
                      ),
                    ),),
                    GestureDetector(
                      onTap: (){
                        openShortItemFilter(context, onShort: (int value) {
                          controller.shortDataList(value: value);
                        });
                      },
                      child: SvgPicture.asset(appShortIconSvg,height: 20,width: 20,),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Obx(() {
                  final jobList = controller.appliedJobs.value.data?.jobsApplieds ?? [];

                  return Wrap(
                    runSpacing: 10,
                    children: List.generate(jobList.length, (index) {
                      return jobList.isNotEmpty?appliedCommonCardWidget(
                        context,
                        cardWidth: MediaQuery.of(context).size.width,
                        onClick: () {
                          controller.openJobDetails(jobTitle: jobList[index].slug ??"",);
                        },
                        image: jobList[index].profile ??"",
                        jobProfileName: jobList[index].jobTitle ?? "",
                        companyName: jobList[index].industryName ?? "",
                        salaryDetails: jobList[index].salaryName ?? "",
                        expDetails: jobList[index].experienceName ?? "",
                        // programmingList: controller.isExpanded.value?jobList[index].skill??[]:jobList[index].skill!.take(3).toList(),
                        isExpanded: controller.isExpanded.value,
                        onExpandChanged: () {
                          controller.isExpanded.value = !controller.isExpanded.value;
                        },
                        location: generateLocation(cityName: jobList[index].cityName ?? "", stateName: jobList[index].stateName ?? "", countryName: jobList[index].countryName ?? ""),//jobList[index].experienceName ?? "",
                        //timeAgo: calculateTimeDifference(createDate: jobList[index].createDate ?? ""), isApplyClick: () {  },
                      ):Container(
                        child: Center(
                            child: Text("jh")
                        ),
                      );
                    }),
                  );
                })

              ],
            )
        ),
      ):SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
          )
      );
    });
  }

}