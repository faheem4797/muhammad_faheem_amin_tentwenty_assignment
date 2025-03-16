import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';

class FullWidthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const FullWidthButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: AppPallete.kBlueColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppPallete.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
