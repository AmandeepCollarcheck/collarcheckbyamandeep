import 'package:collarchek/messages/message_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class MessagePage extends GetView<MessageControllers>{
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Obx(()=>commonSearchAppBar(
                  context,controller: controller.searchController,
                  actionButtonOne: appFilterSvgIcon,
                  actionButtonTwo: appSearchIcon,
                  isBadge: false,
                  onTap: (){
                    controller.openSearchScreen(context);
                  },
                  isSearchActive: controller.isSearchActive.value,
                  onSearchIconClick: (bool isSearchClick) {
                    controller.isSearchActive.value=isSearchClick;
                  })),
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.78,
              child: Obx((){
                var messageData=controller.allMessageData.value.data??[];
                return messageData.isNotEmpty?ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context,int index){
                    return Divider(color: appGreyColor,thickness: 0.5,);
                  },
                  itemCount: controller.allMessageData.value.data?.length??0,
                  itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      onTap: (){
                        var userName=controller.allMessageData.value.data??[];
                        Get.offNamed(
                            AppRoutes.chat,
                            arguments: {
                              screenName:messages,
                              messageReceiverName:userName[index].receiverName??"",
                              profileImageData:userName[index].receiverProfile??"",
                              receiverId:userName[index].receiver??"",
                              senderId:userName[index].sender??"",

                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Obx((){
                                  var profileData=controller.allMessageData.value.data??[];
                                  var userName=controller.allMessageData.value.data??[];
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: appGreyBlackColor.withOpacity(0.5),width: 0.5)
                                    ),
                                    child:  profileData[index].receiverProfile!=null?ClipRRect(
                                      borderRadius:BorderRadius.circular(100),
                                      child: profileData[index].receiverProfile!.isNotEmpty?Image.network(profileData[index].receiverProfile??"",height: 50,width: 50,fit: BoxFit.cover,):Image.asset(appCompanyImage,height: 50,width: 50,),
                                    ):Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: [controller.getRandomColor(),controller.getRandomColor()]
                                          )
                                      ),
                                      child: Text(getInitialsWithSpace(input: userName[index].receiverName??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
                                    ),
                                  );
                                }),
                                SizedBox(width: 5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Obx((){
                                      var userName=controller.allMessageData.value.data??[];
                                      return SizedBox(
                                          child: Text(userName[index].receiverName??"",style: AppTextStyles.font16W700.copyWith(color: appBlackColor),overflow: TextOverflow.ellipsis,));

                                    }),
                                    SizedBox(height: 5,),
                                    Obx((){
                                      var messageData=controller.allMessageData.value.data??[];
                                      return messageData[index].message!.isNotEmpty?SizedBox(
                                          width:MediaQuery.of(context).size.width*0.43,
                                          child: Text(messageData[index].message?[messageData[index].message!.length-1].message.toString()??"",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),maxLines: 1,overflow: TextOverflow.ellipsis,)):Container();

                                    })


                                  ],
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                            Obx((){
                              var messageCount=controller.allMessageData.value.data??[];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  messageCount[index].count!=null&&messageCount[index].count!=0?Container(
                                    padding :EdgeInsets.all(7),
                                    decoration:BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: appPrimaryColor
                                    ),
                                    child: Text(messageCount[index].count.toString()??"",style: AppTextStyles.font10.copyWith(color: appWhiteColor),),
                                  ):Container(
                                    padding :EdgeInsets.all(7),
                                    decoration:BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: appWhiteColor
                                    ),
                                    child: Text(messageCount[index].count.toString()??"",style: AppTextStyles.font10.copyWith(color: appWhiteColor),),
                                  ),
                                  SizedBox(height: 5,),
                                  messageCount[index].datetime!.isNotEmpty?SizedBox(
                                    //width:MediaQuery.of(context).size.width*0.12,
                                      child: Text(formatTimestampInAmPm(timestamp: messageCount[index].datetime.toString()),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)):Container()
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ):SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                  )
                );
              }),
            )
          ],
        ),
      ),
    );
  }

}