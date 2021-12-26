import 'package:event_app/view/ui/calender/calander_view.dart';
import 'package:event_app/view/ui/event/event_view.dart';
import 'package:event_app/view/ui/user_home/user_home_viewmodel.dart';
import 'package:event_app/view/ui/user_joined/user_joined_view.dart';
import 'package:event_app/view/ui/user_profile/user_profile_model.dart';
import 'package:event_app/view/ui/user_profile/user_profile_view.dart';
import 'package:event_app/view/widgets/bottom_nav_bar.dart';
import 'package:event_app/view/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:event_app/view/ui/event/event_viewmodel.dart';
import 'package:event_app/view/ui/party_creation/partycreationmodel.dart';
import 'package:event_app/view/ui/user_home/user_home_view.dart';

class PartyCreation extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final user = UserPreferences.myUser;
    return ViewModelBuilder<PartyCreationModel>.reactive(
      viewModelBuilder: () => PartyCreationModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,

            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                  onTap: () {
                    model.logout();
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(Icons.logout))),
            ],
          ),
          body:
          ListView(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: InputFieldWidget(
                  //controller: searchCon,
                  prefixIcon: Icons.search,
                  hint: "Search Events",
                  //onChange: model.onFilter,
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Align(alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap:() {
                              Get.to(() => UserHomeView());
                            },
                            child: Image.asset('assets/logo.png'))
                    ),
                    height: 150,
                    width: 200,
                    color: Colors.black,
                  ),
                  Container(
                    color: Colors.black,
                    height: 150,
                    width: 192.7,
                    child: Center(
                      child: ProfileWidget(
                          imagePath: user.imagePath,
                          isEdit: false,
                          onClicked: () async {Get.to(() => UserProfile());}
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => UserHomeView());
                        },
                        child: Text('Home'),
                        //textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => EventView());
                        },

                        child: Text('Upcoming Events'),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => PartyCreation());},
                        child: Text('Creating a Party'),
                      ),
                    ),
                    Expanded(
                      flex:10,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {},
                        child: Text('DJ/Promoter'),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  height: 100,
                  width: 415,
                  child: Center(child: Text('Creating A Party')),
                ),
              ),
              InputFieldWidget(
                hint: 'Event Name',
              ),
              InputFieldWidget(
                hint: 'Event Location',
              ),
            ],
          ),
      )
    );
  }
}