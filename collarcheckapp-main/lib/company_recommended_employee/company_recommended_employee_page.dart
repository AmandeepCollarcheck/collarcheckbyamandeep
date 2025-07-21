import 'package:collarchek/company_recommended_employee/company_recommended_employee_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_key_constent.dart' as AppRoutes;
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class CompanyRecommendedEmployeePage extends GetView<CompanyRecommendedEmployeeControllers>{
  const CompanyRecommendedEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: SafeArea(
            child: Column(
              children: <Widget>[
                commonActiveSearchBar(
                    leadingIcon: appBackSvgIcon,
                    screenName: appRecommendedEmployees,
                    isFilterShow: false,
                    actionButton: appFilterMore,
                    onClick: (){
                      controller.backButtonClick();
                    },
                    onShareClick: (){},
                    onFilterClick:(){
                      // controller.clickFilterButton();
                    },
                    isScreenNameShow: true,
                    isShowShare: false
                ),
                Obx((){
                  var recommendedEmployee=controller.recommendedEmployeeData.value.data??[];
                  return Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:  Wrap(
                        spacing: 10,
                        children: List.generate(recommendedEmployee.length, (index){
                          return companyRecommendedWidget(context,
                            cardWidth: MediaQuery.of(context).size.width*0.88,
                            isProfileVerified: recommendedEmployee[index].isVerified??false,
                            profileImage: recommendedEmployee[index].profile??"",
                            initialName:recommendedEmployee[index].name??"",
                            userName: recommendedEmployee[index].name??"",
                            ccId: recommendedEmployee[index].individualId??"",
                            location: generateLocation(cityName: recommendedEmployee[index].cityName??"", stateName: recommendedEmployee[index].stateName??"", countryName: recommendedEmployee[index].countryName??"",),
                            designation: recommendedEmployee[index].designationName??"",
                            ratingBar: formatRating(recommendedEmployee[index].totalRating.toString()??"0"),
                            viewProfileClick: () {
                              Get.offNamed(AppRoutes.profileDetails,arguments: {screenName:companyDashboardScreen,slugId:recommendedEmployee[index].slug??"",});
                            },
                          );
                        }),
                      ),
                    ),
                  );
                })
              ],
            )
        ),
      ),
    );
  }

}