import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Capitalize the first letter of the first word
    String capitalizedText =
        text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1)}' : '';

    return Text(
      capitalizedText,
      style: TextStyle(fontSize: fontSize.sp, fontWeight: fontWeight),
    );
  }
}
