import 'package:collarchek/topCompanies/top_companies_controller.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class TopCompaniesPage extends GetView<TopCompaniesController>{
  const TopCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                  leadingIcon: appBackIcon,
                  screenName: appTopCompanies,
                  isFilterShow: true,
                  actionButton: appFilterMore,
                  onClick: (){
                    controller.backButtonClick();
                  },
                  onShareClick: (){},
                  onFilterClick:(){},
                  isScreenNameShow: true,
                  isShowShare: false
              ),
              Container(
                  color: appPrimaryBackgroundColor,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Obx((){
                            var topCompaniesList=controller.topCompaniesData.value.data?.companyList??[];
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(fontSize: 16, color: appBlackColor), // Default text style
                                children: [
                                  TextSpan(
                                    text:  topCompaniesList.length.toString()??"0",
                                    style: AppTextStyles.font14.copyWith(color: appPrimaryColor), // Normal text style
                                  ),
                                  TextSpan(
                                    text: appCompaniesFound,
                                    style:  AppTextStyles.font14.copyWith(color: appBlackColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {

                                        // Navigate to Terms of Use page or any action
                                      },
                                  ),
                                ],
                              ),
                            );
                          }),
                          GestureDetector(
                            child: Image.asset(appShortIcon,height: 20,width: 20,),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                     Obx((){
                       var allTopCompanies=controller.topCompaniesData.value.data?.companyList??[];
                       return  allTopCompanies!=null&&allTopCompanies.isNotEmpty?Wrap(
                         runSpacing: 5,
                         children: List.generate(allTopCompanies.length??0, (index){
                           return commonTopCompaniesWidget(context,
                               image: allTopCompanies[index]['profile']??appCompanyImage,
                               location: generateLocation(cityName: allTopCompanies[index]['city_name']??"", stateName: allTopCompanies[index]['state_name']??"", countryName: allTopCompanies[index]['country_name']??""),
                               name: capitalizeFirstLetter(allTopCompanies[index]['industry_name']??""),
                               id: allTopCompanies[index]['individual_id']??"",
                               jobTitle: 'Computer Software/Engineering',
                               onClick: (){},
                               isFollowData: true


                           );
                         }),
                       ):Center(
                         child: Text(noDataAvailable),
                       );
                     })
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

}