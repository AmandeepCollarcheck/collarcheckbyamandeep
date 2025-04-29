import 'package:collarchek/search/search_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class SearchPage extends GetView<SearchControllers>{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: appScreenBackgroundColor,
      body: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: SafeArea(
          child:Column(
            children: <Widget>[
              commonActiveSearchBar(
                  leadingIcon: appBackSvgIcon,
                  screenName: appSearch,
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
              ),
              Container(
                color: appPrimaryBackgroundColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    ///Search Widget
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          commonTextField(
                              controller: controller.searchController,
                              hintText: appSearchForJobsCompanies,
                              onChanged: (searchKeyword){
                                if(searchKeyword.isNotEmpty){
                                  controller.globalSearchApiCall(context,searchKeyWord: searchKeyword);
                                }

                              }
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Obx((){
                              var jobListData=controller.searchDataList.value.data?.jobList??[];
                              var companyListData=controller.searchDataList.value.data?.companyList??[];
                              var userListData=controller.searchDataList.value.data?.userList??[];
                              return jobListData.isNotEmpty||companyListData.isNotEmpty||userListData.isNotEmpty?Column(
                                children: <Widget>[
                                  ///Job List
                                  jobListData.isNotEmpty? Container(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Obx((){
                                              var jobData= controller.searchDataList.value.data?.jobListCount ?? "";
                                              return RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                                  children: [
                                                    TextSpan(
                                                      text:  (jobData.toString()??"0").toString()??"0",
                                                      style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                                    ),
                                                    TextSpan(
                                                      text: jobData.toString()=="1"?appJobTextFound:appJobFound,
                                                      style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {

                                                          // Navigate to Terms of Use page or any action
                                                        },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            jobListData.length>4?GestureDetector(
                                              onTap: (){
                                                controller.openJobPages(context);
                                              },
                                              child: Text(appViewAllJobs,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                            ):Container()
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Obx(() {
                                          final jobList = controller.searchDataList.value.data?.jobList ?? [];
                                          return Container(
                                            child: jobList.isNotEmpty?Wrap(
                                              runSpacing: 10,
                                              children: List.generate(jobList.length>4?4:jobList.length, (index) {
                                                return commonCardWidget(
                                                  context,
                                                  cardWidth: MediaQuery.of(context).size.width,
                                                  onClick: () {
                                                    controller.openJobDetails(jobTitle: jobList[index].slug ??"",);
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
                                                  timeAgo: calculateTimeDifference(createDate: jobList[index].createDate??""), isApplyClick: () {  },
                                                );
                                              }),
                                            ):SizedBox(
                                              height: MediaQuery.of(context).size.height*0.6,
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                  child: Text(appNoDataFound,style: AppTextStyles.font14W500.copyWith(color: appBlackColor),)
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ):Container(),
                                  jobListData.isNotEmpty?SizedBox(height: 20,):SizedBox(height: 0,),
                                  ///Companies List
                                  companyListData.isNotEmpty?Container(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Obx((){
                                              var companyData= controller.searchDataList.value.data?.companyListCount ?? "";
                                              return RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                                  children: [
                                                    TextSpan(
                                                      text:  (companyData.toString()??"0").toString()??"0",
                                                      style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                                    ),
                                                    TextSpan(
                                                      text: companyData.toString()=="1"?appCompanyFound:appCompaniesFound,
                                                      style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {

                                                          // Navigate to Terms of Use page or any action
                                                        },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            companyListData.length>4?GestureDetector(
                                              onTap: (){
                                                controller.openCompanyPages(context, argumentType: topCompanies);
                                              },
                                              child: Text(appViewAllCompany,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                            ):Container()
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Obx(() {
                                          final companyList = controller.searchDataList.value.data?.companyList ?? [];
                                          return Container(

                                            child: companyList.isNotEmpty?Wrap(
                                              runSpacing: 10,
                                              children: List.generate(companyListData.length>4?4:companyList.length, (index) {
                                                return GestureDetector(
                                                  onTap: (){
                                                    controller.openCompanyProfileScreen(context,employeeSlug: companyList[index].slug??"");

                                                  },
                                                  child: commonTopCompaniesWidget(context,
                                                      image: companyList[index].profile??"",
                                                      location: generateLocation(cityName: companyList[index].cityName??"", stateName: companyList[index].stateName??"", countryName: companyList[index].countryName??""),//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                                                      name: capitalizeFirstLetter(companyList[index].fname??""),
                                                      id:companyList[index].individualId??"",
                                                      jobTitle:"",
                                                      isProfileVerified: false,
                                                      cardWidth: MediaQuery.of(context).size.width*0.92,
                                                      onClick: (){

                                                      },
                                                      isFollowData: true, onMessageClick: (){

                                                      }


                                                  ),
                                                );
                                              }),
                                            ):SizedBox(
                                              height: MediaQuery.of(context).size.height*0.6,
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                  child: Text(appNoDataFound,style: AppTextStyles.font14W500.copyWith(color: appBlackColor),)
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ):Container(),
                                  companyListData.isNotEmpty?SizedBox(height: 20,):SizedBox(height: 0,),
                                  ///Employee List
                                  userListData.isNotEmpty?Container(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Obx((){
                                              var userData= controller.searchDataList.value.data?.userListCount ?? "";
                                              return RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                                  children: [
                                                    TextSpan(
                                                      text:  (userData.toString()??"0").toString()??"0",
                                                      style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                                    ),
                                                    TextSpan(
                                                      text: userData.toString()=="1"?appEmployeeFound:appEmployeesFound,
                                                      style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {

                                                          // Navigate to Terms of Use page or any action
                                                        },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            userListData.length>4?GestureDetector(
                                              onTap: (){
                                                controller.openCompanyPages(context, argumentType: topEmployees);
                                              },
                                              child: Text(appViewAllEmployee,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                            ):Container()
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Obx(() {
                                          final userList = controller.searchDataList.value.data?.userList ?? [];
                                          return Container(

                                            child: userList.isNotEmpty?Wrap(
                                              runSpacing: 10,
                                              children: List.generate(userListData.length>4?4:userList.length, (index) {
                                                return GestureDetector(
                                                  onTap: (){
                                                    controller.openEmployeeProfileScreen(context,employeeSlug: userList[index].slug??"");
                                                  },
                                                  child: commonTopCompaniesWidget(context,
                                                      image: userList[index].profile??"",
                                                      isProfileVerified: false,
                                                      cardWidth: MediaQuery.of(context).size.width*0.92,
                                                      location: generateLocation(cityName: userList[index].cityName??"", stateName: userList[index].stateName??"", countryName: userList[index].countryName??""),//generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                                                      name: capitalizeFirstLetter(userList[index].fname??""),
                                                      id:userList[index].individualId??"",
                                                      jobTitle:capitalizeFirstLetter(userList[index].designationName??""),
                                                      onClick: (){
                                                        // var userId=controller.userProfileData.value.data?.id??"";
                                                        // controller.companyFollowApiCall(context,companyId:companyProfile[index].id??"", userId: userId??"" );

                                                      },
                                                      isSimilerProfile: true,
                                                      isFollowData: false, onMessageClick: (){

                                                      }


                                                  ),
                                                );
                                              }),
                                            ):SizedBox(
                                              height: MediaQuery.of(context).size.height*0.6,
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                  child: Text(appNoDataFound,style: AppTextStyles.font14W500.copyWith(color: appBlackColor),)
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ):Container(),
                                ],
                              ):Container(
                                height: MediaQuery.of(context).size.height*0.6,
                                child: Center(
                                  child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                                ),
                              );
                            }),
                            SizedBox(height: 20,),
                            allRightReservedWidget()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}