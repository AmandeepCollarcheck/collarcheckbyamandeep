import 'package:collarchek/job_details/job_details_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
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
import '../utills/common_widget/tab_bar_view_dynamic_height.dart';
import '../utills/font_styles.dart';

class JobDetailesPage extends GetView<JobDetailsControllers>{
  const JobDetailesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: appScreenBackgroundColor,
              bottomNavigationBar: _bottomButton(context),
              body: Column(
                children: [
                  commonActiveSearchBar(
                      backGroundColor: appWhiteColor,
                      onClick: (){
                        controller.backButtonClick(context);
                      },
                      onShareClick: (){},
                      onFilterClick: (){},
                      leadingIcon: appBackSvgIcon,
                      isShowShare: true,
                      screenName: "",
                      actionButton: ""
                  ),
                  Expanded(
                      child: NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) {
                            return[
                              SliverToBoxAdapter(
                                child: Container(
                                  color: appScreenBackgroundColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _jobProfileDetails(context),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: Column(
                            children: <Widget>[
                              Divider(color: appPrimaryBackgroundColor,thickness: 1,height: 1,),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20,),
                                color: appWhiteColor,
                                padding:EdgeInsets.zero,
                                child: TabBar(
                                  indicatorPadding: EdgeInsets.zero,
                                  isScrollable: false,
                                  dividerColor: appWhiteColor,
                                  indicatorColor: appPrimaryColor,
                                  indicatorWeight: 2,
                                  labelPadding: EdgeInsets.only(bottom: 10),
                                  // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  controller: controller.tabController,
                                  onTap: (index){
                                    controller.scrollToSection(index);
                                  },

                                  tabs: List.generate(controller.listTabLabel.length, (index){
                                    return Text(controller.listTabLabel[index],style: AppTextStyles.font12.copyWith(color: appBlackColor),);
                                  }),
                                ),
                              ),
                              SizedBox(height: 10,),

                              SingleChildScrollView(
                                  controller: controller.scrollController,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20,right: 20),
                                    child: Column(
                                      children: <Widget>[
                                        ///Job Description
                                        Obx((){
                                          var jobDescription=controller.jobDetailsData.value.data?.detail?.jobDescription??"";
                                          var roleResponsibility=controller.jobDetailsData.value.data?.detail?.rolesResponsibility??"";
                                          return jobDescription.isNotEmpty||roleResponsibility.isNotEmpty?Container(
                                            key: controller.keys[0],
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 10,),
                                                Text(controller.jobDescriptionTitle[0],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                                                SizedBox(height: 5,),
                                                HtmlWidget(jobDescription??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                                // Text(jobDescription??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                                SizedBox(height: 10,),
                                                roleResponsibility!=null&&roleResponsibility.isNotEmpty?Text(controller.jobDescriptionTitle[1],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),):Container(),
                                                SizedBox(height: 5,),
                                                HtmlWidget(roleResponsibility??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                                //Text(roleResponsibility??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),

                                                SizedBox(height: 10,),
                                                _showSimilarJobs(context),
                                                SizedBox(height: 10,),

                                              ],
                                            ),
                                          ):Center(
                                            child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                          );
                                        }),



                                        ///Required Skills
                                        Obx((){
                                          var skills=controller.jobDetailsData.value.data?.detail?.skill??[];
                                          return skills.isNotEmpty?Container(
                                            key: controller.keys[1],
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(appRequiredSkills,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                                                SizedBox(height: 20,),
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 150, // Adjust this value based on max text size
                                                    crossAxisSpacing: 8,
                                                    mainAxisSpacing: 8,
                                                    mainAxisExtent: 26, // Fixed height
                                                  ),
                                                  itemCount: skills.length ?? 0,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: appWhiteColor,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: appPrimaryColor, width: 1),
                                                      ),
                                                      child: Text(
                                                        skills[index].name ?? '',
                                                        style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(height: 10,),
                                                _showSimilarJobs(context),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                          ):Center(
                                            child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                          );
                                        }),

                                        ///Job Info
                                        Container(
                                          key: controller.keys[2],
                                          child:  Obx((){
                                            var createdDate=controller.jobDetailsData.value.data?.detail?.createDate??"";
                                            var applicationCount=controller.jobDetailsData.value.data?.detail?.vacancy??"";
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
                                                      jonInfoCard(context,icon1: appDataPostedIconSvg, header1: appDataPosted, description1: calculateTimeDifference(createDate: createdDate), icon2: appExperenceIconSvg, header2: appNoOfVacancies, description2: applicationCount??""),
                                                      SizedBox(height: 10,),
                                                      jonInfoCard(context,icon1: appLocationsSvgIcon, header1: appLocation, description1: location??'', icon2: appAppIndustoryIconSvg, header2: appIndustry, description2: industry??''),
                                                      SizedBox(height: 10,),
                                                      jonInfoCard(context,icon1: appExperenceIconSvg, header1: appDepartment, description1: department??'', icon2: appDesignationIconSvg, header2: appDesignation, description2: designation??''),
                                                      SizedBox(height: 10,),
                                                      jonInfoCard(context,icon1: appSalaryIconSvg, header1: appSalary, description1: salary??'', icon2: appExperenceIconSvg, header2: appExperience, description2: experience??''),
                                                      SizedBox(height: 10,),
                                                      jonInfoCard(context,icon1: appWebsiteIconSvg, header1: appWebsite, description1: 'www.google.com', icon2: "", header2: "", description2: ''),
                                                      SizedBox(height: 10,),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  _showSimilarJobs(context),
                                                  SizedBox(height: 10,),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),

                                      ],
                                    ),
                                  )
                              ),
                            ],
                          )
                      )
                  )
                ],
              )
            )
        )
    );
  }

  /*SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    commonActiveSearchBar(
                        backGroundColor: appWhiteColor,
                        onClick: (){
                          controller.backButtonClick(context);
                        },
                        onShareClick: (){},
                        onFilterClick: (){},
                        leadingIcon: appBackSvgIcon,
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
                        isScrollable: false,
                        dividerColor: appWhiteColor,
                        indicatorColor: appPrimaryColor,
                        indicatorWeight: 2,
                        labelPadding: EdgeInsets.only(bottom: 10),
                        // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: controller.tabController,
                        tabs: List.generate(controller.listTabLabel.length, (index){
                          return Text(controller.listTabLabel[index],style: AppTextStyles.font12.copyWith(color: appBlackColor),);
                        }),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Obx((){
                      var jobDescription=controller.jobDetailsData.value.data?.detail?.jobDescription??"";
                      var roleResponsibility=controller.jobDetailsData.value.data?.detail?.rolesResponsibility??"";
                      return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: controller.tabViewHeight.value,
                          child: Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            color: appWhiteColor,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: controller.tabController,
                              children: <Widget>[
                                ///Job Description
                                jobDescription.isNotEmpty||roleResponsibility.isNotEmpty?MeasureHeight(
                                  onHeightChanged: (height) => controller.updateHeight(height),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 10,),
                                        Text(controller.jobDescriptionTitle[0],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                                        SizedBox(height: 5,),
                                        HtmlWidget(jobDescription??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                        // Text(jobDescription??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                        SizedBox(height: 10,),
                                        roleResponsibility!=null&&roleResponsibility.isNotEmpty?Text(controller.jobDescriptionTitle[1],style: AppTextStyles.font16W600.copyWith(color: appBlackColor),):Container(),
                                        SizedBox(height: 5,),
                                        HtmlWidget(roleResponsibility??"",textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                        //Text(roleResponsibility??'',style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                                      ],
                                    ),
                                  ),
                                ):Center(
                                  child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                ),



                                ///Required Skills
                                Obx((){
                                  var skills=controller.jobDetailsData.value.data?.detail?.skill??[];
                                  return skills.isNotEmpty?MeasureHeight(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(appRequiredSkills,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                                        SizedBox(height: 20,),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150, // Adjust this value based on max text size
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            mainAxisExtent: 26, // Fixed height
                                          ),
                                          itemCount: skills.length ?? 0,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: appWhiteColor,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: appPrimaryColor, width: 1),
                                              ),
                                              child: Text(
                                                skills[index].name ?? '',
                                                style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    onHeightChanged: (height) => controller.updateHeight(height),
                                  ):Center(
                                    child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                  );
                                }),

                                ///Job Info
                                MeasureHeight(
                                  child:  Obx((){
                                    var createdDate=controller.jobDetailsData.value.data?.detail?.createDate??"";
                                    var applicationCount=controller.jobDetailsData.value.data?.detail?.vacancy??"";
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
                                              jonInfoCard(context,icon1: appDataPostedIconSvg, header1: appDataPosted, description1: calculateTimeDifference(createDate: createdDate), icon2: appExperenceIconSvg, header2: appNoOfVacancies, description2: applicationCount??""),
                                              SizedBox(height: 10,),
                                              jonInfoCard(context,icon1: appLocationsSvgIcon, header1: appLocation, description1: location??'', icon2: appAppIndustoryIconSvg, header2: appIndustry, description2: industry??''),
                                              SizedBox(height: 10,),
                                              jonInfoCard(context,icon1: appExperenceIconSvg, header1: appDepartment, description1: department??'', icon2: appDesignationIconSvg, header2: appDesignation, description2: designation??''),
                                              SizedBox(height: 10,),
                                              jonInfoCard(context,icon1: appSalaryIconSvg, header1: appSalary, description1: salary??'', icon2: appExperenceIconSvg, header2: appExperience, description2: experience??''),
                                              SizedBox(height: 10,),
                                              jonInfoCard(context,icon1: appWebsiteIconSvg, header1: appWebsite, description1: 'www.google.com', icon2: "", header2: "", description2: ''),
                                              SizedBox(height: 10,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  onHeightChanged: (height) => controller.updateHeight(height),
                                ),

                              ],
                            ),
                          )
                      );
                    }),
                    SizedBox(height: 10,),
                    Divider(color: appPrimaryBackgroundColor,thickness: 1,),
                    _showAppliedButton(context),
                    SizedBox(height: 10,),
                    _showSimilarJobs(context),
                    SizedBox(height: 10,),
                    allRightReservedWidget()
                  ],
                ),
              ),*/


  _jobProfileDetails(context) {
    return Obx((){
      var dataDetails=controller.jobDetailsData.value.data?.detail;

      if (dataDetails == null) {
        return Container(); // Show a placeholder or shimmer effect
      }
      var jobModeName=dataDetails?.jobModeName??"";
      var jobProfileImage=dataDetails?.profile??"";
      var applicationCount=dataDetails?.vacancy??"";
      var cityName=dataDetails?.cityName??"";
      var stateName=dataDetails?.stateName??"";
      var countryName=dataDetails?.countryName??"";
      var createdAtData=dataDetails?.createDate??"";
      var location=generateLocation(cityName: cityName??"", stateName: stateName??'', countryName: countryName??'');


      return Container(
        margin: EdgeInsets.only(left: 15,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _profileDetails(context,image: jobProfileImage??""),
            SizedBox(height: 10,),
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
                  child: Text("$appTotalApplication: $applicationCount",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,),
                ):Container()
              ],
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  location.isNotEmpty?Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(generateLocation(cityName: cityName??"", stateName: stateName??'', countryName: countryName??''),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,),
                      )
                    ],
                  ):Container(),
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
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: appPrimaryColor,width: 1)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:image.isNotEmpty?Image.network(image,height: 56,width: 56,errorBuilder: (context, error, stackTrace) {
              return Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: appPrimaryColor,width: 1),
                    gradient: LinearGradient(
                        colors: [getRandomColor(),getRandomColor()]
                    )
                ),
                child: Text(getInitialsWithSpace(input: jobProfile??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
              );
            },):Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appPrimaryColor,width: 1),
                  gradient: LinearGradient(
                      colors: [getRandomColor(),getRandomColor()]
                  )
              ),
              child: Text(getInitialsWithSpace(input: jobProfile??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
            ),
          ),
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
                (salaryName != null && salaryName.isNotEmpty &&
                    experienceName != null && experienceName.isNotEmpty)
                    ? Container(
                  height: 18,
                  width: 1,
                  color: appGreyBlackColor,
                )
                    : SizedBox(),
                (salaryName != null && salaryName.isNotEmpty &&
                    experienceName != null && experienceName.isNotEmpty)
                    ? SizedBox(width: 5,):SizedBox(width: 0,),
                experienceName!=null&&experienceName.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appExperenceIconSvg,height: 15,width: 15,),
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
                    image: jobList[index].profile??"",
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

  _showAppliedButton(context) {
    return Obx((){
      var isApplied=controller.jobDetailsData.value.data?.detail?.apply??false;
      return isApplied?commonButton(
          context,
          buttonName: appApplied,
          buttonBackgroundColor: appGreenColor,
          textColor: appWhiteColor,
          buttonBorderColor: appPrimaryColor,
          isPrefixIconShow: true,
          onClick: (){}):Container(
        padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width*0.4,
              child:commonButton(
                isPaddingDisabled: true,
                  context,
                  buttonName: appViewJD,
                  buttonBackgroundColor: appWhiteColor,
                  textColor: appPrimaryColor,
                  buttonBorderColor: appPrimaryColor,
                  isPrefixIconShow: true,
                  isPrefixIcon: appViewJd,
                  onClick: (){

                  }
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.4,
              child:commonButton(
                isPaddingDisabled: true,
                  context,
                  buttonName: appApply,
                  buttonBackgroundColor: appPrimaryColor,
                  textColor: appWhiteColor,
                  buttonBorderColor: appPrimaryColor,
                  onClick: (){
                    controller.applyJob(context);
                  }
              ),
            )
                    ],
                  ),
          );
    });
  }

  _bottomButton(context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.18,
      padding: EdgeInsets.only(top: 10,bottom: 1),
      child: Column(
        children: <Widget>[
          _showAppliedButton(context),
          Container(
            alignment:Alignment.center,
            child: allRightReservedWidget(),
          ),

        ],
      )
    );
  }

}