import 'package:collarchek/notifications/notifications_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class NotificationPage extends GetView<NotificationControllers>{
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            commonActiveSearchBar(
                leadingIcon: appBackSvgIcon,
                screenName: appNotification,
                isFilterShow: false,
                actionButton: appFilterMore,
                onClick: (){
                  controller.backButtonClick();
                },
                onShareClick: (){},
                onFilterClick:(){},
                isScreenNameShow: true,
                isShowShare: false
            ),
            Obx((){
              var notificationData=controller.notificationData.value.data?.notification??[];
              return notificationData.isNotEmpty?Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return Divider(color: appPrimaryBackgroundColor,thickness: 1,);
                    },
                    itemCount: notificationData.length??0,
                    separatorBuilder:  (BuildContext context,int index){
                      return Container(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child: Row(
                          children: <Widget>[
                            notificationData[index].profile!=null?ClipRRect(
                              borderRadius:BorderRadius.circular(100),
                              child: Image.network(notificationData[index].profile??"",height: 50,width: 50,fit: BoxFit.cover,),
                            ):Image.asset(appDummyProfile,height: 50,width: 50,fit: BoxFit.cover,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.65,
                                    child: Text(notificationData[index].message??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),)),
                                SizedBox(height: 3,),
                                Text(calculateTimeDifference(createDate: notificationData[index].dateTime??""),style: AppTextStyles.font12.copyWith(color: appPrimaryColor))

                              ],
                            ),
                            SvgPicture.asset(appCloseIcon)
                          ],
                        ),
                      );
                    }

                ),
              ):SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: Center(
                  child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

}