// Importing flutter package.
import "package:flutter/material.dart";
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

  void _validatingUser(String email, String password) async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        Response response =
            await post(Uri.parse("http://10.0.2.2:3000/user"), body: {
          "email": email,
          "password": password,
        });

        // Using ternary operator to define condition.
        response.statusCode == 200
            ? debugPrint("Login Successfull")
            : debugPrint("Something wrong");
      } catch (error) {
        debugPrint("Something is wrong.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // BuildContext keep track of all widget.
    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
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
                  // ************* Email Input Field. ********* //
                  TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
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
                      obscureText: _isHiddenPassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(_isHiddenPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
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
                          const Text("Remember me"),
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
                      _validatingUser(
                        _emailController.text.toString(),
                        _passwordController.text.toString(),
                      );
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => const HomeScreen(),
                      //   ),
                      // );
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
                        style: TextStyle(color: Colors.black),
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
