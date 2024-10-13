import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realestate/core/core.dart';
import 'package:realestate/core/themes/color_constants.dart';
import 'package:realestate/features/home/presentation/widgets/custom_bottom_bar.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
      : super(key: key);

  final StatefulNavigationShell navigationShell;
  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goBranch(3);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.navigationShell.currentIndex == 0 &&
            Navigator.of(context).canPop()) {
          // If on the home tab and there's a route to pop, pop the route
          Navigator.of(context).pop();
          return false; // Prevent the app from exiting
        } else if (widget.navigationShell.currentIndex != 0) {
          // If not on the home tab, switch to the home tab
          context.go(AppRoutes.home);
          return false; // Prevent the app from exiting
        }
        return true; // Allow the app to exit
      },
      child: Scaffold(

        body: Stack(
          children: [
            widget.navigationShell,
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: CustomBottomBar(
                  onDestinationSelected: _goBranch,
                  selectedIndex: widget.navigationShell.currentIndex,
                ),
              ),
            )
          ],
        ),
        backgroundColor: ColorConstants().secondaryColor,
        bottomNavigationBar: const SizedBox.shrink(),
      ),
    );
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: false,
    );
  }
}
