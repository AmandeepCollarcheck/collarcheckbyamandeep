
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_strings.dart';
import '../image_path.dart';
import 'common_appbar.dart';

commonHeaderAndSeeAll({required String headerName,required Function seeAllClick, bool isShowViewAll=true}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(headerName,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
      isShowViewAll?GestureDetector(
        onTap: (){
          seeAllClick();
        },
        child: Container(
          padding: EdgeInsets.only(right: 20),
          child: Text(appSeeAll,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
        ),
      ):Container()
    ],
  );
}

commonCardWidget(context,{required String image,
  required double cardWidth,
  required String jobProfileName,
  required String companyName,
  required String salaryDetails,
  required String expDetails,
  required List programmingList,
  required bool isExpanded,
  required VoidCallback onExpandChanged,
  required String location,
  required String timeAgo,
  required Function() onClick,
  required Function() isApplyClick,
  bool isCompanyProfile=false,
  bool isApplied=false,

}){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      width: cardWidth,
      padding: EdgeInsets.all(10),
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
        //border: Border.all(color: appGreyBlackColor,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _companyDetails(
            context,
              image: image,
              isCompanyProfile: isCompanyProfile,
              jobProfileName: jobProfileName,
              companyName: companyName,
              salaryDetails: salaryDetails,
              expDetails: expDetails,
            isApplied: isApplied,
            isApplyClick: isApplyClick,
          ),
          SizedBox(height: 20,),
          programmingKnowledge(context,programmingList: programmingList,isExpanded:isExpanded, itemCount: programmingList.length,onExpandChanged: onExpandChanged ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            height: 1,
            width: MediaQuery.of(context).size.width*0.81,
            color: appPrimaryBackgroundColor,
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                location.isNotEmpty?Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 1,),
                    )
                  ],
                ):Container(),
                timeAgo.isNotEmpty?Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),):Container(),
              ],
            ),
          )
        ],
      ),
    ),
  );
}



appliedCommonCardWidget(context,{required String image,
  required double cardWidth,
  required String jobProfileName,
  required String companyName,
  required String salaryDetails,
  required String expDetails,
  required bool isExpanded,
  required VoidCallback onExpandChanged,
  required String location,
  required Function() onClick,
  //required Function() isApplyClick,
  bool isApplied=false,

}){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      width: cardWidth,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: appBlackShadowColor,
        //     offset: Offset(0, 5),
        //     blurRadius: 10,
        //     spreadRadius: 2,
        //   ),
        // ],
        borderRadius: BorderRadius.circular(10),
        color: appCardWhiteColor,
        //border: Border.all(color: appGreyBlackColor,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _companyDetails(
            context,
            image: image,
            jobProfileName: jobProfileName,
            companyName: companyName,
            salaryDetails: salaryDetails,
            expDetails: expDetails,
            isApplied: true,
            isApplyClick: (){},
          ),
          SizedBox(height: 20,),
        //  _programmingKnowledge(context,programmingList: programmingList,isExpanded:isExpanded, itemCount: programmingList.length,onExpandChanged: onExpandChanged ),
          //SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            height: 1,
            width: MediaQuery.of(context).size.width*0.81,
            color: appPrimaryBackgroundColor,
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 1,),
                    )
                  ],
                ),
                //Text(timeAgo,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
              ],
            ),
          )
        ],
      ),
    ),
  );
}




