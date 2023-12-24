import 'package:flutter/material.dart';
import 'package:assignment5/presentation/pages/mobile/mobileLayout.dart';
import 'package:assignment5/presentation/pages/web/desktopLayout.dart';

// SETTING UP LAYOUT SCREEN
class LayoutHome extends StatelessWidget {
  const LayoutHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          //600 for desktop
          return const DesktopLayoutHome();
        } else {
          return const MobileLayoutHome();
        }
      },
    );
  }
}
