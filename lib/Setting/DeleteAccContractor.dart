import 'package:flutter/material.dart';

abstract class DeleteAccContractor{
  void deleteAccRequest(BuildContext context);
}

abstract class DeleteAccModelView{
  void deleteAccSuccess();
  void deleteAccFailed();
}