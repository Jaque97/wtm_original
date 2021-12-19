import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/view/ui/event_detail/event_detail_viewmodel.dart';
import 'package:event_app/view/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

class EventDetailView extends StatelessWidget {
  final EventModel eventModel;

  EventDetailView({this.eventModel});

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    return ViewModelBuilder<EventDetailViewModel>.reactive(
        viewModelBuilder: () => EventDetailViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Event Details",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ModalProgressHUD(
                inAsyncCall: model.loading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: eventModel.id,
                        child: RectImage(
                          imageUrl: eventModel.image,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 3,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                eventModel.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: Get.width,
                              child: Text(
                                eventModel.description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                      ? DateFormat("E d-MMM-y")
                                          .format(eventModel.startDate.toDate())
                                      : DateFormat("E d-MMM-y").format(
                                              eventModel.startDate.toDate()) +
                                          " to" +
                                          DateFormat("E d-MMM-y").format(
                                              eventModel.endDate.toDate()),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Time: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat(DateFormat.HOUR_MINUTE)
                                      .format(eventModel.startTime.toDate()),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Price: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  eventModel.price + " USD",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            if (StaticInfo.userModel.userType != "admin")
                              eventModel.qrImage != null
                                  ? Column(
                                      children: [
                                        Screenshot(
                                          controller: screenshotController,
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            color: Colors.white,
                                            child: Image.memory(
                                                eventModel.qrImage),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            model.saveQrCode(
                                                screenshotController,
                                                eventModel);
                                          },
                                          child: Container(
                                            width: Get.width * 0.7,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        27.5)),
                                            child: Center(
                                              child: Text(
                                                "Save QR Code",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : model.qrData != null
                                      ? Column(
                                          children: [
                                            Screenshot(
                                              controller: screenshotController,
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                color: Colors.white,
                                                child: QrImage(
                                                  data: model.qrData,
                                                  gapless: true,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                model.saveQrCode(
                                                    screenshotController,
                                                    eventModel);
                                              },
                                              child: Container(
                                                width: Get.width * 0.7,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27.5)),
                                                child: Center(
                                                  child: Text(
                                                    "Save QR Code",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            model.onJoin(eventModel,
                                                screenshotController);
                                          },
                                          child: Container(
                                            width: Get.width * 0.7,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        27.5)),
                                            child: Center(
                                              child: Text(
                                                "Join Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
            ));
  }
}
