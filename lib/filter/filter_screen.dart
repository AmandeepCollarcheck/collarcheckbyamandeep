import 'package:collarchek/filter/filter_controller.dart';
import 'package:collarchek/models/filter_data_list_model.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/progress.dart';
import 'common_widget.dart';

class FilterPage extends GetView<FilterController>{
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
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
                  leadingIcon: appFilterCloseIconSvg,
                  screenName: appAllFilters,
                  actionButton: ''),


              Obx((){
                return Container(
                  color: appWhiteColor,
                  padding:EdgeInsets.zero,
                  child: TabBar(
                    indicatorPadding: EdgeInsets.zero,
                    isScrollable: true,
                    dividerColor: appWhiteColor,
                    indicatorColor: appPrimaryColor,
                    indicatorWeight: 2,

                    // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: controller.tabController,
                    tabs: List.generate(controller.listTabLabel.length??0, (index){
                      return Text(controller.listTabLabel[index],style: AppTextStyles.font14.copyWith(color: appBlackColor),);
                    }),
                  ),
                );
              }),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  color: appPrimaryBackgroundColor,
                  // height: MediaQuery.of(context).size.height ,
                  child: controller.listTabLabel.isNotEmpty?Obx((){
                    print("askjldsjdfhskfhksfshdfhshdfsdfjks");
                    print(controller.selectedTabIndex.value);
                    return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller.tabController,
                        children: List.generate(controller.listTabLabel.length, (index){
                          String filterType = controller.filterTypeLabel[index]??"";
                          return commonFilterWidgetForSelectCompany(
                            context,
                            filterTypeLabel: filterType??"",
                            controller: controller.searchController,
                            searchItemData: controller.filterDataListModel.value.data,
                            isCheckedCheckboxValue: controller.isSelectedFilterOption[filterType] ?? RxList<bool>(),
                            //isCheckedCheckboxValue: controller.isSelectedFilterOption[filterType]?? <bool>[].obs, // ✅ Correct way
                            onVoidCallBack: (itemIndex, value, selectedItemId) {
                              controller.isSelectedFilterOption[filterType]![itemIndex] = value; // ✅ Update state
                              controller.selectedFilterType.value = controller.selectedFilterType.value.toSet().toList();
                              if (!controller.selectedFilterType.value.contains(filterType.split(" ")[1])) {
                                controller.selectedFilterType.value.add(filterType.split(" ")[1]);
                              }

                              controller.selectedFilterTypeItemId.update(
                                filterType.split(" ")[1],
                                    (list) => list..add(selectedItemId.toString()),  // Update existing list
                                ifAbsent: () => [selectedItemId],     // Create new list if category doesn't exist
                              );
                            },
                            filterTypeLabelList: controller.filterTypeLabel??[],
                            selectedTabIndex: RxInt(controller.selectedTabIndex.value??0),
                          );
                        })
                    );
                  }):SizedBox(
                    height: MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Text(appNoDataFound,style: AppTextStyles.font12.copyWith(color: appBlackColor),),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: commonButton(
                        context,
                        isPaddingDisabled: true,
                        buttonName: appReset, buttonBackgroundColor: appWhiteColor, textColor: appPrimaryColor, buttonBorderColor: appPrimaryColor, onClick: (){
                      // Reset selected filters
                      controller.selectedFilterType.value = [];
                      controller.selectedFilterTypeItemId.clear();

                      // Optionally call apply again with cleared values
                      // controller.getApplyFilterData(
                      //   context,
                      //   filterType: [],
                      //   filterTypeId: {},
                      // );
                    }),
                  ),
                  SizedBox(width: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: commonButton(
                        context,
                        isPaddingDisabled: true,
                        buttonName: appApply, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor, buttonBorderColor: appPrimaryColor, onClick: (){
                      controller.getApplyFilterData(
                        context,
                        filterType: controller.selectedFilterType.value.cast<String>(),
                        filterTypeId: Map<String, List<String>>.from(controller.selectedFilterTypeItemId), // Convert RxMap to Map
                      );

                    }),
                  )
                ],
              ),
              SizedBox(height: 20,),
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
      ),
    );
  }

}