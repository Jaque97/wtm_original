import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilledButton extends StatelessWidget {
  final String title;

  FilledButton({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.50),
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.28,
          ),
        ),
      ),
    );
  }
}
