import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_listtile.dart';
import 'package:flutter_movie_app_2/common/widgets/profile_custom_dialog.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/login_logo.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/sign_out.dart';
import 'package:flutter_movie_app_2/utils/helpers/shared_prefs_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? email;
  bool isLoading = false;

  Future<void> initializeUserData() async {
    try {
      isLoading = true;
      setState(() {});
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userName = await KSharedPrefsHelper.getString("userName") ?? "User";
        email = user.email ?? "No email available";
      } else {
        userName = "User";
        email = "No email available";
      }
    } catch (e) {
      // Handle potential exceptions during data fetch
      debugPrint("Error fetching user data: $e");
      userName = "User";
      email = "No email available";
    }

    if (mounted) {
      isLoading = false;
      setState(() {});
    }
  }

  void updateUserName() {
    showDialog<String>(
      context: context,
      builder: (context) =>
          ChangeUsernameDialog(currentUserName: userName ?? "User"),
    ).then((newUserName) {
      if (newUserName != null && newUserName != userName) {
        setState(() {
          userName = newUserName;
        });
        KSharedPrefsHelper.saveString("userName", newUserName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        const SizedBox(height: 30),
        Column(
          children: [
            Text("My Profile", style: KCustomTextStyle.sectionsTextStyle()),
            const SizedBox(height: 20),
            const LoginLogo(),
            Text(
              userName ?? "user",
              style: KCustomTextStyle.sectionsTextStyle(),
            ),
            Text(email!, style: KCustomTextStyle.subTitleTextStyle()),
            KCustomListTile.customListTile(
                title: "My Profile",
                icon: Icons.person,
                isSeleted: true,
                ontap: () async {
                  updateUserName();
                }),
            KCustomListTile.customListTile(
                title: "Notifications", icon: Icons.notifications_none_rounded),
            KCustomListTile.customListTile(
                title: "History", icon: Icons.history),
            KCustomListTile.customListTile(
                title: "Subscription", icon: Icons.subscriptions_rounded),
            KCustomListTile.customListTile(
                title: "Settings", icon: Icons.settings),
            KCustomListTile.customListTile(
                title: "Log Out",
                icon: Icons.logout_rounded,
                ontap: () {
                  KSignOut.logOut(context);
                }),
          ],
        ),
      ],
    );
  }
}
