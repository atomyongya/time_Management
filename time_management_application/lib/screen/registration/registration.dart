import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:time_management_application/api/user_authentication.dart';
import 'package:time_management_application/constants/constants_vairables.dart';
import 'package:time_management_application/screen/login/login.dart';
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
  bool _isHiddenConformPassword = true;

  bool? _isChecked = false;
  DateTime? _age;

  final _formKey = GlobalKey<FormState>();
  final List<String> genderList = <String>["Male", "Female"];

  String? _selectedGender;

  _registerData() async {
    if (_formKey.currentState!.validate()) {
      try {
        var data = {
          "name": _userNameController.text,
          "gender": _selectedGender.toString(),
          "date_of_birth": _age.toString(),
          "email": _emailController.text,
          "password": _passwordController.text,
          "password_confirmation": _conformController.text,
        };

        Response response =
            await UserAuthentication().postData(data, "register");
        json.decode(response.body.toString());
        return response;
      } catch (error) {
        debugPrint("Error in _registerData() is \n $error");
      }
    } else {
      debugPrint("Bad Cradentials");
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
                      validator: (email) {
                        if (email!.isEmpty) return "Email Field is required";

                        String pattern = r'\w+@\w+\.\w+';

                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(email)) {
                          return '''Please provide validate email id.''';
                        }
                        return null;
                      }),

                  // ************* Password Input Field. ************* //
                  SizedBox(height: Dimensions.height10 * 2),
                  TextFormField(
                      obscureText: _isHiddenPassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (password) {
                        if (password!.isEmpty) return "Required Field";

                        String pattern =
                            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*]).{8,}$';

                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(password)) {
                          return '''Password length must be greater or equal to 8
                          and contain Capital and Small and Special Character ''';
                        }

                        if (_passwordController.text !=
                            _conformController.text) {
                          return "Password doesn't match. ";
                        }
                        return null;
                      }),

                  SizedBox(height: Dimensions.height10 * 2),
                  TextFormField(
                      obscureText: _isHiddenConformPassword,
                      controller: _conformController,
                      decoration: InputDecoration(
                        hintText: "Conform Password",
                        suffixIcon: InkWell(
                          onTap: _togglePasswordConformView,
                          child: Icon(
                            _isHiddenConformPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (conformPassword) {
                        if (conformPassword!.isEmpty) return "Required Field";

                        String pattern =
                            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*]).{8,}$';

                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(conformPassword)) {
                          return '''Password length must be greater or equal to 8
                          and contain Capital and Small and Special Character ''';
                        }

                        if (_passwordController.text !=
                            _conformController.text) {
                          return "Password doesn't match";
                        }
                        return null;
                      }),

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
                    onTap: () async {
                      Response response = await _registerData();
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        debugPrint("Response is : $response");
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/otp", (route) => false);
                      } else {
                        debugPrint("Bad Response.");
                      }
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

  void _togglePasswordConformView() {
    setState(
      () {
        _isHiddenConformPassword = !_isHiddenConformPassword;
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
