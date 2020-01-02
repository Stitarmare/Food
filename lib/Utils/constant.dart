

import 'package:flutter/material.dart';
import 'dart:io' as io;

class Constants {
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static isAndroid() {
    return io.Platform.isAndroid;
  }

  static isIOS() {
    return io.Platform.isIOS;
  }

}