programmingKnowledge(context,{required List programmingList,required bool isExpanded,required VoidCallback onExpandChanged ,required int itemCount }) {
  return SizedBox(
   // height: 50,
    width: MediaQuery.of(context).size.width*0.8,
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       // maxCrossAxisExtent: 140, // Adjust this value based on max text size
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 26, crossAxisCount: 4, // Fixed height
      ),
      itemCount: isExpanded ||itemCount<3? itemCount : 4, // Add "More" button if collapsed
      itemBuilder: (context, index) {
        if (!isExpanded && index == 3 && programmingList.length >= 3) {
          return _buildMoreButton(onExpandChanged: onExpandChanged);
        }
        String name = programmingList[index].name.toString();
        RegExp regExp = RegExp(r'name:\s*([\w\s]+)');
        Match? match = regExp.firstMatch(name);


        return programmingList.isNotEmpty?_buildGridItem(match?.group(1)??programmingList[index].name.toString()):Container();
      },
    ),
  );

}
Widget _buildMoreButton({required VoidCallback onExpandChanged}) {
  return GestureDetector(
    onTap: onExpandChanged,
    child: Container(
      alignment: Alignment.centerLeft,
      child:Text("+$appMore",style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
    ),
  );
}




Widget _buildGridItem(String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: appWhiteColor,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: appPrimaryColor,width: 1)
    ),
    child: Text(text, style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor)),
  );
}
_companyDetails(context,{
  required String image,
  required String jobProfileName,
  required String companyName,
  required String salaryDetails,
  required String expDetails,
  bool isCompanyProfile=false,
  bool isApplied=false,
  required Function() isApplyClick,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      image.isNotEmpty?ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: image.endsWith(".svg")?SvgPicture.network(image,height: 50,width: 50,fit: BoxFit.cover,):image.contains("https")?Image.network(image,height: 50,width: 50,fit: BoxFit.cover,):Image.asset(image,height: 50,width: 50,fit: BoxFit.cover,),
      ): Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [getRandomColor(),getRandomColor()]
            )
        ),
        child: Text(getInitialsWithSpace(input: jobProfileName??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
      ),
      SizedBox(width: 16,),
      Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width:MediaQuery.of(context).size.width*0.50,
              child:  Text(jobProfileName,style: AppTextStyles.bold.copyWith(color: appBlackColor),overflow: TextOverflow.clip,maxLines: 1,),
            ),
            companyName!=null&&companyName.isNotEmpty?SizedBox(
                width:MediaQuery.of(context).size.width*0.5,
                child: Text(companyName,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),overflow: TextOverflow.clip,maxLines: 3,)):Container(),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                salaryDetails!=null&&salaryDetails.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appSalarySvgIcon,height: 15,width: 15,),
                    SizedBox(width: 2,),
                    Text(salaryDetails,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                  ],
                ):Container(),
                salaryDetails!=null&&salaryDetails.isNotEmpty?SizedBox(width: 5,):SizedBox(width: 0,),
                (salaryDetails!=null&&salaryDetails.isNotEmpty)&&(appExperenceIconSvg!=null&&appExperenceIconSvg.isNotEmpty)? Container(
                  height: 18,
                  width: 1,
                  color: appGreyBlackColor,
                ):Container(),
                SizedBox(width: 5,),
                appExperenceIconSvg!=null&&appExperenceIconSvg.isNotEmpty?Row(
                  children: <Widget>[
                    SvgPicture.asset(appDesignationSvgIcon,height: 15,width: 15,),
                    SizedBox(width: 2,),
                    Text(expDetails,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                  ],
                ):Container(),
              ],
            )
          ],
        ),
      ),
      if(isCompanyProfile==false)
      isApplied?Text(appApplied,style: AppTextStyles.font14W500.copyWith(color: appGreenColor),):GestureDetector(
        onTap: (){
          isApplyClick();
        },
        child: SvgPicture.asset(appApplyIconNew,height: 24,width: 24,),
        // child: Row(
        //   children: <Widget>[
        //     SvgPicture.asset(appApplySvgIcon,height: 16,width: 16,),
        //     Text(appApply,style: AppTextStyles.font14W500.copyWith(color: appPrimaryColor),),
        //   ],
        // ),
      )
    ],
  );
}


betterReachWidget(context,{required String headerText,required String profileCompletePercentage,required Function(String) onCardClick}){
  return GestureDetector(
    onTap: (){
      onCardClick(headerText);
    },
    child: Container(
      width: MediaQuery.of(context).size.width*0.7,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: appPrimaryColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(headerText,style: AppTextStyles.font14W700.copyWith(color: appWhiteColor),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  onCardClick(headerText);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: appWhiteColor
                  ),
                  child: Text("$appAdd+",style: AppTextStyles.font12.copyWith(color: appPrimaryColor),),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: appWhiteColor,width: 1)
            ),
            child: Text("+$profileCompletePercentage%",style: AppTextStyles.font14W700.copyWith(color: appWhiteColor)),
          )
        ],
      )
    ),
  );
}

