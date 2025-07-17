

  import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/employeement_history_model.dart';
import '../app_colors.dart';
import '../app_key_constent.dart';
import '../app_route.dart';
import '../app_strings.dart';
import '../font_styles.dart';
import 'common_appbar.dart';
import 'common_methods.dart';

  /// Widget for Experience Card
   buildExperienceCard(context,{
     required String employmentHistoryId,
    required String companyName,
    required String companyDetails,
    required String companyImage,
     required List experienceDetails,
     required bool isProfileVerification,
     bool isExpended=false,
     required Function() onExpendEnable,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _profileWidget(context,companyImage: companyImage, companyName: companyName, companyDetails: companyDetails),
          SizedBox(height: 8,),
          Wrap(
            direction: Axis.vertical,
            children: List.generate(experienceDetails.length??0, (index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    child: Row(
                                      children: <Widget>[
                                        commonUserNameWidget(context, userName: experienceDetails[index].designation, isProfileVerified: isProfileVerification, width: MediaQuery.of(context).size.width*0.52,textColor: appPrimaryColor),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: <Widget>[
                                      commonRattingBar(context, size: 14,padding: 0,initialRating: 2.0, updatedRating: (double data){
                                        print(data);
                                      },ignoreGesture: true),
                                      SizedBox(width: 5,),
                                     GestureDetector(
                                       onTap:(){
                                         Get.offNamed(AppRoutes.employmentHistory,arguments: {screenName:profileDetails,isEdit:true,isEditItemId:employmentHistoryId});
                                       },
                                       child:  SvgPicture.asset(appEditIcon,height: 16,width: 16,),
                                     )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///Rating start and working time widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         // Text(commonEmployementDataPosted(joiningData: experienceDetails[index].joiningDate??"", employementTillDate: experienceDetails[index].workedTillDate, stillWorking: experienceDetails[index].stillWorking??0),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                          Text(
                            checkEmploymentIsPresentOfNot(joiningDate: experienceDetails[index].joiningDate??"", tillEmploymentDate: experienceDetails[index].workedTillDate
                                ??"", isStillWorking: experienceDetails[index].stillWorking??0),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                          SizedBox(width: 5,),
                          experienceDetails[index].totalRating.rating!=null&&experienceDetails[index].totalRating.rating!=0? Row(
                               children: <Widget>[
                                 Text(getRatingText(experienceDetails[index].totalRating.rating.toInt()),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)
                               ],
                             ):Container()

                        ],
                      ),
                      experienceDetails[index].description!=null?SizedBox(height: 3,):SizedBox(height: 0,),
                      experienceDetails[index].description!=null?SizedBox(
                        width: MediaQuery.of(context).size.width*0.82,
                          child: Text(experienceDetails[index].description??"",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),)):Container(),
                      ///Salary Package
                      experienceDetails[index].description!=null?SizedBox(height: 5,):SizedBox(height: 0,),
                      Text(appSalaryPackage,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                      SizedBox(height: 5,),
                      Text(completeSalaryPackage(salaryType: experienceDetails[index].salary??"", salaryAmount: experienceDetails[index].salaryInhand??"", salaryMode: experienceDetails[index].salaryMode??""),style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
                      ///Skills
                      SizedBox(height: 5,),
                      Text(appSkills,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                      SizedBox(height: 3,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.62,
                        child: programmingKnowledge(context,programmingList: experienceDetails[index].skill??[], isExpanded: isExpended, onExpandChanged: onExpendEnable, itemCount:experienceDetails[index].skill.length??""),
                      ),
                      ///Supportive Document
                      experienceDetails[index].document.isNotEmpty?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5,),
                          Text(appSupportingDocuments,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                          SizedBox(height: 3,),
                          GestureDetector(
                            onTap:()async{
                              String link = experienceDetails[index].document[0].toString()??"";
                              final Uri _url = Uri.parse(experienceDetails[index].document[0].toString()??"");
                              if(experienceDetails[index].document!=null&&experienceDetails[index].document!.isNotEmpty){
                                if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                              }
                              }else{
                              showToast(appNoAnyLinkAvailable);
                              }
                            },
                            child: Container(
                              padding:EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: appPrimaryBackgroundColor
                              ),
                              child:SvgPicture.asset(appSupportiveDocument,height: 36,width: 36,color: appRedColor,)
                              ,
                            ),
                          )
                        ],
                      ):Column()

                    ],
                  ),
                ],
              );
            }),
          )

        ],
      ),
    );
}

_profileWidget(context,{required String companyImage,required String companyName,required String companyDetails}) {
     return Row(
       children: <Widget>[
         companyImage.isNotEmpty?ClipRRect(
           borderRadius: BorderRadius.circular(10),
           child: Image.network(appCompanyImage,height: 50,width: 50,errorBuilder: (context, error, stackTrace) {
             return Container(
               alignment: Alignment.center,
               height: 50,
               width: 50,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   gradient: LinearGradient(
                       colors: [getRandomColor(),getRandomColor()]
                   )
               ),
               child: companyName.isNotEmpty?Text(getInitialsWithSpace(input: companyName??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)):Container(),
             );
           },),
         ):Container(
           alignment: Alignment.center,
           height: 50,
           width: 50,
           decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               gradient: LinearGradient(
                   colors: [getRandomColor(),getRandomColor()]
               )
           ),
           child: Text(getInitialsWithSpace(input: companyName??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
         ),
         SizedBox(width: 10,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             SizedBox(
               width: MediaQuery.of(context).size.width*0.56,
                 child: Text(companyName,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),)),
             SizedBox(
                 width: MediaQuery.of(context).size.width*0.56,
                 child: Text(companyDetails,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)),
           ],
         )
       ],
     );
}
