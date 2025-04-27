import 'dart:math' as math;

import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../image_path.dart';
import 'common_image_widget.dart';

commonCompanyWidget(context,{required String profileImage,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required String location,required String designation,required String dataPosted,required Function() onClick,required bool isProfileVerified,bool isPastData=false}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _profileWidget(context,profileImage: profileImage, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick, isProfileVerified: isProfileVerified),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              designation.isNotEmpty?SizedBox(
               // width: MediaQuery.of(context).size.width*0.4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2,left: 4),
                      child: SvgPicture.asset(appDesignationSvgIcon,height: 15,width: 15,color: appGreyBlackColor,),
                    ),
                    SizedBox(width: 2,),
                    SizedBox(
                      width: location.isNotEmpty?MediaQuery.of(context).size.width*0.38:MediaQuery.of(context).size.width*0.8,
                        child: Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                  ],
                ),
              ):Container(),
              SizedBox(width: 2,),
              designation.isNotEmpty &&location.isNotEmpty?Container(
                width: 1,
                height: 26,
                color: appGreyBlackColor,
              ):Container(),
              SizedBox(width: 5,),
              location.isNotEmpty?Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2,left: 4),
                    child: SvgPicture.asset(appLocationsSvgIcon,height: 15,width: 15,color: appGreyBlackColor,),
                  ),
                  SizedBox(width: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.37,
                      child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                ],
              ):Container(),
            ],
          ),
          SizedBox(height: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 2,left: 4),
                child: SvgPicture.asset(appDataPostedIconSvg,height: 15,width: 15,color: appGreyBlackColor,),
              ),

              SizedBox(width: 2,),
              Text(dataPosted,style: AppTextStyles.font12w500.copyWith(color: isPastData?appRedColor:appBlackColor),maxLines: 2,),
            ],
          ),
        ],
      ),
    ),
  );
}

_profileWidget(context,{required String profileImage,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick,required bool isProfileVerified}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.46,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: userName,
                        style: AppTextStyles.font16W700.copyWith(color: appBlackColor),
                      ),
                      if (isProfileVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              appVerifiedIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  Text("$appId:$ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                  SizedBox(width: 5,),
                  ratingStar!="0"?Row(
                    children: <Widget>[
                      SvgPicture.asset(appRatingBarSvg,height: 15,width: 15,),
                      Text("$ratingStar ${ratingStar=="1"?appStar:appStars}",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                    ],
                  ):Container()
                ],
              )

            ],
          )
        ],
      ),
      GestureDetector(
        onTap: (){
          onClick();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: appPrimaryColor
          ),
          child:  Text(buttonName,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
        ),
      )
    ],
  );
}


String dateCombination({required String joiningDate, required String endDate, bool isPresent = false}) {
  // Check if joiningDate is empty
  if (joiningDate.isEmpty) {
    return "Invalid Joining Date";
  }

  // Parsing input dates
  DateTime? joining;
  DateTime? end;

  try {
    joining = DateTime.parse(joiningDate);
    if (!isPresent && endDate.isNotEmpty) {
      end = DateTime.parse(endDate);
    }
  } catch (e) {
    return "Invalid Date Format";
  }

  // Formatting dates
  String formattedJoiningDate = '${joining.day} ${_getMonthName(joining.month)} ${joining.year}';
  String formattedEndDate = isPresent
      ? 'Present'
      : (end != null ? '${end.day} ${_getMonthName(end.month)} ${end.year}' : 'Invalid End Date');

  return '$formattedJoiningDate to $formattedEndDate';
}

// Helper function to get month name
String _getMonthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month];
}


