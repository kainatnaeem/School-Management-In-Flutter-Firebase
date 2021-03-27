import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MultiPickerApp {
  static Color navigateButton = Color(0xff141516);
  static Color pauseButton = Color(0xffF41F00);
  static Color pauseButtonDarker = Color(0xff9B1400);
  static Color background = Colors.brown;
  static Color brighter = Color(0xff353235);
  static Color darker = Colors.black;
}

// I  found this widget on Github
class ThreeDContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color backgroundDarkerColor;
  final Color borderColor;
  final Color borderDarkerColor;
  final double spreadRadius;
  final double offset;
  final double blurRadius;
  const ThreeDContainer({
    Key key,
    @required this.child,
    @required this.width,
    @required this.height,
    @required this.backgroundColor,
    @required this.backgroundDarkerColor,
    this.borderColor,
    this.borderDarkerColor,
    this.blurRadius = 15,
    this.spreadRadius = 2,
    this.offset = 2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: MultiPickerApp.darker,
            //  offset: Offset(offset, offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
          BoxShadow(
              color: MultiPickerApp.brighter,
              offset: Offset(-offset, -offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
        ],
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            borderDarkerColor ?? MultiPickerApp.darker,
            borderColor ?? MultiPickerApp.brighter,
          ],
        ),
      ),
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundDarkerColor,
                backgroundColor,
              ],
            )),
      ),
    );
  }
}