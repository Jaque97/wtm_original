import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget{
  @override
Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(context, '45', 'followers'),
      buildDivider(),
      buildButton(context, '24', 'following'),
      buildDivider(),
    ],
  );

  Widget buildDivider() => VerticalDivider();

  Widget buildButton(BuildContext context, String value, String text) =>
    MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 20),
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style:TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
          ),
          SizedBox(height:2),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )

        ],
      ),
    );
  }
