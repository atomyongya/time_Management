// import "package:flutter/material.dart";
// import 'package:time_management_application/utils/colors.dart';
// import 'package:time_management_application/utils/dimensions.dart';
// import 'package:time_management_application/widgets/customize_icon.dart';
// import 'package:time_management_application/widgets/small_text.dart';

// class CardToLinkScreen extends StatelessWidget {
//   final List<IconData> featureIcon;
//   final List<String> featureName;

//   const CardToLinkScreen({
//     Key? key,
//     required this.featureIcon,
//     required this.featureName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         child: Column(
//           children: [
//             Container(
//               // height: Dimensions.selectedCardHeight,
//               width: Dimensions.selectedCardWidth,
//               color: AppColors.mainColor,

//               // Creating Card for each feature.
//               child: AppIconWidget(icon: featureIcon.forEach((element) {element})),
//             ),
//             Container(
//               // height: Dimensions.selectedCardHeight,
//               width: Dimensions.selectedCardWidth,
//               color: AppColors.mainColor,
//               child: SmallTextWidget(text: featureName.forEach((element) {element})),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
