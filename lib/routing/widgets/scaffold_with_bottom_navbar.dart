import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: SizedBox(
          height: 75.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27.r),
              topRight: Radius.circular(27.r),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view),
                  label: Constants.dashBoardTitle,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.smart_display_outlined),
                  activeIcon: Icon(Icons.smart_display),
                  label: Constants.watchTitle,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined),
                  activeIcon: Icon(Icons.subscriptions),
                  label: Constants.mediaLibraryTitle,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined),
                  activeIcon: Icon(Icons.list),
                  label: Constants.moreTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
