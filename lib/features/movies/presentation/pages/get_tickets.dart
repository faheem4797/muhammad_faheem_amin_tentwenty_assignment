import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/utils/readable_date_formatting.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class GetTicketsPage extends StatelessWidget {
  final Movie movie;
  const GetTicketsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kWhiteColor,
      body: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                movie.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              Text(
                '${Constants.inTheaters} ${readableDateFormatting(movie.releaseDate)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppPallete.kBlueColor,
                ),
              ),
            ],
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDateSelector(),
                    const SizedBox(height: 24),
                    _buildTimeSlots(),
                    Spacer(),
                    _buildSelectSeatsButton(context),

                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _dateChip("5 Mar", true),
          _dateChip("6 Mar", false),
          _dateChip("7 Mar", false),
          _dateChip("8 Mar", false),
          _dateChip("9 Mar", false),
        ],
      ),
    );
  }

  Widget _dateChip(String date, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(
          date,
          style: TextStyle(
            color: isSelected ? AppPallete.kWhiteColor : AppPallete.kDarkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor:
            isSelected ? AppPallete.kBlueColor : AppPallete.kLightGreyColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _timeSlotWithSeatmap(
            "12:30",
            "Cinetech + Hall 1",
            "From 50\$ or 2500 bonus",
          ),
          const SizedBox(width: 20),
          _timeSlotWithSeatmap(
            "01:30",
            "Cinetech",
            "From 75\$ or 3000 bonus",
            showFullSeatMap: false,
          ),
          const SizedBox(width: 20),

          _timeSlotWithSeatmap(
            "02:30",
            "Cinetech + Hall 1",
            "From 50\$ or 2500 bonus",
          ),
        ],
      ),
    );
  }

  Widget _timeSlotWithSeatmap(
    String time,
    String hall,
    String priceInfo, {
    bool showFullSeatMap = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Text(
              hall,
              style: TextStyle(fontSize: 16.sp, color: AppPallete.kGreyColor),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 140.h,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppPallete.kGreyColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(child: Image.asset('assets/get_tickets.png')),
        ),
        SizedBox(height: 8.h),
        Text(
          priceInfo,
          style: TextStyle(fontSize: 14.sp, color: AppPallete.kGreyColor),
        ),
      ],
    );
  }

  Widget _buildSelectSeatsButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouteConstants.selectSeatsRouteName, extra: movie);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppPallete.kBlueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Select Seats',
            style: TextStyle(
              color: AppPallete.kWhiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
