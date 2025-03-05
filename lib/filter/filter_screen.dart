import 'package:collarchek/filter/filter_controller.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import 'common_widget.dart';

class FilterPage extends GetView<FilterController>{
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appPrimaryBackgroundColor,
        body: Column(
          children: <Widget>[
            commonActiveSearchBar(
                onClick: (){
                  controller.clickFilterClose();
                },
                onShareClick: (){},
                onFilterClick: (){},
                leadingIcon: appFilterCloseIcon,
                screenName: appAllFilters,
                actionButton: ''),


              Container(
                color: appWhiteColor,
                padding:EdgeInsets.zero,
                child: TabBar(
                  indicatorPadding: EdgeInsets.zero,
                  isScrollable: false,
                  dividerColor: appWhiteColor,
                  indicatorColor: appPrimaryColor,
                  indicatorWeight: 2,
                 // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: controller.tabController,
                  tabs: List.generate(controller.listTabLabel.length, (index){
                    return Text(controller.listTabLabel[index],style: AppTextStyles.font14.copyWith(color: appBlackColor),);
                  }),
                ),
              ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                color: appPrimaryBackgroundColor,
                height: MediaQuery.of(context).size.height ,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: <Widget>[
                    ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 0);
                        },
                        shrinkWrap: true,
                        itemCount: controller.filterTypeLabel.length,
                        itemBuilder: (BuildContext context, int index) {
                          String filterType = controller.filterTypeLabel[index];

                          return commonFilterWidgetForSelectCompany(
                            context,
                            filterTypeLabel: filterType,
                            controller: controller.searchController,
                            searchItemData: controller.selectCompanyListOption,
                            isCheckedCheckboxValue: controller.isSelectedFilterOption[filterType]!, // ✅ Correct way
                            onVoidCallBack: (itemIndex, value) {
                              controller.isSelectedFilterOption[filterType]![itemIndex] = value; // ✅ Update state
                              print("Filter: $filterType, Index: $itemIndex, Selected: $value");
                            },
                          );
                        }
                    ),


                    Text("Tran"),
                    Text("cy"),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            //   height: MediaQuery.of(context).size.height,
            //   child: TabBarView(
            //     controller: controller.tabController,
            //     children: <Widget>[
            //       commonFilterWidgetForSelectCompany(
            //         context,
            //         filterTypeLabel: 'Select Company',
            //         controller: controller.searchController,
            //         searchItemData: controller.selectCompanyListOption,
            //         isCheckedCheckboxValue: controller.isSelectedFilterOption, // ✅ Pass reactive list
            //         onVoidCallBack: (index, value) {
            //           print("Index: $index, Selected: $value");
            //         },
            //       ),
            //       Text("Tran"),
            //       Text("cy"),
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
    );
  }

}