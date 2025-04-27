import 'package:collarchek/company_recently_joined_people/company_recently_joined_people_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/image_path.dart';

class CompanyRecentlyJoinedPeoplePage extends GetView<CompanyRecentlyJoinedPeopleControllers>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            commonActiveSearchBar(
                leadingIcon: appBackSvgIcon,
                screenName: appPeopleWhoRecentlyJoined,
                isFilterShow: false,
                actionButton: appFilterMore,
                onClick: (){
                  controller.backButtonClick(context);
                },
                onShareClick: (){},
                onFilterClick:(){
                  // controller.clickFilterButton();
                },
                isScreenNameShow: true,
                isShowShare: false
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: SizedBox(
                height:MediaQuery.of(context).size.height*0.4,
                child: Obx((){
                  var recentlyJoinedData=controller.recentlyJoinedData.value.data??[];
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 rows (you can adjust as needed)
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8, // Adjust width/height ratio
                    ),
                    itemCount: recentlyJoinedData.length > 4 ? 4 : recentlyJoinedData.length,
                    itemBuilder: (context, index) {
                      return recentlyJoinedWidget(
                        context,
                        profileImage: recentlyJoinedData[index].profile ?? "",
                        initialName: recentlyJoinedData[index].name ?? "",
                        userName: recentlyJoinedData[index].name ?? "",
                        ccId: recentlyJoinedData[index].individualId ?? "",
                        location: 'Delhi, noida, lucknow',
                        designation: recentlyJoinedData[index].designationName ?? "",
                        ratingBar: '10',
                        addReview: () {
                          Get.offNamed(AppRoutes.review, arguments: {
                            experienceId: recentlyJoinedData[index].experienceId ?? '',
                            screenName: companyDashboardScreen,
                          });
                        },
                      );
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

}