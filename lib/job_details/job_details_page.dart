import 'package:collarchek/job_details/job_details_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';

class JobDetailesPage extends GetView<JobDetailsControllers>{
  const JobDetailesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: appScreenBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                commonActiveSearchBar(
                    onClick: (){
                      Get.back();
                    },
                    onShareClick: (){},
                    onFilterClick: (){},
                    leadingIcon: appBackIcon,
                    isShowShare: true,
                    screenName: "",
                    actionButton: ""
                ),
                _jobProfileDetails(context),
                SizedBox(height: 10,),
                ///Tab widget
                Divider(color: appPrimaryBackgroundColor,thickness: 1,),
                Container(
                  color: appWhiteColor,
                  padding:EdgeInsets.zero,
                  child: TabBar(
                    indicatorPadding: EdgeInsets.zero,
                    isScrollable: true,
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
                SizedBox(height: 10,),
                Obx((){
                  var jobDescription=controller.jobDetailsData.value.data?.detail?.jobDescription??"";
                  var roleResponsibility=controller.jobDetailsData.value.data?.detail?.rolesResponsibility??"";
                  return Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    color: appWhiteColor,
                    key: controller.tabViewKey,
                    height: controller.tabViewHeight,
                    //margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                    //color: appWhiteColor,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.tabController,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Text(controller.jobDescriptionTitle[0],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                            SizedBox(height: 5,),
                            HtmlWidget(jobDescription??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                            // Text(jobDescription??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                            SizedBox(height: 10,),
                            Text(controller.jobDescriptionTitle[1],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                            SizedBox(height: 5,),
                            HtmlWidget(roleResponsibility??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                            //Text(roleResponsibility??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                          ],
                        ),


                        ///Required Skills
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(appRequiredSkills,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                            SizedBox(height: 20,),
                            Obx((){
                              var skills=controller.jobDetailsData.value.data?.detail?.skill??[];
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, // 3 items per row
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    // childAspectRatio: 8,
                                    mainAxisExtent: 26// Adjust size of items
                                ),
                                itemCount: skills.length??0, // Add "More" button if collapsed
                                itemBuilder: (context, index) {

                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: appWhiteColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: appPrimaryColor,width: 1)
                                    ),
                                    child: Text(skills[index].name??'', style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor)),
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                        ///Job Info
                        Obx((){
                          var createdDate=controller.jobDetailsData.value.data?.detail?.createDate??"";
                          var applicationCount=controller.jobDetailsData.value.data?.detail?.applicationCount??"";
                          var location =generateLocation(cityName: controller.jobDetailsData.value.data?.detail?.cityName??"", stateName: controller.jobDetailsData.value.data?.detail?.stateName??"", countryName: controller.jobDetailsData.value.data?.detail?.countryName??"");
                          var industry =controller.jobDetailsData.value.data?.detail?.industryName??"";
                          var department =controller.jobDetailsData.value.data?.detail?.departmentName??"";
                          var designation =controller.jobDetailsData.value.data?.detail?.designationName??"";
                          var salary =controller.jobDetailsData.value.data?.detail?.salaryName??"";
                          var experience =controller.jobDetailsData.value.data?.detail?.experienceName??"";
                          //var industry =controller.jobDetailsData.value.data?.detail?.w??"";
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(appJonInformation,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                                SizedBox(height: 20,),
                                Column(
                                  children: <Widget>[
                                    jonInfoCard(context,icon1: appDatePostedIcon, header1: appDataPosted, description1: calculateTimeDifference(createDate: createdDate), icon2: appExperienceIcon, header2: appNoOfVacancies, description2: applicationCount??""),
                                    SizedBox(height: 10,),
                                    jonInfoCard(context,icon1: appLocationsIcon, header1: appLocation, description1: location??'', icon2: appIndustryIcon, header2: appIndustry, description2: industry??''),
                                    SizedBox(height: 10,),
                                    jonInfoCard(context,icon1: appExperienceIcon, header1: appDepartment, description1: department??'', icon2: appDesignationIcon, header2: appDesignation, description2: designation??''),
                                    SizedBox(height: 10,),
                                    jonInfoCard(context,icon1: appSalaryIcon, header1: appSalary, description1: salary??'', icon2: appExperienceIcon, header2: appExperience, description2: experience??''),
                                    SizedBox(height: 10,),
                                    jonInfoCard(context,icon1: appWebsiteIcon, header1: appWebsite, description1: 'www.google.com', icon2: "", header2: "", description2: ''),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
            
                SizedBox(height: 10,),
                _showSimilarJobs(context),
                SizedBox(height: 20,),
                allRightReservedWidget()
              ],
            ),
          ),
        )
    );
  }

  _jobProfileDetails(context) {
    return Obx((){
      var jobModeName=controller.jobDetailsData.value.data?.detail?.jobModeName??"";
      var applicationCount=controller.jobDetailsData.value.data?.detail?.applicationCount??"";
      var cityName=controller.jobDetailsData.value.data?.detail?.cityName??"";
      var stateName=controller.jobDetailsData.value.data?.detail?.stateName??"";
      var countryName=controller.jobDetailsData.value.data?.detail?.countryName??"";
      var createdAtData=controller.jobDetailsData.value.data?.detail?.createDate??"";

      return Container(
        margin: EdgeInsets.only(left: 15,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _profileDetails(context,image: appCompanyImage),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                jobModeName!=null&&jobModeName.isNotEmpty?Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appPrimaryBackgroundColor
                  ),
                  child: Text(jobModeName,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                ):Container(),
                SizedBox(height: 5,),
                applicationCount!=null&&applicationCount.isNotEmpty?Container(
                  alignment: Alignment.topRight,
                  child: Text("Total No. of Applicants: $applicationCount",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                ):Container()
              ],
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(generateLocation(cityName: cityName??"", stateName: stateName??'', countryName: countryName??''),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,),
                      )
                    ],
                  ),
                  Text(calculateTimeDifference(createDate: createdAtData),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                ],
              ),
            )

          ],
        ),
      );
    });
  }

  _profileDetails(context,{required String image}) {
    var jobProfile=controller.jobDetailsData.value.data?.detail?.jobTitle??"";
    var companyName=controller.jobDetailsData.value.data?.detail?.companyName??"";
    var salaryName=controller.jobDetailsData.value.data?.detail?.salaryName??"";
    var experienceName=controller.jobDetailsData.value.data?.detail?.experienceName??"";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image.endsWith(".svg")?SvgPicture.network(image,height: 66,width: 66,errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 66);
          },):image.contains("https")?Image.network(image,height: 66,width: 66,errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 66);
          },):Image.asset(image,height: 66,width: 66,errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 66);
          },),
        ),
        SizedBox(width: 5,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width:MediaQuery.of(context).size.width*0.70,
              child:  Text(jobProfile,style: AppTextStyles.font20W700.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width*0.70,
              child:  Text(companyName,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),overflow: TextOverflow.clip,maxLines: 3,),
            ),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                salaryName!=null&&salaryName.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appSalarySvgIcon,height: 15,width: 15,),
                    SizedBox(width: 2,),
                    Text(salaryName??"",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                  ],
                ):Container(),
                SizedBox(width: 5,),
                (salaryName!=null&&salaryName.isNotEmpty)||( experienceName!=null&&experienceName.isNotEmpty)?Container(
                  height: 18,
                  width: 1,
                  color: appGreyBlackColor,
                ):Container(),
                SizedBox(width: 5,),
                experienceName!=null&&experienceName.isNotEmpty?Row(
                  children: <Widget>[
                    Image.asset(appExperienceIcon,height: 15,width: 15,),
                    SizedBox(width: 2,),
                    Text(experienceName??"",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                  ],
                ):Container(),
              ],
            )
          ],
        )
      ],
    );
  }



  _showSimilarJobs(context) {
    return Obx((){
      var jobList= controller.jobDetailsData.value.data?.jobList??[];
      return jobList!=null&&jobList.isNotEmpty?Container(
        color: appPrimaryBackgroundColor,
        padding: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: Column(
          children: <Widget>[
            commonHeaderAndSeeAll(headerName: appSimilarJobs, seeAllClick: (){

            },isShowViewAll: false),
            SizedBox(height: 15,),
            Wrap(
              runSpacing: 10,
              children: List.generate(jobList.length??0, (index){
                return commonCardWidget(context,
                    onClick: (){
                      controller.getJobDetailsApiData(jobName: jobList[index].slug??'');
                      //controller.openJobDetails();sss
                    },
                    cardWidth: MediaQuery.of(context).size.width,
                    image: appCompanyImage,
                    jobProfileName: capitalizeFirstLetter(jobList[index].jobTitle??""),
                    companyName: capitalizeFirstLetter(jobList[index].companyName??""),
                    salaryDetails: jobList[index].salaryName??"",
                    expDetails: jobList[index].experienceName??"",
                    programmingList: jobList[index].skill??[],
                    isExpanded: controller.isExpanded.value,
                    onExpandChanged: () {
                      controller.isExpanded.value=!controller.isExpanded.value;
                    },
                    location: generateLocation(cityName: jobList[index].cityName??"", stateName: jobList[index].stateName??"", countryName: jobList[index].countryName??""),
                    timeAgo: calculateTimeDifference(createDate: jobList[index].createDate??""),
                    isApplied: jobList[index].apply??false,
                    isApplyClick: () {
                      controller.getJobDetailsApiData(jobName: jobList[index].slug??'');
                    }

                );
              }),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ):Container();
    });
  }

}