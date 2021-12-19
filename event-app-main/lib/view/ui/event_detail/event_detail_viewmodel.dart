import 'dart:convert';
import 'dart:typed_data';

import 'package:event_app/app/locator.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/services/common_ui_service.dart';
import 'package:event_app/services/event_service.dart';
import 'package:event_app/services/payment_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

class EventDetailViewModel extends BaseViewModel with CommonUiService {
  bool loading = false;
  EventService eventService = locator<EventService>();
  String qrData;

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> onJoin(
      EventModel eventModel, ScreenshotController screenshotController) async {
    if (eventModel.isPaid) {
      var response = await paymentDialog(eventModel.price);
      if (response == false) {
        return;
      }
      setLoading(true);
      String stripePrice = eventModel.price + "00";
      StripeTranSection stripeTranSection =
          await PaymentServices.payViaNewCard(stripePrice, "usd");
      if (stripeTranSection.success == false) {
        setLoading(false);
        showSnackBar("Please try again later");
        return;
      }
    }

    await Future.delayed(Duration(milliseconds: 500));
    eventModel.joinedUser = StaticInfo.userModel;
    eventModel.joinedBy = StaticInfo.userModel.id;
    eventModel.id = DateTime.now().millisecondsSinceEpoch.toString();
    EventModel qrEventModel = EventModel.fromMap(eventModel.toMap());
    qrEventModel.startDate =
        DateFormat("E-d-MMM-y").format(eventModel.startDate.toDate());

    if (eventModel.endDate != null) {
      qrEventModel.endDate =
          DateFormat("E-d-MMM-y").format(eventModel.endDate.toDate());
    }

    qrEventModel.startTime = DateFormat(DateFormat.HOUR_MINUTE)
        .format(eventModel.startTime.toDate());
    qrData = json.encode(qrEventModel.toMap());
    setLoading(false);
    showSnackBar("Event Joined Successfully");
    await screenshotController.capture().then((value) {
      print(value);
      return eventModel.qrImage = value;
    });
    await eventService.joinEvent(eventModel);
  }

  saveQrCode(
      ScreenshotController screenshotController, EventModel eventModel) async {
    screenshotController.capture().then((value) async {
      try {
        bool isGranted = await Permission.storage.request().isGranted;
        if (isGranted) {
          _saveToGallery(value, eventModel);
        } else {
          // Ask Permission
          PermissionStatus status = await Permission.storage.request();
          switch (status) {
            case PermissionStatus.granted:
              _saveToGallery(value, eventModel);
              break;
            case PermissionStatus.denied:
              debugPrint("Storage permission required to Save Image");
              break;
            case PermissionStatus.permanentlyDenied:
            case PermissionStatus.restricted:
              debugPrint(
                  "Storage permission required to Save Image, allow permissions in Settings");
              break;
          }
        }
      } catch (exp) {
        debugPrint("Storage Permission Error ${exp.toString()}");
      }
    });
  }

  Future<void> _saveToGallery(
      Uint8List imageFile, EventModel eventModel) async {
    try {
      final result = await ImageGallerySaver.saveImage(imageFile,
          name: eventModel.title +
              " " +
              DateTime.now().millisecondsSinceEpoch.toString());
      print(result);
      showSnackBar("QR saved \n check your Gallery");
    } on Exception catch (exp) {
      showSnackBar("Fail to save \n Take a screenshot");
    }
  }
}
