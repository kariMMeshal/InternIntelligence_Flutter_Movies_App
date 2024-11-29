import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(70),
      ),
      alignment: Alignment.center,
      width: 100,
      height: 100,
      child: Image.asset("assets/images/login.png"),
    );
  }
}
