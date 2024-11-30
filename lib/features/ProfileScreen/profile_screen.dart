import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_listtile.dart';
import 'package:flutter_movie_app_2/common/widgets/profile_custom_dialog.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/login_logo.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/sign_out.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? email;
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> initializeUserData() async {
    try {
      isLoading = true;
      setState(() {});

      if (user != null) {
        userName = user!.displayName;
        email = user!.email;
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

  Future<void> updateUserName() async {
    showDialog<String>(
      context: context,
      builder: (context) =>
          ChangeUsernameDialog(currentUserName: userName ?? "User"),
    ).then((newUserName) async {
      if (newUserName != null && newUserName != userName) {
        try {
          // Update the display name in Firebase Authentication
          await user!.updateDisplayName(newUserName);
          debugPrint("Display name updated in Firebase");

          // Reload the user to get the latest data from Firebase
          await user!.reload();
          debugPrint("User reloaded");

          // Fetch the updated user data
          final updatedUser = FirebaseAuth.instance.currentUser;
          if (updatedUser != null) {
            debugPrint("Updated display name: ${updatedUser.displayName}");

            // Update the local state with the new display name
            setState(() {
              userName = updatedUser
                  .displayName; // Sync the display name from Firebase
            });
          } else {
            debugPrint("Failed to fetch updated user.");
          }
        } catch (e) {
          // Handle any error that may occur during the update
          debugPrint("Error updating display name: $e");
          // Optionally, show a custom error dialog to inform the user
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error updating username. Please try again."),
          ));
        }
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
                ontap: ()  {
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
