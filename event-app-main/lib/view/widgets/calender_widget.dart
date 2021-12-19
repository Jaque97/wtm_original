import 'package:event_app/view/ui/calender/calender_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';

class CalenderWidget extends StatelessWidget {
  final CalenderViewModel model;

  CalenderWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      width: Get.width,
      height: 450,
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: CalendarCarousel<Event>(
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        isScrollable: false,
        onDayPressed: (DateTime date, List<Event> events) =>
            model.onDateChange(date),
        //   markedDatesMap:_markedDateMap,
        todayButtonColor: Theme.of(context).primaryColorDark,
        leftButtonIcon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).primaryColor,
        ),
        rightButtonIcon: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).primaryColor,
        ),
        todayBorderColor: Colors.transparent,
        selectedDayButtonColor: Theme.of(context).primaryColor,
        selectedDayBorderColor: Colors.transparent,
        headerTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 18),
        headerMargin: EdgeInsets.all(4),
        weekDayBackgroundColor: Color(0xffEBEBEB),
        weekDayFormat: WeekdayFormat.narrow,
        weekdayTextStyle: TextStyle(color: IconTheme.of(context).color),
        weekDayPadding: EdgeInsets.all(8),
        selectedDateTime: model.selectedDate,
        daysHaveCircularBorder: true,
      ),
    );
  }
}
