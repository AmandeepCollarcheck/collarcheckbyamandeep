import 'package:collarchek/languages/language_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/all_language_list_data_model.dart';
import '../models/employment_list_model.dart';
import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class LanguagePage extends GetView<LanguageControllers>{
  const LanguagePage({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                commonActiveSearchBar(
                  onClick: (){
                    controller.backButtonClick(context);
                  },
                  leadingIcon: appBackSvgIcon,
                  screenName: appAddLanguage,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          commonTextFieldTitle(headerName: appAddNewLanguage,isMendatory: true),
                          SizedBox(height: 5,),
                          Obx((){
                            var languageData = List<LanguageDatum>.from(controller.allLanguageDataList.value.data ?? []);
                            languageData.insert(0, LanguageDatum(id: "0", name: "Select"));
                            return languageData!=null&&languageData.isNotEmpty?customDropDown(
                                hintText: appSelectCompany,
                                item: languageData.map((data)=>{'id':data.id,'name':data.name}).toList()??[],
                                selectedValue: {'id':languageData[0].id,'name':languageData[0].name},
                                onChanged: (Map<String,dynamic>? selectedData){
                                  if(selectedData!=null){
                                    controller.languageId.value=selectedData['id'];
                                  }
                                },
                                icon: appDropDownIcon
                            ):Container();
                          }),
                          SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appRateFluency,isMendatory: true),
                          SizedBox(height: 5,),
                          commonRattingBar(context, initialRating: controller.ratingVerbalValue.value, updatedRating: (double data ) {
                            controller.ratingVerbalValue.value=data;
                          }),
                          SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appWrittenFluency,isMendatory: true),
                          SizedBox(height: 5,),
                          commonRattingBar(context, initialRating: controller.ratingWrittenValue.value, updatedRating: (double data ) {
                            controller.ratingWrittenValue.value=data;
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height:20,),
                    commonButton(context,
                        buttonName: appAddLanguage,
                        buttonBackgroundColor: appPrimaryColor,
                        textColor: appWhiteColor,
                        buttonBorderColor: appPrimaryColor,
                        onClick: (){
                          if(controller.languageId.value!=null&&controller.languageId.value!="0"&&controller.languageId.value.isNotEmpty){
                            if(controller.ratingVerbalValue.value==0.0){
                              showToast(appPleaseVerbalFluency);
                            }else if(controller.ratingWrittenValue.value==0.0){
                              showToast(appPleaseWrittenFluency);
                            }else{
                              controller.addLanguageApiCall(context);
                            }
                          }else{
                            showToast(appPleaseSelecteValidLanguage);
                          }
                        }
                    ),
                    SizedBox(height:30,),
                    _getAllLanguageListData(context)
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  _getAllLanguageListData( context) {
    return Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Obx((){
          var languageList=controller.allLanguageData.value.data??[];
          return Wrap(
            runSpacing: 10,
            children: List.generate(languageList.length??0, (index){
              return Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            width:MediaQuery.of(context).size.width*0.2,
                            child: Text(languageList[index].languageName??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                width:MediaQuery.of(context).size.width*0.3,
                                child: Text(appVerbal,style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                            Row(
                              children: <Widget>[
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  lineHeight: 4.0,
                                  percent:  handleIndecaterPercentage(devident: languageList[index].verbal??'', devider: progressBarMaxValue??''),
                                  barRadius: Radius.circular(10),
                                  backgroundColor: appPrimaryBackgroundColor,
                                  progressColor: appPrimaryColor,
                                ),
                                SizedBox(width: 3,),
                                Text("${languageList[index].verbal??""}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                width:MediaQuery.of(context).size.width*0.3,
                                child: Text(appWritten,style: AppTextStyles.font12.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                            Row(
                              children: <Widget>[
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  lineHeight: 4.0,
                                  percent:handleIndecaterPercentage(devident: languageList[index].written??'', devider: progressBarMaxValue??''),
                                  barRadius: Radius.circular(10),
                                  backgroundColor: appPrimaryBackgroundColor,
                                  progressColor: appPrimaryColor,
                                ),
                                SizedBox(width: 3,),
                                Text("${languageList[index].written??""}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                              ],
                            ),

                          ],
                        )

                      ],
                    ),
                    GestureDetector(
                        onTap: (){
                          controller.deleteLanguage(context, skillId: languageList[index].id??"",);
                        },
                        child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                  ],
                ),
              );
            }),
          );
        })
    );
  }

}