commonCompanyJobWidget(context,{required String profileImage,required String timeAgo,required String noOfVaccency,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick,required Function() markAsCompleted,required Function() isEdit,required bool isProfileVerified,required double cardWidth}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _companyJonProfileWidget(context,profileImage: profileImage,noOfVaccency:noOfVaccency, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick, jobStatus: jobStatus, salary: salary,experienceYear: experienceYear,vaccancy: vaccancy,locations: locations, timeAgo: timeAgo, markAsCompleted: markAsCompleted, isEdit: isEdit,isProfileVerified: isProfileVerified,cardWidth: cardWidth),
        ],
      ),
    ),
  );
}
_companyJonProfileWidget(context,{required String profileImage,required String noOfVaccency,required String timeAgo,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick,required Function() markAsCompleted,required Function() isEdit,required bool isProfileVerified,required double cardWidth }) {
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 10),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: cardWidth*0.88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        commonUserNameWidget(context, userName: userName, isProfileVerified: isProfileVerified, width: cardWidth*0.74),
                        // Expanded(
                        //     flex: 2,
                        //     child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,overflow:TextOverflow.fade,)),
                        noOfVaccency!="0"?GestureDetector(
                          onTap: (){
                            onClick();
                          },
                          child: Expanded(
                              child: Text("$noOfVaccency$appApplicants",style: AppTextStyles.font12.copyWith(color: appPrimaryColor),)),
                        ):Container()
                      ],
                    ),
                  ),
                  Text(jobStatus,style: AppTextStyles.font12.copyWith(color: jobStatus==appInDraft?appPrimaryColor:jobStatus==appCompleted?appRedColor:appGreenColor),maxLines: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: SvgPicture.asset(appSalarySvgIcon,height: 15,width: 15,),
                              ),
                              SizedBox(width: 2,),
                              SizedBox(
                                  child: Text(salary,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 1,
                          height: 20,
                          color: appGreyBlackColor,
                        ),
                        SizedBox(width: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: SvgPicture.asset(appExperenceIconSvg,height: 15,width: 15,),
                            ),
                            SizedBox(width: 2,),
                            SizedBox(
                                child: Text(experienceYear,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: SvgPicture.asset(appVaccencySvg,height: 15,width: 15,),
                      ),

                      SizedBox(width: 2,),
                      Text("$vaccancy $appVacancies",style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          isEdit();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: appPrimaryColor,width: 1)
                            ),
                            child: Text(appEdit,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
                        ),
                      ),
                      SizedBox(width: 6,),
                      jobStatus==appCompleted?Container():GestureDetector(
                        onTap: (){
                          markAsCompleted();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: appPrimaryColor,width: 1)
                            ),
                            child: Text(appMarkAsComplete,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
                        ),
                      ),
                    ],
                  )

                ],
              )
            ],
          ),

        ],
      ),
      SizedBox(height: 10,),
      Container(
        height: 1,
        color: appPrimaryBackgroundColor,
      ),
      SizedBox(height: 10,),
      SizedBox(
        //width: MediaQuery.of(context).size.width*0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: SvgPicture.asset(appLocationsSvgIcon,height: 15,width: 15,),
                ),
                SizedBox(width: 2,),
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.58,
                    child: Text(locations,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
              ],
            ),
            timeAgo.isNotEmpty?Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),):Container(),
          ],
        ),
      )
    ],
  );
}


commonCompanyApplicantWidget(context,{required String profileImage,required String timeAgo,required String noOfVaccency,required String profileDesignation,required String email,required String phone,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick,required bool isProfileVerified,required double cardWidth}){
  return Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _companyApplicantProfileWidget(context,profileImage: profileImage,noOfVaccency:noOfVaccency, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick, jobStatus: jobStatus, salary: salary,experienceYear: experienceYear,vaccancy: vaccancy,locations: locations, timeAgo: timeAgo, email: email, phone: phone,profileDesignation:profileDesignation, isProfileVerified: isProfileVerified,cardWidth: cardWidth),
        ],
      ),
    ),
  );
}

_companyApplicantProfileWidget(context,{required String profileImage,required String noOfVaccency,required String email,required String profileDesignation,required String phone,required String timeAgo,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick,required bool isProfileVerified,required double cardWidth}) {
  return SizedBox(
    width: cardWidth,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                commonUserNameWidget(context,userName: userName, isProfileVerified: isProfileVerified, width:cardWidth*0.84),
                Row(
                  children: <Widget>[
                    Text("$appId:$ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                    SizedBox(width: 8,),
                    ratingStar!="0"?Row(
                      children: <Widget>[
                        SvgPicture.asset(appRatingBarSvg,height: 15,width: 15,),
                        Text("$ratingStar ${ratingStar=="1"?appStar:appStars}",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                      ],
                    ):Container()
                  ],
                ),
                locations.isNotEmpty?Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SvgPicture.asset(appLocationsSvgIcon,height: 15,width: 15,),
                    ),
                    SizedBox(width: 2,),
                    SizedBox(
                        width: cardWidth*0.82,
                        child: Text(locations,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                  ],
                ):Container(),
                SizedBox(height: 2,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SvgPicture.asset(appEmail,height: 15,width: 15,),
                    ),
                    SizedBox(width: 2,),
                    SizedBox(
                        width: cardWidth*0.82,
                        child: Text(email,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                  ],
                ),
                SizedBox(height: 2,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SvgPicture.asset(appPhoneIcon,height: 15,width: 15,),
                    ),

                    SizedBox(width: 2,),
                    Text(phone,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,),
                  ],
                ),



              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width*0.85,
          height: 1,
          color: appPrimaryBackgroundColor,
        ),
        SizedBox(height: 10,),
        SizedBox(
          width: cardWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: SvgPicture.asset(appExperenceIconSvg,height: 15,width: 15,),
                  ),
                  SizedBox(width: 4,),
                  SizedBox(
                      child: Text(profileDesignation,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),maxLines: 2,)),
                ],
              ),
              timeAgo.isNotEmpty?Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),):Container(),
            ],
          ),
        )
      ],
    ),
  );
}


