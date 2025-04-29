import 'package:collarchek/recommendJobs/recommend_job_controller.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class RecommendJobPage extends GetView<RecommendJobController>{
  const RecommendJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Obx(()=>commonActiveSearchBar(
                    leadingIcon: appBackSvgIcon,
                    screenName: controller.isJobForYou.value?appJobsForYou:appRecommendJobs,
                    isFilterShow: true,
                    actionButton: appFilterMore,
                    onClick: (){
                      controller.backButtonClick();
                    },
                    onShareClick: (){},
                    onFilterClick:(){
                      controller.clickFilterButton();
                    },
                    isScreenNameShow: true,
                    isShowShare: false
                )),
                Obx((){
                  var data=controller.userRecommendedJobForYou.value.data?.alljobList??[];
                  return data.isNotEmpty?Container(
                    // color: appPrimaryBackgroundColor,
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
                                    controller.openJobDetails(jobTitle: jobList[index].slug ??"");
                                  },
                                  image: jobList[index].profile ??"",
                                  jobProfileName: jobList[index].jobTitle ?? "",
                                  companyName: jobList[index].companyName ?? "",
                                  salaryDetails: jobList[index].salaryName ?? "",
                                  expDetails: jobList[index].experienceName ?? "",
                                  programmingList: controller.isExpanded.value?jobList[index].skill??[]:jobList[index].skill!.take(3).toList(),
                                  isExpanded: controller.isExpanded.value,
                                  onExpandChanged: () {
                                    controller.isExpanded.value = !controller.isExpanded.value;
                                  },
                                  location: generateLocation(cityName: jobList[index].cityName??"", stateName: jobList[index].stateName??"", countryName: jobList[index].countryName??""),
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
                  ):Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Center(
                      child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}