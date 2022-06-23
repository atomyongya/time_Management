import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:time_management_application/api/user_authentication.dart';
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
  DateTime? _age;

  final _formKey = GlobalKey<FormState>();
  final List<String> genderList = <String>["Male", "Female"];

  String? _selectedGender;

  Future _registerData() async {
    if (!_formKey.currentState!.validate()) {
      var data = {
        "name": _userNameController.text,
        "gender": _selectedGender.toString(),
        "date_of_birth": _age.toString(),
        "email": _emailController.text,
        "password": _passwordController.text,
        "password_confirmation": _conformController.text,
      };

      Response response = await UserAuthentication().postData(data, "register");

      var body = json.decode(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Registered Successfully");
      } else {
        debugPrint("Not");
      }
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.height10 * 10),
                  // ************* Title ****************** //
                  BigTextWidget(
                    text: "Sign Up",
                    fontSize: Dimensions.height10 * 2.6,
                    textColor: AppColors.mainColor,
                  ),
                  SizedBox(height: Dimensions.height10 * 2),

                  // *********** User name **************** //
                  TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        hintText: "User Name",
                      ),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Please Fill the UserName Field.";
                        }
                        String pattern = r'^(?=.*?[a-z A-Z]).{2,30}$';
                        RegExp regExp = RegExp(pattern);

                        if (!regExp.hasMatch(name)) {
                          return '''Username Length Must Be Greater then 1 and less then 
                          10.''';
                        }
                        return null;
                      }),
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
                          child: DropdownButtonFormField(
                            iconEnabledColor: Colors.white,
                            dropdownColor: AppColors.mainColor,
                            hint: const Padding(
                              padding: EdgeInsets.only(left: 60),
                              child: Text(
                                "Gender",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return "Selecte Gender";
                              }
                              return null;
                            },
                            value: _selectedGender,
                            items: genderList
                                .map(
                                  (gender) => DropdownMenuItem<String>(
                                    value: gender,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Text(
                                        gender,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? gender) {
                              setState(() {
                                _selectedGender = gender;
                              });
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
                          label: Text(_age == null
                              ? "DATE OF BIRTH"
                              : "${_age!.year}-${_age!.month}-${_age!.day}"),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime
                                  .now(), // The initialDate should not be zero.
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((date) {
                              setState(() {
                                _age = date;
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
                      _registerData();
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