companyEmploymentRequestWidget(context,{required String profileImage,required String initialName,required String userName,required String jobStatus,required Function() onClick,required String ccId,required String designation,required String dataPosted,bool isApproved=false,bool isUpdates=false,bool isRejected=false,required String approved, required Function() isAcceptClick,required Function() isRejectClick,required bool isProfileVerified,required double cardWidth}){
  var joiningDate=dataPosted.split("-")[0];
  var workedTillDate=dataPosted.split("-")[1];
  return Card(
     // higher value = more shadow
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          if(isRejected==false)
            _companyEmploymentWidget(context,profileImage: profileImage,initialName: initialName,userName: userName,onClick: onClick,jobStatus: jobStatus,ccId: ccId,designation: designation,isApproved: isApproved,isUpdate: isUpdates,isRejected: isRejected, joiningDate: joiningDate,workedTillDate: workedTillDate,approved:approved, isAcceptClick: isAcceptClick, isRejectClick: isRejectClick, isProfileVerified: isProfileVerified,cardWidth: cardWidth),
          if(isRejected)
            _rejectedEmploymentWidget(context,profileImage: profileImage,initialName: initialName,userName: userName,onClick: onClick,jobStatus: jobStatus,ccId: ccId,dataPosted: dataPosted,designation: designation,cardWidth: cardWidth,isProfileVerified: isProfileVerified)


        ],
      ),
    ),
  );
}

_rejectedEmploymentWidget(context, {required String profileImage, required String initialName, required String userName, required Function() onClick, required String jobStatus, required String ccId, required String dataPosted, required String designation,required double cardWidth,required bool isProfileVerified}) {
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: cardWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonUserNameWidget(context, userName: userName, isProfileVerified: isProfileVerified, width: cardWidth*0.8),
                        // Expanded(
                        //     flex: 2,
                        //     child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,overflow:TextOverflow.fade,)),
                        GestureDetector(
                          onTap: (){
                            onClick();
                          },
                          child: Text(jobStatus,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("$appId:$ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                          SizedBox(height: 2,),
                          SizedBox(
                            width: cardWidth*0.86,//MediaQuery.of(context).size.width*0.51,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: SvgPicture.asset(appDesignationSvgIcon,height: 15,width: 15,),
                                ),
                                SizedBox(width: 2,),
                                SizedBox(
                                    child: Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appRedTwoColor,width: 1)
                          ),
                          child: Text(appRejected,style: AppTextStyles.font12.copyWith(color: appRedTwoColor),maxLines: 2,)
                      ),
                    ],
                  ),
                  SizedBox(height: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(appDataPostedIconSvg,height: 15,width: 15,),
                        ),
                        SizedBox(width: 2,),
                        SizedBox(
                            child: Text(dataPosted,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),

                ],
              )
            ],
          ),

        ],
      ),
      SizedBox(height: 4,),
    ],
  );
}

