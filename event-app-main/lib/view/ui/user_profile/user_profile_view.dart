import 'package:event_app/view/ui/user_profile/edit_profile_page.dart';
import 'package:event_app/view/ui/user_profile/user.dart';
import 'package:event_app/view/ui/user_profile/user_profile_model.dart';
import 'package:event_app/view/widgets/appbar_widget.dart';
import 'package:event_app/view/widgets/button_widget.dart';
import 'package:event_app/view/widgets/numbers_widget.dart';
import 'package:event_app/view/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:event_app/view/ui/user_profile/user_profile_model.dart;

class UserProfile extends StatefulWidget {
    @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>{
  @override
  Widget build(BuildContext context){
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ProfileWidget(
              imagePath: user.imagePath,
              isEdit: false,
              onClicked: () async {Get.to(() => EditProfilePage());},
            ),
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height:24),
          Center(child: buildUpgradeButton()),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      )
    );
  }
  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )

    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: "Upgrade to PRO",
    onClicked: () {},
  );

  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text(
          'about',
          style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        )
      ]
    ),
  );
}
