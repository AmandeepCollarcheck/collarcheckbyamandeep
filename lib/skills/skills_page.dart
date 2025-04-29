import 'package:collarchek/skills/skills_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/employment_list_model.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class SkilldPage extends GetView<SkillControllers>{
  const SkilldPage({super.key});

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
                  screenName: appAddSkills,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
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
                          commonTextFieldTitle(headerName: appAddNewSkill,isMendatory: true),
                          SizedBox(height: 5,),
                          Obx((){
                            var skills = List<DepartmentListElement>.from(controller.designationListData.value.data?.skillList ?? []);
                            skills.insert(0, DepartmentListElement(id: "0", name: "Select"));
                            return skills!=null&&skills.isNotEmpty?customDropDown(
                                hintText: appSelectCompany,
                                item: skills.map((data)=>{'id':data.id,'name':data.name}).toList()??[],
                                selectedValue: {'id':skills[0].id,'name':skills[0].name},
                                onChanged: (Map<String,dynamic>? selectedData){
                                  if(selectedData!=null){
                                    controller.skillsId.value=selectedData['id'];
                                  }
                                },
                                icon: appDropDownIcon
                            ):Container();
                          }),
                          SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appRateYourSkills,isMendatory: true),
                          SizedBox(height: 5,),
                          commonRattingBar(context, initialRating: controller.ratingValue.value, updatedRating: (double data ) {
                            controller.ratingValue.value=data;
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height:20,),
                    commonButton(context,
                        buttonName: appAddSkills,
                        buttonBackgroundColor: appPrimaryColor,
                        textColor: appWhiteColor,
                        buttonBorderColor: appPrimaryColor,
                        onClick: (){
                          if(controller.skillsId.value!=null&&controller.skillsId.value!="0"&&controller.skillsId.value.isNotEmpty&&controller.ratingValue.value!=0.0){
                            controller.addSkillsApiCall(context);
                          }else{
                            showToast(appPleaseSelecteValidSkills);
                          }

                        }
                    ),
                    SizedBox(height:30,),
                    _getAllSkillsListData(context)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getAllSkillsListData( context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Obx((){
        var skillsList=controller.allSkillsData.value.data??[];
        return Wrap(
          runSpacing: 10,
          children: List.generate(skillsList.length??0, (index){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        width:MediaQuery.of(context).size.width*0.2,
                        child: Text(skillsList[index].skill??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                    Row(
                      children: <Widget>[
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width*0.5,
                          lineHeight: 4.0,
                          percent: handleIndecaterPercentage(devident: skillsList[index].rating??"", devider: progressBarMaxValue),
                          barRadius: Radius.circular(10),
                          backgroundColor: appPrimaryBackgroundColor,
                          progressColor: appPrimaryColor,
                        ),
                        SizedBox(width: 3,),
                        Text("${skillsList[index].rating??""}/$progressBarMaxValue",style: AppTextStyles.font14.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 3,)
                      ],
                    )

                  ],
                ),
                GestureDetector(
                  onTap: (){
                    controller.deleteSkills(context, skillId: skillsList[index].id??"",);
                  },
                    child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
              ],
            );
          }),
        );
      })
    );
  }

}