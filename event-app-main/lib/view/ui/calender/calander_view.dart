import 'package:event_app/app/constants.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/view/ui/calender/calender_viewmodel.dart';
import 'package:event_app/view/widgets/calender_widget.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';
import 'package:event_app/view/ui/user_home/user_home_view.dart';
import 'package:event_app/view/ui/event/event_view.dart';

class CalenderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalenderViewModel>.reactive(
      viewModelBuilder: () => locator<CalenderViewModel>(),
      builder: (context, model, child) => Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  child: Align(alignment: Alignment.topLeft,
                      child: Image.asset('assets/logo.png')
                  ),
                  height: 150,
                  width: 200,
                  color: Colors.black,
                ),
                Container(
                  color: Colors.black,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex:8 ,
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
                            Get.to(() => CalenderView());},
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
                    Container(
                      child: Text(''),
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
                CalenderWidget(model),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      DateFormat("E d-MMM-y").format(model.selectedDate),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                model.eventOnDate.length == 0
                    ? Container(
                        height: 300,
                        child: Center(child: Text("No Event On This Date")))
                    : ListView.builder(
                        itemCount: model.eventOnDate.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return EventTile(
                            eventModel: model.eventOnDate[index],
                          );
                        },
                      ),


          ]
        ),
      ),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: false,
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
