import "package:flutter/material.dart";
import 'package:http/http.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformController = TextEditingController();
  bool _isHiddenPassword = true;
  bool? _isChecked = false;

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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            centerTitle: mounted,
            title: const Center(
              child: Text("Register New Account"),
            ),
          ),

          // ********* Body Section *************** //
          body: Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingAnyLR14,
              left: Dimensions.paddingAnyLR14,
              bottom: Dimensions.height10 * 4,
            ),
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
