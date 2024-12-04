// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/features/AuthScreens/Auth_sharedwidgets/custom_buttonauth.dart';
import 'package:flutter_movie_app_2/features/AuthScreens/Auth_sharedwidgets/custom_textfield.dart';
import 'package:flutter_movie_app_2/features/AuthScreens/Auth_sharedwidgets/login_logo.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/create_account.dart';
import 'package:flutter_movie_app_2/utils/helpers/shared_prefs_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(child: LoginLogo()),
            const SizedBox(height: 20),
            Column(
              children: [
                Text("Register", style: KCustomTextStyle.titleTextStyle()),
                Text(
                  "Create a new account \n",
                  style: KCustomTextStyle.buttonTextStyle(),
                ),
              ],
            ),
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User Name", style: KCustomTextStyle.buttonTextStyle()),
                  CustomTextfield(
                    hint: "user name",
                    myController: name,
                  ),
                  Text(" Mail", style: KCustomTextStyle.buttonTextStyle()),
                  CustomTextfield(
                    hint: "Enter Your Email",
                    myController: mail,
                  ),
                  Text(" Password", style: KCustomTextStyle.buttonTextStyle()),
                  CustomTextfield(
                    hint: "Enter Your Password",
                    myController: password,
                    isHidden: true,
                  ),
                  Text(" Confirm Password",
                      style: KCustomTextStyle.buttonTextStyle()),
                  CustomTextfield(
                    hint: " Enter Your Pass Again",
                    myController: password,
                    isHidden: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonauth(
                    iconPath: "assets/images/login.png",
                    title: "Register ",
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        KCreateAccount.createAccount(context,
                            emailAddress: mail.text.trim(),
                            password: password.text.trim(),
                            userName: name.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
