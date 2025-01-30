import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise/utils/appconstants.dart';

class MySnackbar {
  static snackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Appcolor.appprimaryColor,
      colorText: Colors.white,
    );
  }
}
