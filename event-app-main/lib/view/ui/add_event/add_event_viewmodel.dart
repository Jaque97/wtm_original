import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/app/locator.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class AddEventViewModel extends BaseViewModel {
  String eventImage = "";
  String eventType = "Free";
  DateTime selectedTime = DateTime.now();
  List<DateTime> pickedDate = [];
  CommonUiService commonUiService = locator<CommonUiService>();
  EventService eventService = locator<EventService>();
  bool loading = false;

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> pickImage() async {
    var picked;
    await Get.dialog(AlertDialog(
      title: Text('Pick one source for image'),
      actions: [
        FlatButton(
            onPressed: () async {
              Get.back();
              picked =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (picked != null) {
                var cropped = await ImageCropper.cropImage(
                  sourcePath: picked.path,
                  compressQuality: 100,
                  cropStyle: CropStyle.rectangle,
                  aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
                );
                if (cropped != null) {
                  eventImage = cropped.path;
                  notifyListeners();
                }
              }
            },
            child: Text('Gallery')),
        FlatButton(
            onPressed: () async {
              Get.back();
              picked = await ImagePicker().getImage(source: ImageSource.camera);
              if (picked != null) {
                var cropped = await ImageCropper.cropImage(
                  sourcePath: picked.path,
                  compressQuality: 100,
                  cropStyle: CropStyle.rectangle,
                  aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
                );
                if (cropped != null) {
                  eventImage = cropped.path;
                  notifyListeners();
                }
              }
            },
            child: Text('Camera'))
      ],
    ));
  }

  void setEventType(value) {
    eventType = value;
    notifyListeners();
  }

  Future<void> createEvent(String title, String location, String description,
      String price, String timeCon) async {
    print(title + location + price + timeCon);
    if (title.isEmpty ||
        location.isEmpty ||
        description.isEmpty ||
        timeCon.isEmpty ||
        pickedDate.length == 0 ||
        eventImage.isEmpty ||
        (eventType == "Paid" && price.isEmpty)) {
      commonUiService.showSnackBar("Please fill all the fields");
      return;
    }

    EventModel eventModel = EventModel(
      image: eventImage,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      startDate: Timestamp.fromDate(pickedDate[0]),
      isPaid: eventType == "Paid" ? true : false,
      location: location,
      price: price,
      startTime: Timestamp.fromDate(selectedTime),
    );

    if (pickedDate.length == 2) {
      eventModel.endDate = Timestamp.fromDate(pickedDate[1]);
    }

    setLoading(true);
    var result = await eventService.addEvent(eventModel);
    setLoading(false);
    if (result != false) {
      Get.back(result: result);
      commonUiService.showSnackBar("Event Added Successfully");
    } else {
      commonUiService.showSnackBar("Please try again later");
    }
  }
}
