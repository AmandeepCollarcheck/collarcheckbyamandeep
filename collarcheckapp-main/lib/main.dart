import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_custom_scrool_tab_view.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/internet_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'dashboard/dashboard_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDisplayMode.setHighRefreshRate();
  await Firebase.initializeApp();
  await InternetChecker().onInit();
  Get.put(BottomNavBarController());
  Get.put(DashboardController());
  Get.put(CommonScrollControllers(), permanent: true);
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: appPrimaryColor,
    statusBarIconBrightness: Brightness.light,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return PopScope(
          canPop: false, // Prevents default back behavior
          onPopInvoked: (didPop) {
            if (!didPop) {
              onWillPop();
            }
          },
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}

