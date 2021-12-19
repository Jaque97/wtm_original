import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  final String tabTitle;
  final int currentIndex;
  final int tabIndex;

  EventTab({this.tabTitle, this.currentIndex, this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.50),
        color: currentIndex == tabIndex
            ? Theme.of(context).primaryColor
            : Colors.transparent,
      ),
      child: Center(
        child: AutoSizeText(
          tabTitle,
          textAlign: TextAlign.center,
          presetFontSizes: [14, 12, 10],
          style: TextStyle(
            color: currentIndex == tabIndex ? Colors.white : Colors.black,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
