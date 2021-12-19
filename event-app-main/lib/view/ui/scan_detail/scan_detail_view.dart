import 'package:event_app/app/constants.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/view/ui/scan_detail/scan_detail_viewmodel.dart';
import 'package:event_app/view/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScanDetailView extends StatelessWidget {
  final EventModel eventModel;

  ScanDetailView(this.eventModel);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ScanDetailViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "QR Details",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  RectImage(
                    imageUrl: eventModel.image,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                  Divider(
                    height: 2,
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: hMargin, vertical: vMargin),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Event Title: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventModel.title,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Date: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventModel.endDate == null
                                  ? eventModel.startDate
                                  : eventModel.startDate.toString() +
                                      " to" +
                                      eventModel.endDate.toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "User Name: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventModel.joinedUser.name,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Amount has been paid: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventModel.price,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
