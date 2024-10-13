import 'package:flutter/material.dart';
import 'package:realestate/core/themes/color_constants.dart';

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
          color: ColorConstants().primaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    );
  }
}
