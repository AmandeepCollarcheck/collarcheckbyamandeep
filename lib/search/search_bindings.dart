import 'package:collarchek/search/search_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SearchControllers());
  }
  
}