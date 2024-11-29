import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_buttonauth.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_dialog.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_textfield.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController mail = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formState,
          child: Column(
            children: [
              const Text(
                "Email :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              CustomTextfield(
                hint: "Enter Your Email ",
                myController: mail,
              ),
              CustomButtonauth(
                title: "Send",
                iconPath: "assets/images/login.png",
                onPressed: () async {
                  try {
                    if (formState.currentState!.validate()) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: mail.text);
                      KCustomDialog(
                        context: context,
                        message: "An password reset mail has been sent",
                        title: "Reset Password",
                        dialogType: DialogType.success,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                      ).customDialog();
                    }
                  } catch (e) {
                    mail.text = "";
                    KCustomDialog(
                      context: context,
                      message: "There is no such user !",
                      title: "Email not found",
                      dialogType: DialogType.error,
                    ).customDialog();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
