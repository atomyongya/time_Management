import "package:get/get.dart";

class Dimensions {
  // Height and Width of any Mobile device.
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // important Dimensions.
  static double paddingAnyLR14 = screenWidth / (screenWidth / 14);

  static double marginAnyLR14 = screenWidth / (screenWidth / 14);

  // Height
  static double height5 = screenHeight / (screenHeight / 5);
  static double height10 = screenHeight / (screenHeight / 10);

  // Width
  static double width5 = screenWidth / (screenWidth / 5);
  static double width10 = screenWidth / (screenWidth / 10);

  // *************** Home page***************** //
  static double headerHeight = screenHeight / (screenHeight / 64);

  // Size of icon.
  static double iconSize = screenHeight / (screenHeight / 25);
  // static double iconSize

  // Size of icon box.
  static double iconBoxSize = screenHeight / (screenHeight / 45);

  // Height and Width of Feature.
  static double featureBoxHeight200 = screenHeight / (screenHeight / 200);
  static double featureBoxWidth200 = screenWidth / (screenWidth / 200);

  // Small Text Size.
  static double smallTextSize = screenHeight / (screenHeight / 16);

  // Height and Width of Selected Card.
  static double selectedCardHeight = screenHeight / (screenHeight / 200);
  static double selectedCardWidth = screenWidth / (screenWidth / 250);
}
