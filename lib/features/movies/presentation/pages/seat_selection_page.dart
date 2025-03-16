import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/utils/readable_date_formatting.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';

class SeatSelectionPage extends StatefulWidget {
  final Movie movie;
  const SeatSelectionPage({super.key, required this.movie});

  @override
  State<SeatSelectionPage> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatSelectionPage> {
  // 0: Not available, 1: Regular seat, 2: VIP seat, 3: Selected seat
  final List<List<int>> seatMatrix = [
    [0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0],
    [0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0],
    [1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1],
    [1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1],
    [1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1],
    [1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1],
    [2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2],
  ];

  int selectedSeats = 4;
  double totalPrice = 50.0;
  String selectedRow = "3 row";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.movie.title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            Text(
              '${Constants.inTheaters} ${readableDateFormatting(widget.movie.releaseDate)}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: AppPallete.kBlueColor,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Theater screen indicator
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "SCREEN",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppPallete.kBlueColor.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 30.h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppPallete.kBlueColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      children: List.generate(
                        seatMatrix.length,
                        (index) => Container(
                          height: 40,
                          width: 25,
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Seat matrix
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            seatMatrix.length,
                            (rowIndex) => Row(
                              children: List.generate(
                                seatMatrix[rowIndex].length,
                                (colIndex) => SeatWidget(
                                  seatType: seatMatrix[rowIndex][colIndex],
                                  onTap: () {
                                    setState(() {
                                      if (seatMatrix[rowIndex][colIndex] == 1) {
                                        seatMatrix[rowIndex][colIndex] = 3;
                                        selectedSeats++;
                                        totalPrice += 50.0;
                                      } else if (seatMatrix[rowIndex][colIndex] ==
                                          3) {
                                        seatMatrix[rowIndex][colIndex] = 1;
                                        selectedSeats--;
                                        totalPrice -= 50.0;
                                      } else if (seatMatrix[rowIndex][colIndex] ==
                                          2) {
                                        seatMatrix[rowIndex][colIndex] = 3;
                                        selectedSeats++;
                                        totalPrice += 150.0;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem(Colors.amber, "Selected"),
                      _buildLegendItem(Colors.grey.shade300, "Not available"),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem(Colors.deepPurple, "VIP (150\$)"),
                      _buildLegendItem(Colors.lightBlue, "Regular (50\$)"),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  Text(
                    "$selectedSeats",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  const Text(" / "),
                  Text(
                    selectedRow,
                    style: const TextStyle(color: AppPallete.kGreyColor),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            //Price Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                          color: AppPallete.kGreyColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "\$ ${totalPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.kBlueColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: const Text(
                        "Proceed to pay",
                        style: TextStyle(
                          color: AppPallete.kWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(fontSize: 12.sp, color: AppPallete.kGreyColor),
        ),
      ],
    );
  }
}

class SeatWidget extends StatelessWidget {
  final int seatType; // 0: Not available, 1: Regular, 2: VIP, 3: Selected
  final VoidCallback onTap;

  const SeatWidget({super.key, required this.seatType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    bool isSelectable = true;

    switch (seatType) {
      case 0:
        seatColor = AppPallete.kGreyColor;
        isSelectable = false;
        break;
      case 1:
        seatColor = AppPallete.kBlueColor;
        break;
      case 2:
        seatColor = AppPallete.kPurpleColor;
        break;
      case 3:
        seatColor = AppPallete.kDarkYellowColor;
        break;
      default:
        seatColor = Colors.grey.shade300;
        isSelectable = false;
    }

    return GestureDetector(
      onTap: isSelectable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
