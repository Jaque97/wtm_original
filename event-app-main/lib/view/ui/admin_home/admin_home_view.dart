import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/view/ui/admin_home/admin_home_viewmodel.dart';
import 'package:event_app/view/ui/calender/calander_view.dart';
import 'package:event_app/view/ui/event/event_view.dart';
import 'package:event_app/view/ui/scan_detail/scan_detail_view.dart';
import 'package:event_app/view/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class AdminHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminHomeViewModel>.reactive(
        viewModelBuilder: () => AdminHomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "What's the Move",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontFamily: GoogleFonts.acme().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                leading: InkWell(
                  onTap: () async {
                    ScanResult codeScanner = await BarcodeScanner.scan(
                      options: ScanOptions(
                          useCamera: -1,
                          android: AndroidOptions(useAutoFocus: true)),
                    );
                    print(codeScanner);
                    print(codeScanner.rawContent);
                    if (codeScanner.rawContent != "") {
                      try {
                        EventModel eventModel = EventModel.fromMap(
                            json.decode(codeScanner.rawContent));
                        Get.to(() => ScanDetailView(eventModel));
                      } catch (e) {
                        model.showSnackBar("Invalid QR Code");
                      }
                    }
                    print(codeScanner.rawContent);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Center(
                          child: Icon(
                        Icons.qr_code_scanner,
                        size: 26,
                      ))),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                      onTap: model.logout,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.logout)))
                ],
              ),
              body: IndexedStack(
                index: model.currentIndex,
                children: [EventView(), CalenderView()],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: model.addEvent,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                child: Icon(
                  Icons.add,
                  size: 23,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              extendBody: true,
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: BottomNavBar(
                selectedIndex: model.currentIndex,
                onIndexChange: (index) {
                  model.setIndex(index);
                },
              ),
            ));
  }
}
