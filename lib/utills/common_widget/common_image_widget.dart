import 'dart:math';

import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';
import '../font_styles.dart';

commonImageWidget({required String image,required String initialName,required double height ,required double width,required double borderRadius, bool isBorderDisable=false, Color borderColor=appPrimaryColor}){
  return image!=null||image.isNotEmpty?Container(
    height: height,
    width: width,
    //padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: isBorderDisable?appWhiteColor:borderColor,width: 1)
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child:image.contains(".svg")?SvgPicture.asset(image,height: height,width: width,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                    colors: [getRandomColor(),getRandomColor()]
                )
            ),
            child: Text(getInitialsWithSpace(input: initialName),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
          );
        },): Image.network(image,height: height,width: width,fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                    colors: [getRandomColor(),getRandomColor()]
                )
            ),
            child: Text(getInitialsWithSpace(input: initialName),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
          );
        },),
    ),
  ):Container(
    alignment: Alignment.center,
    height: height,
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
            colors: [getRandomColor(),getRandomColor()]
        )
    ),
    child: Text(getInitialsWithSpace(input: initialName??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
  );
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    200 + random.nextInt(56),
    200 + random.nextInt(56),
    200 + random.nextInt(56),
  );
}