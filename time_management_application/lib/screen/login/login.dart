import 'dart:developer';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_application/api/user_authentication.dart';
import 'package:time_management_application/screen/dashboard/home.dart';
import 'package:time_management_application/screen/registration/registration.dart';
import 'package:time_management_application/utils/colors.dart';
import 'package:time_management_application/utils/dimensions.dart';
import 'package:time_management_application/widgets/big_text.dart';
import "package:http/http.dart";

// Creating LoginScreen class.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? atom}) : super(key: atom);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

// Creating an object of LoginScreen Class.
class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHiddenPassword = true;
  bool? _isChecked = false;
  final _loginFormKey = GlobalKey<FormState>();

  _validatingUser() async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        var data = {
          "email": _emailController.text,
          "password": _passwordController.text,
        };

        Response response = await UserAuthentication().postData(data, "login");

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (_isChecked == true) {
            final preference = await SharedPreferences.getInstance();
            preference.setString("email", _emailController.text);
          }
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          if (!mounted) return;
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bad Crenditial")),
          );
        }
      } catch (error) {
        debugPrint("Something is wrong.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // BuildContext keep track of all widget.
    return Center(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text("Time Management"),
          ),
        ),

        // ********* Body Section *************** //
        body: Padding(
          padding: EdgeInsets.only(
            right: Dimensions.paddingAnyLR14,
            left: Dimensions.paddingAnyLR14,
            bottom: Dimensions.height10 * 4,
          ),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: BigTextWidget(
                    text: "Login",
                    fontSize: 30,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // ************* Email Input Field. ********* //
                SizedBox(height: Dimensions.height10),
                TextFormField(
                    enableSuggestions: true,
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (email) {
                      if (email!.isEmpty) return "Email Required Field";

                      String pattern = r'\w+@\w+\.\w+';

                      RegExp regExp = RegExp(pattern);

                      if (!regExp.hasMatch(email)) {
                        return '''Provide valid email''';
                      }
                      return null;
                    }),

                // ************* Password Input Field. ************* //
                SizedBox(height: Dimensions.height10 * 2),
                TextFormField(
                    enableInteractiveSelection: false,
                    restorationId: _passwordController.text,
                    obscureText: _isHiddenPassword,
                    style: const TextStyle(color: Colors.white),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHiddenPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) return "Password Field Required";
                      return null;
                    }),

                // ************ Remember Me and Forget password ************ //
                SizedBox(height: Dimensions.height10 * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ************* Remember Me ************* //
                    Row(
                      children: [
                        checkBox(),
                        const Text("Remember me",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    // ************* Forget Password ************* //
                    InkWell(
                      child: const Text(
                        "Forget Your password?    ",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),

                // ************* Login Button. ************* //
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
                        text: "Login",
                      ),
                    ),
                  ),
                  onTap: () {
                    _validatingUser();
                  },
                ),

                // ************* No Register ************* //
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?    ",
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RegistrationScreen(),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Register",
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
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  // Checked Box
  Widget checkBox() => Container(
        width: Dimensions.width10,
        height: Dimensions.height10,
        margin: EdgeInsets.only(
            left: Dimensions.width5, right: Dimensions.marginAnyLR14),
        child: Checkbox(
          side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(width: 2, color: Colors.white),
          ),
          value: _isChecked,
          onChanged: (newValue) {
            log(newValue.toString());
            setState(() {
              _isChecked = newValue;
            });
          },
          checkColor: Colors.white,
        ),
      );
}
