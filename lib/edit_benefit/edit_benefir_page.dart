import 'package:collarchek/edit_benefit/edit_benefit_controllers.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class EditBenefitPage extends GetView<EditBeneFitControllers>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                onClick: (){
                  controller.backButtonClick(context);
                },
                leadingIcon: appBackSvgIcon,
                screenName: appEditBenefits,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonTextFieldTitle(headerName: appAddNewBenefit,isMendatory: true),
                        SizedBox(height: 5,),
                        Obx((){
                          var benefits = controller.benefitData.value.data ?? [];

                          return benefits!=null&&benefits.isNotEmpty?customDropDown(
                              hintText: appSelectCompany,
                              item: [{"id":"0","name":appSelectBenefits},
                              ...benefits.map((data)=>{'id':data.id,'name':data.name}).toList()??[]],
                              selectedValue: benefits.any((datum)=>datum.id==controller.selectedBenefitsData["id"])?controller.selectedBenefitsData:{"id":"0","name":appSelectBenefits},
                              onChanged: (Map<String,dynamic>? selectedData){
                                if(selectedData!=null){
                                  controller.benefitId.value=selectedData['id'];
                                  controller.selectedBenefitsData.value={
                                    "id":selectedData['id'],
                                    "name":selectedData['name']
                                  };
                                }
                              },
                              icon: appDropDownIcon
                          ):Container();
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height:20,),
                  commonButton(context,
                      buttonName: appAddBenefits,
                      buttonBackgroundColor: appPrimaryColor,
                      textColor: appWhiteColor,
                      buttonBorderColor: appPrimaryColor,
                      onClick: (){
                        if(controller.benefitId.value!=null&&controller.benefitId.value!="0"&&controller.benefitId.value.isNotEmpty){
                          controller.addBenefitsApiCall(context);
                        }else{
                          showToast(appPleaseSelectBenefits);
                        }

                      }
                  ),
                  SizedBox(height:30,),
                  _getAllCompanyBenefitsListData(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _getAllCompanyBenefitsListData( context) {
    return Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Obx((){
          var companyBenefitList=controller.companyBenefitData.value.data??[];
          return Wrap(
            runSpacing: 10,
            children: List.generate(companyBenefitList.length??0, (index){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          commonImageWidget(image: companyBenefitList[index].image??"", initialName: companyBenefitList[index].name??"", height: 28, width: 28, borderRadius: 0,isBorderDisable: true),
                          SizedBox(width: 10,),
                          SizedBox(
                              width:MediaQuery.of(context).size.width*0.7,
                              child: Text(companyBenefitList[index].name??"",style: AppTextStyles.font14.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 3,)),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: (){
                        controller.deleteBenefit(context, skillId: companyBenefitList[index].id??"",);
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