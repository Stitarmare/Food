import 'package:flutter/material.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class MenuDropdownContractor {
  void getMenuLCategory(int restId, BuildContext context);
  void onBackPresed();
}

abstract class MenuDropdownModelView {
  void getMenuLCategorysuccess([List<CategoryItems> categoryData]);
  void getMenuLCategoryfailed();
}