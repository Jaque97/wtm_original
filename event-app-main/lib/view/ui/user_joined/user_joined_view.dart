import 'package:event_app/app/constants.dart';
import 'package:event_app/view/ui/user_joined/user_joined_viewmodel.dart';
import 'package:event_app/view/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class UserJoinedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserJoinedViewModel>.reactive(
      viewModelBuilder: () => UserJoinedViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Joined QR",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: model.loading
            ? Center(child: CircularProgressIndicator())
            : model.msg != ""
                ? Center(child: Text(model.msg))
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: hMargin, vertical: vMargin),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: model.myJoinedEvents.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return EventTile(
                                  eventModel: model.myJoinedEvents[index]);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
    );
  }
}