_companyEmploymentWidget(context,{required String profileImage,required String initialName ,required String userName,required String jobStatus,required Function() onClick,required String ccId,required String designation,required String joiningDate,required String workedTillDate,required bool isApproved,required bool isUpdate,required bool isRejected, required String approved, required Function() isAcceptClick,required Function() isRejectClick,required bool isProfileVerified,required double cardWidth}) {
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: cardWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonUserNameWidget(context, userName: userName, isProfileVerified: isProfileVerified, width: cardWidth*0.8),
                        // Expanded(
                        //   flex: 2,
                        //     child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,overflow:TextOverflow.fade,)),
                        GestureDetector(
                          onTap: (){
                            onClick();
                          },
                          child: Text(jobStatus,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                        )
                      ],
                    ),
                  ),
                  Text("$appId:$ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                  SizedBox(height: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(isUpdate?appSalarySvgIcon:appDesignationSvgIcon,height: 15,width: 15,color: appGreyBlackColor,),
                        ),
                        SizedBox(width: 2,),
                        SizedBox(
                            child: Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(appDataPostedIconSvg,height: 15,width: 15,color: appGreyBlackColor,),
                        ),
                        SizedBox(width: 2,),
                        
                        SizedBox(
                            child: Row(
                              children: <Widget>[
                                Text(joiningDate,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 1,),
                                SizedBox(width: 5,),
                                Transform.rotate(
                                  angle:  math.pi,
                                  child: SvgPicture.asset(
                                    appBackSvgIcon,
                                    height: 10,
                                    width: 10,
                                    color: appGreyBlackColor,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(workedTillDate,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 1,),
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  SizedBox(height: 8,),
                  if(approved=="0")
                  Column(
                    children: <Widget>[
                      if(isApproved==false)
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                isAcceptClick();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: appPrimaryColor,width: 1)
                                  ),
                                  child: Text(appAccept,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
                              ),
                            ),
                            SizedBox(width: 6,),
                            GestureDetector(
                              onTap: (){
                                isRejectClick();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: appPrimaryColor,width: 1)
                                  ),
                                  child: Text(appReject,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
                              ),
                            ),
                          ],
                        ),
                      if(isApproved)
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                isAcceptClick();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appPrimaryColor,
                                      border: Border.all(color: appPrimaryColor,width: 1)

                                  ),
                                  child: Text(appAddReview,style: AppTextStyles.font12.copyWith(color: appWhiteColor),maxLines: 2,)
                              ),
                            ),
                            SizedBox(width: 6,),
                            GestureDetector(
                              onTap: (){
                                isRejectClick();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: appRedTwoColor,width: 1)
                                  ),
                                  child: Text(appLeftCompany,style: AppTextStyles.font12.copyWith(color: appRedTwoColor),maxLines: 2,)
                              ),
                            ),
                          ],
                        )
                    ],
                  )

                ],
              )
            ],
          ),

        ],
      ),
      SizedBox(height: 4,),
    ],
  );
}


mostViewedJos(context,{required String designation,required String timeAgo,required String locations,required String noOfVaccency,required Function() viewApplicationClick}){
  return Container(
    padding: EdgeInsets.only(top: 5,bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child:Row(
            children: <Widget>[
              Text(designation,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
              SizedBox(width: 5,),
              Text(timeAgo,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
            ],
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(locations,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                SizedBox(width: 5,),
                Text("$noOfVaccency $appApplicants",style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
              ],
            ),
            GestureDetector(
              onTap: (){
                viewApplicationClick();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: appPrimaryColor
                ),
                child: Text(appViewApplications,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
              ),
            )
          ],
        )
      ],
    ),
  );
}



commonEmployeeReviewWidget(context,{required String profileImage,required String timeAgo,required String noOfVaccency,required String profileDesignation,required String date,required String email,required String phone,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}){
  return Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _companyEmployeeReviewWidget(context,profileImage: profileImage,initialName: initialName, userName: userName, designation: profileDesignation, date: date,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("4.0",style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
              SizedBox(width: 5,),
              commonRattingBar(
                  context,
                  size: 16,
                  padding: 1,
                  initialRating: 2.0,
                  updatedRating: (double rating){

                  }
              )
            ],
          ),
          SizedBox(height: 4,),
          SizedBox(
           width: MediaQuery.of(context).size.width*0.7,
            child: commonReadMoreWidget(context,message: 'this review on executive profile  this review on executive profile this review on executive profile', textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor)),
          ),
          SizedBox(height: 6,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              'URL: ${"https://www.collarcheckbeta.com/employee/rakesh-maurya"}',
              style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
            ),
          ),
          SizedBox(height: 14,),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: appPrimaryColor,width: 1)
                  ),
                  child: Text(appAccept,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
              ),
              SizedBox(width: 6,),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: appPrimaryColor,width: 1)
                  ),
                  child: Text(appReject,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

_companyEmployeeReviewWidget(context, {required String profileImage,required String initialName,required String userName,required String designation,required String date}) {
  return Container(
    child: Column(
      children: <Widget>[
        _profileReciewWidget(context, profileImage: profileImage, initialName: initialName, userName: userName, designation: designation, date: date)
      ],
    ),
  );

}

_profileReciewWidget(context,{required String profileImage,required String initialName,required String userName,required String designation,required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          commonImageWidget(image: profileImage, initialName: initialName, height: 50, width: 50, borderRadius: 100),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,),
                  SizedBox(width: 5,),
                  Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),

                ],
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(date,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
      )
    ],
  );
}


