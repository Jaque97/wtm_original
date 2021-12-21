import 'package:event_app/view/ui/calender/calander_view.dart';
import 'package:event_app/view/ui/event/event_view.dart';
import 'package:event_app/view/ui/user_home/user_home_viewmodel.dart';
import 'package:event_app/view/ui/user_joined/user_joined_view.dart';
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
import 'package:event_app/view/ui/party_creation/partycreation.dart';
import 'package:event_app/view/ui/user_profile/user_profile_view.dart';
import 'package:event_app/view/ui/user_profile/user.dart';
import 'package:event_app/view/ui/user_profile/user_profile_model.dart';

class UserHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return ViewModelBuilder<UserHomeViewModel>.reactive(
        viewModelBuilder: () => UserHomeViewModel(),
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
                          child: Align(alignment: Alignment.centerLeft,
                              child: Image.asset('assets/logo.png')

                          ),
                          height: 150,
                          width: 200,
                          color: Colors.black,
                        ),
                        Container(
                          child: Center(
                            child: ProfileWidget(
                              imagePath: user.imagePath,
                              isEdit: false,
                              onClicked: () async {Get.to(() => UserProfile());}
                            ),
                          ),
                          height: 150,
                          width: 192.6,
                          color: Colors.black,
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
                              onPressed: () {
                                Get.to(() => UserProfile());
                              },
                              child: Text('DJ/Promoter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Align(alignment: Alignment.topLeft,
                          child: Image.asset('assets/SampleImage.png')
                      ),
                      height: 150,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      child: Align(alignment: Alignment.topLeft,
                          child: Image.asset('assets/SampleImage.png')
                      ),
                      height: 150,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      child: Align(alignment: Alignment.topLeft,
                          child: Image.asset('assets/SampleImage.png')
                      ),
                      height: 150,
                      width: 200,
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Align(alignment: Alignment.topLeft,
                              child: Image.asset('assets/SampleImage.png'),
                          ),
                          height: 150,
                          width: 200,
                          color: Colors.black,
                        ),
                        Column( //position date and price
                          children: [
                            Container(
                              child: Text('Date'),
                            ),
                            Container(
                              child: Text('Event name and Price'),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Purchase Tickets'),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                      ),
                      height: 150,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container( // Make this google maps widget
                      color: Colors.red,
                      height: 300,
                      width: 150,
                    )

                  ],

                ),
              ),
      //     IndexedStack(
       //       index: model.currentIndex,
       //       children: [EventView(), CalenderView()],
       //     ),
       //     floatingActionButton: FloatingActionButton(
       //       onPressed: () {
       //         Get.to(() => UserJoinedView());
       //       },
       //       backgroundColor: Theme.of(context).primaryColor,
       //       elevation: 0.0,
       //       child: Icon(
       //         Icons.event_available,
       //         size: 32,
       //       ),
       //     ),
       //     floatingActionButtonLocation:
       //         FloatingActionButtonLocation.centerDocked,
       //     extendBody: true,
       //     resizeToAvoidBottomInset: false,
       //     bottomNavigationBar: BottomNavBar(
       //       selectedIndex: model.currentIndex,
       //       onIndexChange: (index) {
       //         model.setIndex(index);
       //     },
       //     ),
       //   ))//   ;
 );}
}