topCompaniesWidget({required String jobTypeName,required String numberOfCompany,required List allCompanyIcon}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: appBlackShadowColor,
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      borderRadius: BorderRadius.circular(10.0),
      color: appWhiteColor
    ),
    child: Column(
      children: <Widget>[
        Text(jobTypeName,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
        Text("$numberOfCompany$appCompaniesAreHiring",style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
        SizedBox(height: 15,),
        _companyList(companyImage: allCompanyIcon),
        SizedBox(height: 10,),
        GestureDetector(
          child: Text(appExploreMore,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
        )
      ],
    ),
  );
}

_companyList({required List companyImage}) {
  return SingleChildScrollView(
    child: Wrap(
      spacing: 5,
      children: List.generate(companyImage.length, (index){
        return companyImage[index].toString().contains("https")?ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: companyImage[index].toString().contains("https")?Image.network(companyImage[index],height: 30,width: 30,fit: BoxFit.cover,):Image.asset(companyImage[index],height: 30,width: 30,fit: BoxFit.cover,),
        ):Container();
      }),
    ),
  );
}


commonTopCompaniesWidget(context,{
  required String image,
  required String name,
  required String id,
  required String jobTitle,
  required String location,
  bool isSimilerProfile=false,
  bool isFollowData=true,
  bool isFollowing=false,
  required Function onClick,
  required Function onMessageClick
}){
  return Card(
    color: appWhiteColor,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: appBlackShadowColor,
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: isFollowData?BorderRadius.circular(10):BorderRadius.circular(100),
                  border: Border.all(color: appGreyBlackColor,width: 0.5)
                ),
                child: image.isNotEmpty?Padding(
                  padding: isSimilerProfile?EdgeInsets.all(0):EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: isFollowData?BorderRadius.circular(10):BorderRadius.circular(100),
                    child: Image.network(image,height: 40,width: 40,fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                      return Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: isFollowData?BorderRadius.circular(10):BorderRadius.circular(100),
                            gradient: LinearGradient(
                                colors: [getRandomColor(),getRandomColor()]
                            )
                        ),
                        child: Text(getInitialsWithSpace(input: name??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
                      );
                    },),
                  ),
                ):Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: isFollowData?BorderRadius.circular(10):BorderRadius.circular(100),
                      gradient: LinearGradient(
                          colors: [getRandomColor(),getRandomColor()]
                      )
                  ),
                  child: Text(getInitialsWithSpace(input: name??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: isFollowData?MediaQuery.of(context).size.width*0.57:MediaQuery.of(context).size.width*0.57,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
                    id.isNotEmpty?Text("ID: $id",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),):Container(),
                  ],
                ),
              ),
              isFollowData?GestureDetector(
                onTap: (){
                  if(isFollowing){

                  }else{
                    onClick();
                  }

                },
                child: isFollowing?Text(appFollowing,style: AppTextStyles.font12.copyWith(color: appGreenColor),):SvgPicture.asset(appFollowCircular,height: 24,width: 24,),
              ):Container(),
             isSimilerProfile?GestureDetector(
               onTap: (){
                 onMessageClick();
               },
               child:  SvgPicture.asset(appMessageCircular,height: 24,width: 24,),
             ):Container()
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50,
                  ),
                  jobTitle.isNotEmpty?Row(
                    children: <Widget>[
                      SvgPicture.asset(appExperenceIconSvg,height: 16,width: 16,),
                      SizedBox(width: 5,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Text(jobTitle,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,)),
                    ],
                  ):Container(),
                  Container(),
                ],
              ),
              jobTitle.isNotEmpty?SizedBox(height: 5,):SizedBox(height: 0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50,
                  ),
                  location.isNotEmpty?Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                      SizedBox(width: 5,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,)),
                    ],
                  ):Container(),
                  Container(),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
allRightReservedWidget() {
  return Container(
    margin: EdgeInsets.only(top: 20,bottom: 40),
    child: Text("© 2025 CollarCheck | All Rights Reserved.",style: AppTextStyles.font12.copyWith(color: appGreyBlackColor),),
  );
}




