import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:maawnonton/theme/styles.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: screenWidth,
      height: 60,
      borderRadius: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          whiteColor.withOpacity(0.1),
          whiteColor.withOpacity(0.1),
        ],
      ),
      border: 0,
      blur: 30,
      borderGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          pinkColor,
          greenColor,
        ],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        notchMargin: 4,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/icon-home.svg',
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/icon-playtv.svg',
                ),
              ),
            ),
            const Expanded(
              child: Text(''),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/icon-categories.svg',
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/icon-download.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
