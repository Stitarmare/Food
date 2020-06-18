import 'package:flutter/material.dart';
import 'package:foodzi/Models/CategoryListModel.dart';

abstract class MenuDropdownContractor {
  void getMenuLCategory(int restId, BuildContext context, bool isShowNetwork);
  void onBackPresed();
}

abstract class MenuDropdownModelView {
  void getMenuLCategorysuccess([List<CategoryItems> categoryData]);
  void getMenuLCategoryfailed();
}