commonTextFieldTitle({required String headerName,bool isMendatory=false}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(headerName,style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
      SizedBox(width: 5,),
      isMendatory?Text("*",style: AppTextStyles.font12w500.copyWith(color: appRedColor),):Column(),
    ],
  );
}

commonTextFieldTitleWithVerification({required String headerName,bool isMendatory=false, isVerify=false, required Function() onVerifyClick,bool isMobile=false}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(headerName,style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),),
      SizedBox(width: 5,),
      isMendatory?Text("*",style: AppTextStyles.font12w500.copyWith(color: appRedColor),):Column(),
      SizedBox(width: 5,),
      isVerify?SvgPicture.asset(appVerifiedIcon,height: 20,width: 20,):GestureDetector(
        onTap: (){
          onVerifyClick();
        },
        child: Text(isMobile?appEdit:appVerifyEmail,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
      )
    ],
  );
}


commonTopCompaniesWidgetWithFollowers(context,{
  required String image,
  required String name,
  required String id,
  required String jobTitle,
  required String location,
  bool isFollowBack=false,
  bool isRequest=false,
  bool isFollowers=true,
  required Function onClick,
  required Function onSecondClick
}){
  return Card(
    color: appWhiteColor,
    child: Container(
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: appBlackShadowColor,
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              image.isNotEmpty?ClipRRect(
                borderRadius:BorderRadius.circular(100),
                child: Image.network(image,height: 50,width: 50,fit: BoxFit.cover,),
              ):Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [getRandomColor(),getRandomColor()]
                    )
                ),
                child: Text(getInitialsWithSpace(input: name??""),style: AppTextStyles.font20W700.copyWith(color: appBlackColor)),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        //width: isRequest==false?MediaQuery.of(context).size.width*0.43:MediaQuery.of(context).size.width*0.51,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: isFollowers?MediaQuery.of(context).size.width*0.43:MediaQuery.of(context).size.width*0.48,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(name,style: AppTextStyles.font16W700.copyWith(color: appBlackColor),),
                                  Text("ID: $id",style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                ],
                              ),
                            ),
                            jobTitle.isNotEmpty?Row(
                              children: <Widget>[
                                SvgPicture.asset(appDesignationSvgIcon,height: 16,width: 16,),
                                SizedBox(width: 5,),
                                SizedBox(
                                    width: isRequest==true?MediaQuery.of(context).size.width*0.4:MediaQuery.of(context).size.width*0.38,
                                    child: Text(jobTitle,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,)),
                              ],
                            ):Container(),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                location.isNotEmpty?Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SvgPicture.asset(appLocationsSvgIcon,height: 16,width: 16,),
                                    SizedBox(width: 5,),
                                    SizedBox(
                                        width: isRequest==true?MediaQuery.of(context).size.width*0.4:MediaQuery.of(context).size.width*0.38,
                                        child: Text(location,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),overflow: TextOverflow.clip,maxLines: 2,)),
                                  ],
                                ):Container(),
                                Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isFollowers?GestureDetector(
                        onTap: (){
                          onClick();
                        },
                        child: Column(
                          children: <Widget>[
                            location.isNotEmpty|| jobTitle.isNotEmpty?Container(height: 20,):Container(height: 0,),
                            Container(
                                alignment: Alignment.center,
                                width: isRequest==true?74:84,
                                height: isRequest==true?26:26,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appPrimaryColor,width: 1)
                                ),
                                //padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                                child: Text( isRequest==true?appAccept:appMessages,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
                                )),
                            SizedBox(height: 5,),
                            isFollowBack?Container():GestureDetector(
                              onTap: (){
                                onSecondClick();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: isRequest==true?74:84,
                                  height: isRequest==true?26:26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: appPrimaryColor,width: 1)
                                  ),
                                  child: Text(isRequest==true?appReject:appFollowBack,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
                                  )),
                            )
                          ],
                        ),
                      ):Container(),
                      isFollowers==false?GestureDetector(
                        onTap: (){
                          onClick();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: appPrimaryColor,width: 1)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                            child: Text(appUnfollow,style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
                            )),
                      ):Container()



                    ],
                  ),
                ],
              )


            ],
          ),

        ],
      ),
    ),
  );
}