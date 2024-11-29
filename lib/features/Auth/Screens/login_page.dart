import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_buttonauth.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_dialog.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_textfield.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/login_logo.dart';
import 'package:flutter_movie_app_2/features/Auth/Screens/register_page.dart';
import 'package:flutter_movie_app_2/features/Auth/Screens/reset_pass.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/google_login.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/user_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CheckState.getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: LoginLogo(),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "Login",
                        style: KCustomTextStyle.titleTextStyle(),
                      ),
                      Text(
                        "Login to continue using app\n",
                        style: KCustomTextStyle.buttonTextStyle(),
                      ),
                    ],
                  ),
                  Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Email",
                          style: KCustomTextStyle.sectionsTextStyle(),
                        ),
                        CustomTextfield(
                          hint: "Enter Your Mail",
                          myController: email,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          " Password",
                          style: KCustomTextStyle.sectionsTextStyle(),
                        ),
                        CustomTextfield(
                          isHidden: true,
                          hint: "Enter Your Pass",
                          myController: password,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPass(),
                                ));
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 220, bottom: 20),
                            child: const Text(
                              "Forgot Password ? ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        CustomButtonauth(
                          iconPath: "assets/images/login.png",
                          title: "Login",
                          onPressed: () async {
                            _isLoading = true;
                            setState(() {});
                            if (formState.currentState!.validate()) {
                              KUserSignIn.signIn(
                                context,
                                emailAddress: email.text.trim(),
                                password: password.text.trim(),
                              );
                              _isLoading = false;
                              setState(() {});
                            } else {
                              _isLoading = false;
                              setState(() {});
                              KCustomDialog(
                                context: context,
                                message: "Please check your email",
                                title: "Not Valid",
                                dialogType: DialogType.error,
                              ).customDialog();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtonauth(
                          iconPath: "assets/images/google.png",
                          title: "Login With Google ",
                          onPressed: () {
                            GoogleLogin.signInWithGoogle(context);
                          },
                          myColor: KColors.buttonPrimary,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child:  Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't Have an account ? ",
                            style: KCustomTextStyle.buttonTextStyle(),
                          ),
                          const TextSpan(
                            text: "Register",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
