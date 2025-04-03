import 'dart:ui';

import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../image_path.dart';

commonButton(context,{required String buttonName,required Color buttonBackgroundColor,required Color textColor,required Color buttonBorderColor ,required VoidCallback onClick,bool isPrefixIconShow=false, String isPrefixIcon=appAppliedIcon, bool isPaddingDisabled=false}){
  return GestureDetector(
    onTap: onClick,
    child: Container(
      margin: isPaddingDisabled?EdgeInsets.only(left:0,right: 0):EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.center,
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: buttonBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: buttonBorderColor,width: 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isPrefixIconShow?SvgPicture.asset(isPrefixIcon,height: 24,width: 24,):Container(),
          isPrefixIconShow?SizedBox(width: 4,):SizedBox(width: 0,),
          Text(buttonName,style: AppTextStyles.semiBold.copyWith(color: textColor),textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}



commonButtonWithIcon(context,{required String buttonName,required Color buttonBackgroundColor,required Color textColor,required Color buttonBorderColor ,required VoidCallback onClick,required String image}){
  return GestureDetector(
    onTap: onClick,
    child: Container(
     // margin: EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.center,
      height: 45,
      width: MediaQuery.of(context).size.width*0.4,
      decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(14)),
          border: Border.all(color: buttonBorderColor,width: 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(image,height: 22,width: 22,),
          SizedBox(width: 10,),
          Text(buttonName,style: AppTextStyles.semiBold.copyWith(color: textColor),textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}


