import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maawnonton/theme/styles.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [pinkColor.withOpacity(0.2), greenColor.withOpacity(0.2)],
        ),
      ),
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              pinkColor,
              greenColor,
            ],
          ),
        ),
        child: RawMaterialButton(
          onPressed: () {},
          shape: const CircleBorder(),
          fillColor: const Color(0xff404c57),
          child: SvgPicture.asset('assets/svg/icon-plus.svg'),
        ),
      ),
    );
  }
}
