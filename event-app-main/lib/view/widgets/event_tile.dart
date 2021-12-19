import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/view/ui/event_detail/event_detail_view.dart';
import 'package:event_app/view/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final EventModel eventModel;
  final Function onDelete;
  final bool isJoined;

  EventTile({this.eventModel, this.onDelete, this.isJoined = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => EventDetailView(
              eventModel: eventModel,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(18)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Hero(
                      tag: eventModel.id,
                      child: RectImage(
                        imageUrl: eventModel.image,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      ),
                    ),
                    StaticInfo.userModel.userType == "Admin"
                        ? Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: onDelete,
                                  child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          Theme.of(context).primaryColorDark,
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    eventModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  DateFormat("d-MMM-y").format(eventModel.startTime.toDate()),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "Joining Fee",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  eventModel.price + " USD",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