companyRecommendedWidget(context,{required String profileImage,required String initialName,required String userName,required String ratingBar,required String ccId,required String designation,required String location,required Function() viewProfileClick,required double cardWidth,required bool isProfileVerified}){
  return  Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: cardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                commonImageWidget(
                    image: profileImage,
                    initialName: initialName,
                    height: 50,
                    width: 50,
                    borderRadius: 100),
                GestureDetector(
                  onTap: (){
                    viewProfileClick();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: appPrimaryColor
                    ),
                    child: Text(appViewProfile,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          SizedBox(
            width: cardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                commonUserNameWidget(context, userName: userName, isProfileVerified: isProfileVerified, width: ratingBar=="0.0"?cardWidth:cardWidth*0.8,),
                // SizedBox(
                //     width:
                //     child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),)
                // ),
                ratingBar=="0.0"?Container():Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(appRatingBarSvg,height: 16,width: 16,),
                    SizedBox(width: 5,),
                    Text("$ratingBar${ratingBar=="1.0"?appStar:appStars}",style: AppTextStyles.font12.copyWith(color: appGreyBlackColor),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 2,),
          Text("$appId $ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
          designation.isNotEmpty?SizedBox(height: 5,):SizedBox(height: 0,),
          designation.isNotEmpty?Row(
            children: <Widget>[
              SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,),
              SizedBox(width: 5,),
              Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
            ],
          ):Container(),
          location.isNotEmpty?SizedBox(height: 10,):SizedBox(height: 0,),
          location.isNotEmpty? Row(
            children: <Widget>[
              SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
              SizedBox(width: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.56,
                  child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
            ],
          ):Container(),
        ],
      ),
    ),
  );
}

recentlyJoinedWidget(context,{required String profileImage,required String initialName,required String userName,required String ratingBar,required String ccId,required String designation,required String location,required Function() addReview}){
  return  Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          commonImageWidget(
              image: profileImage,
              initialName: initialName,
              height: 50,
              width: 50,
              borderRadius: 100),
          SizedBox(height: 5,),
          Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,),
              SizedBox(width: 5,),
              Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
            ],
          ),
          SizedBox(height: 8,),
          GestureDetector(
            onTap: (){
              addReview();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: appPrimaryColor
              ),
              child: Text(appAddReviewText,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
            ),
          )
        ],
      ),
    ),
  );
}

savedCandidates(context,{required List profileImage,required String initialName,required String designation,required String noOfJobs}){
  return  Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryBackgroundColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],

      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(designation,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
          Text("$noOfJobs+ ${noOfJobs=="1"?appEmployee+appAreSaved:appEmployees+appAreSaved}",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),

          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children: List.generate(
                profileImage.length > 3 ? 4 : profileImage.length,
                    (index) {
                  if (index < 3) {
                    return commonImageWidget(
                      image: profileImage[index],
                      initialName: initialName,
                      height: 30,
                      width: 30,
                      borderRadius: 100,
                    );
                  } else {
                    // index == 3 and length > 3 → show "+N"
                    return GestureDetector(
                      onTap: () {
                        // Handle show all profiles
                        print("Tapped on Add More");
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appPrimaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "+${profileImage.length - 3}",
                            style: AppTextStyles.font12w500.copyWith(color: appWhiteColor),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Text(appViewAll,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
          )


        ],
      ),
    ),
  );
}


commonCompanyReviewWidget(context,{required String profileImage,required String username,required String designation,required String ratingsStar,required bool isProfileVerified,required String buttonName,required Function() onClick,required String noOfReview,required String pendingReview,}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _ratingProfileWidget(context,profileImage: profileImage, initialName: username, userName: username, ratingStar: ratingsStar, buttonName: buttonName,onClick: onClick, isProfileVerified: isProfileVerified, designation: designation, noOfReview: noOfReview,pendingReview: pendingReview),

        ],
      ),
    ),
  );

}

