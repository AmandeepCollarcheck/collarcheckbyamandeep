import 'package:collarchek/Splash/splash_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/image_path.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utills/common_widget/progress.dart';


class SplashPage extends GetView<SplashController>{
  const SplashPage({super.key});

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
         backgroundColor: appScreenBackgroundColor,
         body: Container(
           decoration: BoxDecoration(
               color:appPrimaryColor
           ),
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Image.asset(appLogoNewSvg,height: 60,width: MediaQuery.of(context).size.width*0.8,),

                 Text(appNameContent,style: AppTextStyles.font20.copyWith(color: appWhiteColor))
               ],

             ),
           ),
         ),
       ),
     ),
   );
  }
}