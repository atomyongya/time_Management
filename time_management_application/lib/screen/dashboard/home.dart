import 'dart:developer';

import "package:flutter/material.dart";
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/utils/dimensions.dart';
import 'package:time_management_application/widgets/big_text.dart';
import 'package:time_management_application/widgets/customize_icon.dart';
import 'package:time_management_application/widgets/small_text.dart';

// Creating class Home.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

// Creating private class _HomeScreen which extends HomeScreen class.
class _HomeScreen extends State<HomeScreen> {
  // To open and close menu.
  bool menuIconTap = false;
  bool selectedFeature = false;
  PageController pagecontroller = PageController(viewportFraction: 0.35);

  // List of feature
  final List<IconData> featureIcons = [
    Icons.notifications_active_outlined,
    Icons.note_alt_outlined,
    Icons.watch_later_outlined,
    Icons.calendar_month_outlined,
  ];

  final List<String> featureName = [
    "Notify",
    "Note",
    "Time Table",
    "Day Count"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar.
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: Dimensions.headerHeight,
                padding: EdgeInsets.only(
                    right: Dimensions.paddingAnyLR14,
                    left: Dimensions.paddingAnyLR14),
                child: Row(
                  children: [
                    BigTextWidget(
                      text: "Atom",
                      fontSize: Dimensions.smallTextSize,
                    ),
                    AppIconWidget(
                      icon: Icons.account_circle,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.backgroundColor,
                      iconSize: Dimensions.iconSize,
                      size: Dimensions.iconBoxSize,
                    )
                  ],
                ),
              ),
            ),

            // Body Section.
            // Selected Feature.
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.height10,
                left: Dimensions.width5,
                right: Dimensions.width5,
              ),
              height: Dimensions.featureBoxHeight200,
              width: double.infinity,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "Manage \n\t\t\tYour Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Image.asset(
                      "assets/images/manage.png",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),

            // Feature Option.
            Expanded(
              child: PageView.builder(
                controller: pagecontroller,
                itemCount: featureIcons.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height5,
                    ),
                    child: InkWell(
                      child: Stack(
                        children: [
                          // For Icon
                          Align(
                            alignment: Alignment.topCenter,
                            child: AppIconWidget(
                              iconColor: Colors.white,
                              icon: featureIcons[index],
                              iconSize: 46,
                              size: 80,
                              backgroundColor: AppColors.backgroundColor,
                            ),
                          ),

                          // For Text
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.only(
                                bottom: Dimensions.height5,
                              ),
                              height: Dimensions.height10 * 3,
                              child: Center(
                                child: SmallTextWidget(
                                  text: featureName[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(context, "/notify");
                        } else if (index == 1) {
                          Navigator.pushNamed(context, "/note");
                        } else if (index == 2) {
                          Navigator.pushNamed(context, "/timetable");
                        } else if (index == 3) {
                          Navigator.pushNamed(context, "/daycount");
                        } else {
                          debugPrint("Screen doesn't exist.");
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                height: Dimensions.featureBoxHeight200 * 1.4,
                margin: EdgeInsets.only(
                    left: Dimensions.marginAnyLR14,
                    right: Dimensions.marginAnyLR14),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) => {
              log(value.toString()),
              if (value == 2)
                {
                  Navigator.pushNamed(context, "/settings"),
                }
            }),
        backgroundColor: AppColors.backgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  featureScreen(String link) {
    return Navigator.pushNamed(context, link);
  }
}
