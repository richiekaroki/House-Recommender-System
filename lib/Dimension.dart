import 'dart:io';

import 'package:get/get.dart';

double spinManiaDouble = 30;
double fortuneDouble = 10;
double jackpotDouble = 50;
double animatedDouble = 0;
double initialHight = 788.0;
double initialWidth = 360.0;
double initialratio = 2;

class Dimensions {
  static File? finalImage;

  static double myHieght = Get.context!.height;
  static double myWidth = Get.context!.width;
  static double screenHieght = Get.context!.height;
  static double textaspect = Get.context!.textScaleFactor;
  static bool ifpotrait = Get.context!.isPortrait;
  static double ratio = Get.context!.devicePixelRatio;
  static double standardratio = Get.context!.textScaleFactor;

  static double screenWidth = Get.context!.width;
  static double standardHieght = (screenHieght / initialHight);
  static double standardWidth = (screenWidth / initialWidth);
  static double sth = 0;
  static double stw = 0;
  static double str = 0;
}
