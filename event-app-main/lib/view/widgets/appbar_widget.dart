import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.black,
    elevation: 0,
  );
}