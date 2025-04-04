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
                    screenName: "$appApplicationFor ${controller.jobProfileNameData.value}",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                          children: [
                            TextSpan(
                              text:  "10"??"0",
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
                  ),
                ),
                Obx(()  {
                  var pastData=controller.employeeData.value.data?.past??[];
                  return pastData.isNotEmpty?Container(
                    color: appPrimaryBackgroundColor,
                      padding: EdgeInsets.all(10),
                      child:Wrap(
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