_ratingProfileWidget(context,{required String designation,required String profileImage,required String initialName,required String userName,required String ratingStar,required String buttonName,required Function() onClick,required bool isProfileVerified,required String noOfReview,required String pendingReview,}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
          SizedBox(width: 7,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.46,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: userName,
                        style: AppTextStyles.font16W700.copyWith(color: appBlackColor),
                      ),
                      if (isProfileVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              appVerifiedIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,color: appGreyBlackColor,),
                  SizedBox(width: 4,),
                  Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)
                ],
              ),
              SizedBox(height: 2,),
              Row(
                children: <Widget>[
                  Text(ratingStar,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                  SizedBox(width: 5,),
                  commonRattingBar(
                      context,
                      ignoreGesture: true,
                      initialRating: double.parse(ratingStar.toString()),
                      updatedRating: (value){},
                    size: 16,
                    padding: 1
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('$appNoOfReview$noOfReview',style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                    SizedBox(width: 5,),
                    Container(height: 20,width: 1,color: appGreyBlackColor,),
                    SizedBox(width: 5,),
                    Text('$appPendingReview$pendingReview',style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                  ],
                ),
              )


            ],
          )
        ],
      ),
      GestureDetector(
        onTap: (){
          onClick();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: appPrimaryColor
          ),
          child:  Text(buttonName,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
        ),
      )
    ],
  );
}



///For Specifi user rating widget
commonCompanyUserReviewWidget(context,{required String profileImage,required String username,required String designation,required String ratingsStar,required bool isProfileVerified,required String date,required Function() onClick,required String noOfReview,required String pendingReview,required String description,required String buttonName,required bool isEditReview,required Function() onAcceptOrEditReview,required Function() onReject,required bool isApprovedReview,required bool isShowViewMore,required bool isShowViewHistory,required Function() onClickViewHistory}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ratingUserProfileWidget(context,profileImage: profileImage, initialName: username, userName: username, date: date,onClick: onClick, isProfileVerified: isProfileVerified, designation: designation, noOfReview: noOfReview,pendingReview: pendingReview),
          SizedBox(height: 2,),
          Padding(padding: EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(ratingsStar,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
                  SizedBox(width: 5,),
                  commonRattingBar(
                      context,
                      ignoreGesture: true,
                      initialRating: double.parse(ratingsStar.toString()),
                      updatedRating: (value){},
                      size: 16,
                      padding: 1
                  ),
                  isShowViewHistory?SizedBox(width: 5,):SizedBox(width: 0,),
                  isShowViewHistory?GestureDetector(
                    onTap: (){
                      onClickViewHistory();
                    },
                      child: Text(appViewHistory,style: AppTextStyles.font12W500Underline.copyWith(color: appGreyBlackColor,),)):Container(),
                ],
              ),
              SizedBox(height: 4,),
              commonReadMoreWidget(
                  context,
                  message: description,
                  textStyle: AppTextStyles.font12.copyWith(color: appGreyBlackColor)
              ),
              isShowViewMore?SizedBox(height: 8,):SizedBox(height: 0,),
              isShowViewMore?GestureDetector(
                onTap: (){
                  onClick();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appPrimaryColor
                  ),
                  child:  Text(appViewMore,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
                ),
              ):Container(),
              SizedBox(height: 12,),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          onAcceptOrEditReview();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: isEditReview?MediaQuery.of(context).size.width*0.25:MediaQuery.of(context).size.width*0.2,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appPrimaryColor,width: 1.0)
                          ),
                          child: Text(buttonName,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                        ),
                      ),
                      isApprovedReview?SizedBox(width: 10,):SizedBox(width: 0,),
                      isApprovedReview?Row(
                        children: <Widget>[
                          SvgPicture.asset(appVerifiedIcon,height: 20,width: 20,),
                          SizedBox(width: 4,),
                          Text(appApprovedReviews,style: AppTextStyles.font12.copyWith(color: appGreenColor),),
                        ],
                      ):Container()
                      
                    ],
                  ),
                  SizedBox(width: 10,),
                  isEditReview?Container():GestureDetector(
                    onTap: (){
                      onAcceptOrEditReview();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: appPrimaryColor,width: 1.0)
                      ),
                      child: Text(appReject,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                    ),
                  ),
                ],
              )
            ],
          ),)
        ],
      ),
    ),
  );

}

_ratingUserProfileWidget(context,{required String designation,required String profileImage,required String initialName,required String userName,required String date,required Function() onClick,required bool isProfileVerified,required String noOfReview,required String pendingReview,}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 100),
          SizedBox(width: 7,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.46,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: userName,
                        style: AppTextStyles.font16W700.copyWith(color: appBlackColor),
                      ),
                      if (isProfileVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              appVerifiedIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,color: appGreyBlackColor,),
                  SizedBox(width: 4,),
                  Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)
                ],
              ),


            ],
          )
        ],
      ),
      Text(date,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
    ],
  );
}
