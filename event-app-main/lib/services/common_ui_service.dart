import 'package:event_app/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class CommonUiService {
  final SnackbarService _snackBarService = locator<SnackbarService>();

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        fontSize: 16.0);
  }

  showSnackBar(String msg) {
    _snackBarService.showSnackbar(message: msg);
  }

  showOnBackDialogue() async {
    bool isPublic = false;
    await Get.defaultDialog(
        radius: 6,
        barrierDismissible: false,
        title: "Alert",
        middleText: "Do you want to go back?",
        buttonColor: Colors.black,
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.white,
        textCancel: "  No  ",
        onCancel: () {
          isPublic = false;
          // Get.back();
        },
        textConfirm: "  Yes  ",
        onConfirm: () async {
          isPublic = true;
          Get.back();
        });

    return isPublic;
  }

  paymentDialog(String amount) async {
    bool isPublic = false;
    await Get.defaultDialog(
        radius: 6,
        barrierDismissible: false,
        title: "Alert",
        middleText:
            "By continuing you will be asked for card details to pay $amount USD for this event.",
        buttonColor: Colors.black,
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.white,
        textCancel: "  Cancel  ",
        onCancel: () {
          isPublic = false;
          // Get.back();
        },
        textConfirm: "  Continue  ",
        onConfirm: () async {
          isPublic = true;
          Get.back();
        });

    return isPublic;
  }
}
