import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../image_path.dart';
import 'common_image_widget.dart';

commonCompanyWidget(context,{required String profileImage,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required String designation,required String location,required String dataPosted,required Function() onClick}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _profileWidget(context,profileImage: profileImage, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SvgPicture.asset(appDesignationSvgIcon,height: 15,width: 15,),
                    ),
                    SizedBox(width: 2,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.35,
                        child: Text(designation,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                  ],
                ),
              ),
              SizedBox(width: 2,),
              Container(
                width: 1,
                height: 20,
                color: appGreyBlackColor,
              ),
              SizedBox(width: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2),
                    child: SvgPicture.asset(appLocationsSvgIcon,height: 15,width: 15,),
                  ),
                  SizedBox(width: 2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.39,
                      child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                ],
              ),
            ],
          ),
          SizedBox(height: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: SvgPicture.asset(appDataPostedIconSvg,height: 15,width: 15,),
              ),

              SizedBox(width: 2,),
              Text(dataPosted,style: AppTextStyles.font12w500.copyWith(color: appBlackColor),maxLines: 2,),
            ],
          ),
        ],
      ),
    ),
  );
}

_profileWidget(context,{required String profileImage,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          commonImageWidget(image: profileImage, initialName: initialName, height: 50.0, width: 50.0, borderRadius: 10),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width*0.45,
                  child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,)),
              Row(
                children: <Widget>[
                  Text("$appId:$ccId",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                  SizedBox(width: 5,),
                  ratingStar!="0"?Row(
                    children: <Widget>[
                      SvgPicture.asset(appRatingBarSvg,height: 15,width: 15,),
                      Text("$ratingStar ${ratingStar=="1"?appStar:appStars}",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
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


commonCompanyJobWidget(context,{required String profileImage,required String timeAgo,required String noOfVaccency,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _companyJonProfileWidget(context,profileImage: profileImage,noOfVaccency:noOfVaccency, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick, jobStatus: jobStatus, salary: salary,experienceYear: experienceYear,vaccancy: vaccancy,locations: locations, timeAgo: timeAgo),
        ],
      ),
    ),
  );
}
_companyJonProfileWidget(context,{required String profileImage,required String noOfVaccency,required String timeAgo,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}) {
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
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,)),
                        GestureDetector(
                          onTap: (){
                            onClick();
                          },
                          child: Expanded(
                              child: Text("$noOfVaccency$appApplicants",style: AppTextStyles.font12.copyWith(color: appPrimaryColor),)),
                        )
                      ],
                    ),
                  ),
                  Text(jobStatus,style: AppTextStyles.font12.copyWith(color: appGreenColor),maxLines: 2,),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.35,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: SvgPicture.asset(appSalarySvgIcon,height: 15,width: 15,),
                            ),
                            SizedBox(width: 2,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Text(salary,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                          ],
                        ),
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 1,
                        height: 20,
                        color: appGreyBlackColor,
                      ),
                      SizedBox(width: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: SvgPicture.asset(appExperenceIconSvg,height: 15,width: 15,),
                          ),
                          SizedBox(width: 2,),
                          SizedBox(
                              width: MediaQuery.of(context).size.width*0.28,
                              child: Text(experienceYear,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                        ],
                      ),
                    ],
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
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appPrimaryColor,width: 1)
                          ),
                          child: Text(appEdit,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
                      ),
                      SizedBox(width: 6,),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appPrimaryColor,width: 1)
                          ),
                          child: Text(appMarkAsComplete,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),maxLines: 2,)
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
      Row(
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
                  width: MediaQuery.of(context).size.width*0.39,
                  child: Text(locations,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
            ],
          ),
          timeAgo.isNotEmpty?Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),):Container(),
        ],
      )
    ],
  );
}


commonCompanyApplicantWidget(context,{required String profileImage,required String timeAgo,required String noOfVaccency,required String profileDesignation,required String email,required String phone,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}){
  return Card(
    child: Container(
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _companyApplicantProfileWidget(context,profileImage: profileImage,noOfVaccency:noOfVaccency, initialName: initialName, userName: userName, ccId: ccId, ratingStar: ratingStar, buttonName: buttonName,onClick: onClick, jobStatus: jobStatus, salary: salary,experienceYear: experienceYear,vaccancy: vaccancy,locations: locations, timeAgo: timeAgo, email: email, phone: phone,profileDesignation:profileDesignation),
        ],
      ),
    ),
  );
}

_companyApplicantProfileWidget(context,{required String profileImage,required String noOfVaccency,required String email,required String profileDesignation,required String phone,required String timeAgo,required String locations,required String salary,required String experienceYear,required String vaccancy,required String jobStatus,required String initialName,required String userName,required String ccId,required String ratingStar,required String buttonName,required Function() onClick}) {
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
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            child: Text(userName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),maxLines: 2,)),
                      ],
                    ),
                  ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: SvgPicture.asset(appLocationsSvgIcon,height: 15,width: 15,),
                      ),
                      SizedBox(width: 2,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.66,
                          child: Text(locations,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),maxLines: 2,)),
                    ],
                  ),
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
                          width: MediaQuery.of(context).size.width*0.66,
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

        ],
      ),
      SizedBox(height: 10,),
      Container(
        height: 1,
        color: appPrimaryBackgroundColor,
      ),
      SizedBox(height: 10,),
      Row(
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
                  width: MediaQuery.of(context).size.width*0.39,
                  child: Text(profileDesignation,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),maxLines: 2,)),
            ],
          ),
          timeAgo.isNotEmpty?Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),):Container(),
        ],
      )
    ],
  );
}
