import 'package:flutter/material.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';

class AppTheme {
  // static _border([
  //   Color color = AppPallete.kTransparentColor,
  //   double width = 1,
  // ]) => OutlineInputBorder(
  //   borderSide: BorderSide(color: color, width: width),
  //   borderRadius: BorderRadius.circular(10.r),
  // );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.kWhiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppPallete.kBlueColor),
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPallete.kDarkColor,
      selectedItemColor: AppPallete.kWhiteColor,
      unselectedItemColor: AppPallete.kGreyColor,
    ),

    // appBarTheme: AppBarTheme(
    //     backgroundColor: AppPallete.kDarkBlueColor,
    //     titleTextStyle: TextStyle(
    //         fontSize: 24.sp,
    //         color: AppPallete.kWhiteColor,
    //         fontWeight: FontWeight.bold),
    //     iconTheme: const IconThemeData(color: AppPallete.kWhiteColor)),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: AppPallete.gradient1,
    //   selectionHandleColor: AppPallete.gradient1,
    // ),
    // chipTheme: ChipThemeData(
    //   showCheckmark: false,
    //   selectedColor: AppPallete.gradient1,
    //   backgroundColor: AppPallete.lightGreyColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(5.0),
    //     side: const BorderSide(color: AppPallete.borderColor, width: 0.3),
    //   ),
    // ),

    // inputDecorationTheme: InputDecorationTheme(
    //   floatingLabelBehavior: FloatingLabelBehavior.never,
    //   filled: true,
    //   fillColor: AppPallete.kLightWhiteColor,
    //   // contentPadding: const EdgeInsets.all(24),
    //   border: _border(),
    //   enabledBorder: _border(
    //     AppPallete.kLightWhiteColor,
    //   ),
    //   focusedBorder: _border(AppPallete.kDarkBlueColor, 2),
    // errorBorder: _border(AppPallete.kErrorColor),
    // hintStyle: const TextStyle(color: AppPallete.kGreyColor),
    // suffixIconColor: AppPallete.kGreyColor,
    // ),
  );
}
