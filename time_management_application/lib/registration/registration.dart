import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:time_management_application/constants/constants_vairables.dart';
import 'package:time_management_application/login/login.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/utils/dimensions.dart';
import 'package:time_management_application/widgets/big_text.dart';

// Creating the stateful widget.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreen();
}

// Creating the object of Registration screen.
class _RegistrationScreen extends State<RegistrationScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformController = TextEditingController();
  bool _isHiddenPassword = true;
  bool? _isChecked = false;
  DateTime? _dateTime;
  final List<String> genderList = <String>["Male", "Female"];

  String? _selectedGender;

  void _registerData(
      String email, String password, String conformPassword) async {
    try {
      Response response =
          await post(Uri.parse("http://10.0.2.2:3000/user"), body: {
        "email": email,
        "password": password,
        "conformPassword": conformPassword,
      });

      // Using ternary operator to declare condition.
      response.statusCode == 200 || response.statusCode == 201
          ? debugPrint("Successfully account created")
          : debugPrint("Somethings wrong");
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // BuildContext keep track of all widget.
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
        ),

        // ********* Body Section *************** //
        body: Container(
          padding: EdgeInsets.only(
            right: Dimensions.paddingAnyLR14,
            left: Dimensions.paddingAnyLR14,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.height10 * 10),
                // ************* Title ****************** //
                Center(
                  child: BigTextWidget(
                    text: "Sign Up",
                    fontSize: Dimensions.height10 * 2.6,
                    textColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 2),

                // *********** User name **************** //
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    hintText: "User Name",
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 2),

                // ********** Gender and Age *********** //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Gender of the user
                    Container(
                      width: Dimensions.width10 * 18,
                      height: Dimensions.height10 * 4.5,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10 - 8),
                      ),
                      child: Center(
                        child: DropdownButton(
                          iconEnabledColor: Colors.white,
                          dropdownColor: AppColors.mainColor,
                          hint: const Text(
                            "Gender",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: _selectedGender,
                          items: genderList
                              .map(
                                (gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? gender) {
                            setState(() => _selectedGender = gender);
                          },
                        ),
                      ),
                    ),
                    // Age of the user
                    Container(
                      height: Dimensions.height10 * 4.5,
                      width: Dimensions.width10 * 18,
                      color: AppColors.mainColor,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor),
                        ),
                        icon: ConstantsVariables.calendarIcon,
                        label: Text(_dateTime == null
                            ? "DATE OF BIRTH"
                            : "${_dateTime!.year}-${_dateTime!.month}-${_dateTime!.day}"),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime
                                .now(), // The initialDate should not be zero.
                            firstDate: DateTime(0),
                            lastDate: DateTime.now(),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // ************* Email Input Field. ********* //
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),

                // ************* Password Input Field. ************* //
                SizedBox(height: Dimensions.height10 * 2),
                TextFormField(
                  obscureText: _isHiddenPassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: const Icon(Icons.visibility),
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height10 * 2),
                TextFormField(
                  obscureText: _isHiddenPassword,
                  controller: _conformController,
                  decoration: InputDecoration(
                    hintText: "Conform Password",
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: const Icon(Icons.visibility),
                    ),
                  ),
                ),
                // ************* Registration Button. ************* //
                SizedBox(height: Dimensions.height10 * 3),
                InkWell(
                  child: Container(
                    height: Dimensions.height10 * 5,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.height5),
                    ),
                    child: const Center(
                      child: BigTextWidget(
                        text: "Register",
                      ),
                    ),
                  ),
                  onTap: () {
                    _registerData(
                      _emailController.text.toString(),
                      _passwordController.text.toString(),
                      _conformController.text.toString(),
                    );
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => const LoginScreen(),
                    //   ),
                    // );
                  },
                ),

                // ************* Already Login ************* //
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    const Text(
                      "Already have an account?    ",
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen(),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // To toggle password view
  void _togglePasswordView() {
    setState(
      () {
        _isHiddenPassword = !_isHiddenPassword;
      },
    );
  }

  // Checked Box
  Widget checkBox() => Container(
        width: Dimensions.width10,
        height: Dimensions.height10,
        margin: EdgeInsets.only(
            left: Dimensions.width5, right: Dimensions.marginAnyLR14),
        child: Checkbox(
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue;
            });
          },
          checkColor: Colors.white,
        ),
      );
}
