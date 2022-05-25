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
            Container(
              height: Dimensions.headerHeight,
              color: AppColors.mainColor,
              padding: EdgeInsets.only(
                  right: Dimensions.paddingAnyLR14,
                  left: Dimensions.paddingAnyLR14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menu Icon.
                  InkWell(
                      child: AppIconWidget(
                        icon: Icons.menu,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize,
                        size: Dimensions.iconBoxSize,
                      ),
                      onTap: () {
                        menuIconTap = !menuIconTap;
                        setState(() => menuIconTap
                            ? debugPrint("Open")
                            : debugPrint("Close"));
                      }),

                  // For right side of top bar.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigTextWidget(
                        text: "Atom",
                        fontSize: Dimensions.smallTextSize,
                      ),
                      AppIconWidget(
                        icon: Icons.account_circle,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize,
                        size: Dimensions.iconBoxSize,
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Body Section.
            // Selected Feature.
            Container(
              margin: EdgeInsets.only(top: Dimensions.height10 * 2),
              height: Dimensions.featureBoxHeight200,
              width: Dimensions.featureBoxWidth200,
              color: AppColors.mainColor,
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
                            child: Container(
                              margin: EdgeInsets.only(
                                right: Dimensions.width10,
                                left: Dimensions.width10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: AppIconWidget(
                                iconColor: Colors.white,
                                icon: featureIcons[index],
                                iconSize: 46,
                                size: 100,
                                backgroundColor: Colors.pink,
                              ),
                            ),
                          ),

                          // For Text
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 100,
                              color: Colors.grey,
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
                        selectedFeature = !selectedFeature;
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),

               SingleChildScrollView(
                child: Container(
                  height: Dimensions.featureBoxHeight200 * 1.4,
                  color: Colors.red,
                  margin: EdgeInsets.only(
                      left: Dimensions.marginAnyLR14,
                      right: Dimensions.marginAnyLR14),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
