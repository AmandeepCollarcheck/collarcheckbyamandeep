import 'package:collarchek/applicants/applicants_controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class ApplicantsPage extends GetView<ApplicantsControllers>{
  const ApplicantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Obx(()=>commonActiveSearchBar(
                    leadingIcon: appBackSvgIcon,
                    screenName: controller.headerTitleName.value,
                    isFilterShow: true,
                    actionButton: appFilterMore,
                    onClick: (){
                      //controller.backButtonClick();
                    },
                    onShareClick: (){},
                    onFilterClick:(){
                      //controller.clickFilterButton();
                    },
                    isScreenNameShow: true,
                    isShowShare: false
                )),
                Container(
                  padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                  color: appPrimaryBackgroundColor,
                  child: Obx((){
                    var data=controller.allApplicationData.value.data?.length.toString()??"0";
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                            children: [
                              TextSpan(
                                text:  data.toString()??"0",
                                style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                              ),
                              TextSpan(
                                text: data=="1"||data=="0"?appJobFound:appJobsFound,
                                style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {

                                    // Navigate to Terms of Use page or any action
                                  },
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            openShortItemFilter(context, onShort: (int value) {
                              //controller.shortDataList(value: value);
                            });
                          },
                          child: SvgPicture.asset(appShortIconSvg,height: 20,width: 20,),
                        )
                      ],
                    );
                  }),
                ),
                Obx(()  {
                  var allApplications=controller.allApplicationData.value.data??[];
                  return allApplications.isNotEmpty?Container(
                    color: appPrimaryBackgroundColor,
                      padding: EdgeInsets.all(10),
                      child:Wrap(
                        children: List.generate(allApplications.length??0, (index){
                          var locations=generateLocation(cityName: allApplications[index].cityName??"", stateName: allApplications[index].stateName??"", countryName: allApplications[index].countryName??"");
                          return commonCompanyApplicantWidget(context,
                            profileImage: allApplications[index].profile??"",
                            initialName:allApplications[index].fname??"",
                            userName: allApplications[index].fname??"",
                            ccId: allApplications[index].individualId??"",
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
                            timeAgo: calculateTimeDifference(createDate:  allApplications[index].date??"",),
                            locations: locations,
                            email: allApplications[index].email??"",
                            phone: allApplications[index].phone??"",
                            profileDesignation:allApplications[index].designationName??"",
                            isProfileVerified: true,
                              width: MediaQuery.of(context).size.width
                          );
                        }),
                      )
                  ):SizedBox(
                      height: MediaQuery.of(context).size.height*0.65,
                      child: Center(
                        child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                      )
                  );
                }),
                Container(
                  //color: appPrimaryColor,
                  alignment: Alignment.bottomCenter,
                  child: allRightReservedWidget(),
                )
              ],
            ),
          )
    ));
  }
}
