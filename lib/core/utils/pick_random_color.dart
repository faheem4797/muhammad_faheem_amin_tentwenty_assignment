import 'dart:math';
import 'dart:ui';

import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';

Color pickRandomColor() {
  final random = Random();
  final listOfColors = [
    AppPallete.kDarkYellowColor,
    AppPallete.kPurpleColor,
    AppPallete.kGreenColor,
    AppPallete.kPinkColor,
  ];

  final index = random.nextInt(listOfColors.length);

  return listOfColors[index];
}
