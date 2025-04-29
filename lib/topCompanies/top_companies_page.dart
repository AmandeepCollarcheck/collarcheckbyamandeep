import 'package:collarchek/topCompanies/top_companies_controller.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class TopCompaniesPage extends GetView<TopCompaniesController>{
  const TopCompaniesPage({super.key});

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
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Obx((){
                  var companyData=controller.topCompaniesData.value.data?.companyList??[];
                  return commonActiveSearchBar(
                      leadingIcon: appBackSvgIcon,
                      screenName: controller.screenHeaderName.value.isNotEmpty&&controller.screenHeaderName.value==appTopCompanies?appTopCompanies:appCandidatesList,
                      isFilterShow: true,
                      actionButton: appFilterMore,
                      onClick: (){
                        controller.backButtonClick();
                      },
                      onShareClick: (){},
                      onFilterClick:(){
                        controller.clickFilterButton(screenType: companyData.isNotEmpty?appTopCompanies:appCandidatesList,);
                      },
                      isScreenNameShow: true,
                      isShowShare: false
                  );
                }),
                Obx((){
                  var topCompaniesList=controller.topCompaniesData.value.data?.companyList??[];
                  var topUserList=controller.topCompaniesData.value.data?.userList??[];
                  return topCompaniesList.isNotEmpty||topUserList.isNotEmpty? Column(
                    children: <Widget>[
                      ///Top Companies
                      Obx((){
                        var topCompaniesList=controller.topCompaniesData.value.data?.companyList??[];
                        return topCompaniesList.isNotEmpty?Container(
                            color: appPrimaryBackgroundColor,
                            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Obx((){
                                      var topCompaniesList=controller.topCompaniesData.value.data?.companyList??[];
                                      return RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                          children: [
                                            TextSpan(
                                              text:  topCompaniesList.length.toString()??"0",
                                              style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                            ),
                                            TextSpan(
                                              text: appCompaniesFound,
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
                                    //   GestureDetector(
                                    //     onTap: (){
                                    //       openShortItemFilter(context, onShort: (int value) {
                                    //         controller.shortDataList(value: value);
                                    //       });
                                    //     },
                                    //   child: Image.asset(appShortIcon,height: 20,width: 20,),
                                    // )
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Obx((){
                                  var allTopCompanies=controller.topCompaniesData.value.data?.companyList??[];
                                  return  allTopCompanies!=null&&allTopCompanies.isNotEmpty?Wrap(
                                    runSpacing: 5,
                                    children: List.generate(allTopCompanies.length??0, (index){
                                      return commonTopCompaniesWidget(context,
                                          image: allTopCompanies[index]['profile']??appCompanyImage,
                                          location: generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                                          name: capitalizeFirstLetter(allTopCompanies[index]['fname']??""),
                                          id: allTopCompanies[index]['individual_id']??"",
                                          isProfileVerified: false,
                                          cardWidth: MediaQuery.of(context).size.width*0.92,
                                          jobTitle: '',
                                          onClick: ()async{
                                            String userIdData=await readStorageData(key: id) ??"";
                                            controller.companyFollowApiCall(context, companyId: allTopCompanies[index]['id']??"", userId: userIdData??"",);
                                          },
                                          isFollowData: true, onMessageClick: (){}


                                      );
                                    }),
                                  ):Center(
                                    child: Text(noDataAvailable),
                                  );
                                })
                              ],
                            )
                        ):Container();
                      }),
                      ///Top Candidate
                      Obx((){
                        var topUserList=controller.topCompaniesData.value.data?.userList??[];
                        return topUserList.isNotEmpty?Container(
                            color: appPrimaryBackgroundColor,
                            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Obx((){
                                      var topUserList=controller.topCompaniesData.value.data?.userList??[];
                                      return RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                          children: [
                                            TextSpan(
                                              text:  topUserList.length.toString()??"0",
                                              style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                            ),
                                            TextSpan(
                                              text: appCandidatesFound,
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
                                    // GestureDetector(
                                    //   onTap: (){
                                    //     openShortItemFilter(context, onShort: (int value) {
                                    //       controller.shortDataList(value: value);
                                    //     });
                                    //   },
                                    //   child: Image.asset(appShortIcon,height: 20,width: 20,),
                                    // )
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Obx((){
                                  var allTopUsers=controller.topCompaniesData.value.data?.userList??[];
                                  return  allTopUsers!=null&&allTopUsers.isNotEmpty?Wrap(
                                    runSpacing: 5,
                                    children: List.generate(allTopUsers.length??0, (index){
                                      return commonTopCompaniesWidget(context,
                                          onProfileClick: (){
                                            print("sdkjlfsfhshkdfhshfkshdf");
                                            Get.offNamed(AppRoutes.otherCompanyProfilePage,arguments: {slugId:allTopUsers[index]['slug']??"",screenName:topCompaniesScreen});
                                          },
                                          image: allTopUsers[index]['profile']??"",
                                          location: generateLocation(cityName: allTopUsers[index]['city_name']??"", stateName: allTopUsers[index]['state_name']??"", countryName: allTopUsers[index]['country_name']??""),
                                          name: capitalizeFirstLetter(allTopUsers[index]['fname']??""),
                                          id: allTopUsers[index]['individual_id']??"",
                                          isProfileVerified: false,
                                          isTopCompany: true,

                                          cardWidth: MediaQuery.of(context).size.width,
                                          jobTitle: capitalizeFirstLetter(allTopUsers[index]['designation_name']??"",),
                                          onClick: ()async{
                                            print("sdkjlfsfhshkdfhshfkshdf........");
                                            //String userIdData=await readStorageData(key: id) ??"";
                                            // controller.companyFollowApiCall(context, companyId: allTopUsers[index]['id']??"", userId: userIdData??"",);
                                          },
                                          isSimilerProfile: true,
                                          isFollowData: false, onMessageClick: ()async{
                                            var userID=await readStorageData(key: id);
                                            Get.offNamed(
                                                AppRoutes.chat,
                                                arguments: {
                                                  screenName:topCompaniesScreen,
                                                  messageReceiverName:allTopUsers[index]['fname']??"",
                                                  profileImageData:allTopUsers[index]['profile']??"",
                                                  receiverId:allTopUsers[index]['id']??"",
                                                  senderId:userID??"",

                                                  argumentTypeData:topEmployees
                                                });
                                          }


                                      );
                                    }),
                                  ):Center(
                                    child: Text(noDataAvailable),
                                  );
                                })
                              ],
                            )
                        ):Container();
                      })
                    ],
                  ):SizedBox(
                    height: MediaQuery.of(context).size.height*0.7,
                    child: Center(
                      child: Text(appNoDataFound,style: AppTextStyles.font12.copyWith(color: appBlackColor),),
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