import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget(
      {super.key, this.width = 160, this.height = 179, this.image});
  final double height;
  final double width;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
          color: Colors.orange,
          image:
              image != null ? DecorationImage(image: AssetImage(image!), fit: BoxFit.cover) : null,
          borderRadius: BorderRadius.circular(30)),
    );
  }
}
