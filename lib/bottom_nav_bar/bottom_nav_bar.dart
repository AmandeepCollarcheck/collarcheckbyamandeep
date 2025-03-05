import 'package:collarchek/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:collarchek/connections/connection_bindings.dart';
import 'package:collarchek/connections/connection_page.dart';
import 'package:collarchek/dashboard/dashboard_bindings.dart';
import 'package:collarchek/dashboard/dashboard_page.dart';
import 'package:collarchek/profile_details/profile_details.dart';
import 'package:collarchek/profile_details/profile_details_bindings.dart';
import 'package:collarchek/profiles/profile_bindings.dart';
import 'package:collarchek/profiles/profile_dart.dart';
import 'package:collarchek/recommendJobs/recommend_job.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utills/app_colors.dart';
import '../utills/common_widget/commonDrawer.dart';
import '../utills/font_styles.dart';

class BottomNavBarPage extends GetView<BottomNavBarController>{
  const BottomNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: CommonDrawer(),
        body: Obx((){
          return Navigator(
            key: ValueKey(controller.bottomNavCurrentIndex.value),
            initialRoute: controller.routes[controller.bottomNavCurrentIndex.value],
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/home':
                  return GetPageRoute(
                      page: () => DashboardPage(),
                      binding: DashboardBindings()
                  );
                case '/connections':
                  return GetPageRoute(
                      page: () => ConnectionPage(),
                    binding: ConnectionBindings()
                  );
                case '/jobs':
                  return  GetPageRoute(
                      page: () => ProfilePage(),
                      binding: ProfileBindings()
                  );
                case '/messages':
                  return GetPageRoute(page: () => DashboardPage());
                case '/profile':
                  return GetPageRoute(
                      page: () => ProfileDetailsPage(),
                    binding: ProfileDetailsBindings()
                  );
                default:
                  return GetPageRoute(page: () => DashboardPage());
              }
            },
          );
        }),
    bottomNavigationBar: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 60,
      child:  _buildBottomNavBar(context) ,
    ),
    ));
  }

   _buildBottomNavBar(context) {
    return Obx(()=>BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: appBarBackgroundColor,
      currentIndex: controller.bottomNavCurrentIndex.value,
      selectedLabelStyle: AppTextStyles.font12.copyWith(color: appPrimaryColor),
      unselectedLabelStyle: AppTextStyles.font12.copyWith(color: appGreyBlackColor),
      onTap: (int index){
        controller.selectBottomNavOption(context,selectedIndex: index);
      },
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(appHomeUnSelected),
            label: appHome,
            activeIcon: Image.asset(appHomeSelected)
        ),
        BottomNavigationBarItem(
            icon: Image.asset(appConnectionUnSelected),
            label: appConnections,
            activeIcon: Image.asset(appConnectionSelected)
        ),
        BottomNavigationBarItem(
            icon: Image.asset(appJonSelectedUnSelected),
            label: appJobs,
            activeIcon: Image.asset(appJonSelected)
        ),
        BottomNavigationBarItem(
            icon: Image.asset(appMessageUnselected),
            label: appMessages,
            activeIcon: Image.asset(appMessageSelected)
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 30, // Ensures it doesn't overflow
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevents unnecessary height expansion
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircularPercentIndicator(
                    radius: 15.0,
                    lineWidth: 2.0,
                    percent: controller.profilePercentage.value??0.0,
                    center: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(appBottomProfile),
                      ),
                    ),
                    progressColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          label: "K M",
        ),
      ],
    ));
  }

}