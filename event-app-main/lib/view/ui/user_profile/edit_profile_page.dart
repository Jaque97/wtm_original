import 'package:event_app/view/ui/user_profile/user.dart';
import 'package:event_app/view/ui/user_profile/user_profile_model.dart';
import 'package:event_app/view/widgets/appbar_widget.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:event_app/view/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget{
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>{
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: ProfileWidget(
          imagePath: user.imagePath,
          isEdit: true,
          onClicked: () async {},
          ),
        ),
        const SizedBox(height: 24),
        InputFieldWidget(
          hint: 'full name'
        )
      ],
    ),
  );
}