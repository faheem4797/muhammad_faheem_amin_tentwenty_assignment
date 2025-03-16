import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/common/widgets/loader.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/utils/readable_date_formatting.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/utils/show_snackbar.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppPallete.kTransparentColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: BackButton(color: AppPallete.kWhiteColor),
        title: Text(
          Constants.watchTitle,
          style: TextStyle(
            color: AppPallete.kWhiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPosterSection(context),
            _buildGenres(),
            _buildOverview(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height.h * 0.6,
      child: CachedNetworkImage(
        imageUrl: Constants.imageBaseUrl + widget.movie.posterPath,
        placeholder: (context, url) => Loader(),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),

        imageBuilder:
            (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPallete.kTransparentColor,
                      AppPallete.kDarkColor.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      '${Constants.inTheaters} ${readableDateFormatting(widget.movie.releaseDate)}',

                      style: TextStyle(
                        color: AppPallete.kWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRouteConstants.getTicketsRouteName,
                            extra: widget.movie,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPallete.kBlueColor,
                          foregroundColor: AppPallete.kWhiteColor,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          Constants.getTickets,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                      child: OutlinedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final response = await context
                                      .read<MoviesBloc>()
                                      .getTrailerPath(
                                        widget.movie.id.toString(),
                                      );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  response.fold(
                                    (l) {
                                      showSnackBar(context, l);
                                    },
                                    (r) => context.pushNamed(
                                      AppRouteConstants.watchTrailerRouteName,
                                      extra: r,
                                    ),
                                  );
                                },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppPallete.kWhiteColor),
                          foregroundColor: AppPallete.kWhiteColor,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child:
                            isLoading
                                ? Loader(color: AppPallete.kWhiteColor)
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow, size: 20.r),
                                    SizedBox(width: 8.w),
                                    Text(
                                      Constants.watchTrailer,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildGenres() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constants.genres,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: List.generate(
              widget.movie.genreIds.length,
              (i) => _buildGenreChip(
                Constants.genreId[widget.movie.genreIds[i]]!,
                Constants.listOfColors[i],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: AppPallete.kWhiteColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constants.overview,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.movie.overview,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppPallete.kGreyColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
