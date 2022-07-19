import 'package:flutter/material.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/utils/dimensions.dart';
import 'package:time_management_application/widgets/small_text.dart';

class AddDayCount extends StatefulWidget {
  const AddDayCount({Key? key}) : super(key: key);

  @override
  State<AddDayCount> createState() => _AddDayCountState();
}

class _AddDayCountState extends State<AddDayCount> {
  double opacity = 0.0;
  double sliderValue = 0;

  final TextEditingController _dayAddController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 0.8;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.height10 * 10,
          bottom: Dimensions.height10 * 10,
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        child: Card(
          color: Colors.grey.withOpacity(0.8),
          child: Padding(
            padding: EdgeInsets.only(
              left: Dimensions.width10 * 2,
              right: Dimensions.width10 * 2,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SmallTextWidget(text: "Add your target day"),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const SmallTextWidget(
                          text: "Close",
                        ))
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        initialValue: sliderValue.toInt().toString(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: sliderValue.toInt().toString(),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 20,
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                          debugPrint(sliderValue.toInt().toString());
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const SmallTextWidget(
                            text: "Add",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
