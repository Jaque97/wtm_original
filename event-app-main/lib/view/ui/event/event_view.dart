import 'package:event_app/app/constants.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/view/widgets/event_tab_bar.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:event_app/view/widgets/no_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';
import 'package:event_app/view/ui/user_joined/user_joined_view.dart';
import 'package:event_app/view/ui/user_home/user_home_view.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:event_app/view/ui/user_home/user_home_viewmodel.dart';
import 'package:event_app/view/ui/party_creation/partycreation.dart';



import 'event_viewmodel.dart';

class EventView extends StatefulWidget {
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => locator<EventViewModel>(),
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
        backgroundColor: Colors.black,
        body: model.loading
            ? Center(child: CircularProgressIndicator())
            : ModalProgressHUD(
                inAsyncCall: model.isProcessing,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        InputFieldWidget(
                          controller: searchCon,
                          prefixIcon: Icons.search,
                          hint: "Search Events",
                          onChange: model.onFilter,
                        ),
                        Container(
                          child: Align(alignment: Alignment.topLeft,
                              child: Image.asset('assets/logo.png')
                          ),
                          height: 150,
                          width: 420,
                          color: Colors.black,
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
                        Container(
                          height: 100,
                          color: Colors.red,
                        ),
                        if (StaticInfo.userModel.userType == "admin")
                          EventTabBar(model),
                        SizedBox(
                          height: 10,
                        ),
                        IndexedStack(
                          index: model.currentIndex,
                          children: [
                            model.upcomingFiltered.length == 0
                                ? NoEventWidget(false)
                                : ListView.builder(
                                    itemCount: model.upcomingFiltered.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return EventTile(
                                        eventModel:
                                            model.upcomingFiltered[index],
                                        onDelete: () {
                                          model.deleteEvent(
                                              model.upcomingFiltered[index]);
                                        },
                                      );
                                    },
                                  ),
                            model.completedFiltered.length == 0
                                ? NoEventWidget(true)
                                : ListView.builder(
                                    itemCount: model.completedFiltered.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return EventTile(
                                          eventModel:
                                              model.completedFiltered[index]);
                                    },
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
