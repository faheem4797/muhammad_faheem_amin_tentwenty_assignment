import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/common/widgets/loader.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double height;
  final double? width;

  const MovieCard({
    super.key,
    required this.movie,
    this.height = 180,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width?.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppPallete.kDarkColor.withValues(alpha: 0.1),
            blurRadius: 8.r,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie poster image
          movie.backdropPath.isNotEmpty
              ? CachedNetworkImage(
                imageUrl: Constants.imageBaseUrl + movie.backdropPath,

                fit: BoxFit.cover,
                placeholder: (context, url) => Loader(),
                errorWidget:
                    (_, __, ___) => Container(
                      color: AppPallete.kGreyColor,
                      child: Icon(
                        Icons.movie,
                        color: AppPallete.kWhiteColor,
                        size: 50,
                      ),
                    ),
              )
              : Container(
                color: AppPallete.kGreyColor,
                child: Icon(
                  Icons.movie,
                  color: AppPallete.kWhiteColor,
                  size: 50,
                ),
              ),

          // Gradient overlay for better text visibility
          height != 180
              ? Container()
              : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppPallete.kDarkColor.withValues(alpha: 0.7),
                      AppPallete.kTransparentColor,
                    ],
                    stops: [0.0, 0.5],
                  ),
                ),
              ),

          // Movie title
          height != 180
              ? Container()
              : Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w,
                child: Text(
                  movie.title,
                  style: TextStyle(
                    color: AppPallete.kWhiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2.r,
                        color: AppPallete.kDarkColor.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

          Material(
            color: AppPallete.kTransparentColor,
            child: InkWell(
              onTap: () {
                context.pushNamed(
                  AppRouteConstants.movieDetailsRouteName,
                  extra: movie,
                );
              },
              splashColor: AppPallete.kWhiteColor.withValues(alpha: 0.1),
              highlightColor: AppPallete.kTransparentColor,
            ),
          ),
        ],
      ),
    );
  }
}
