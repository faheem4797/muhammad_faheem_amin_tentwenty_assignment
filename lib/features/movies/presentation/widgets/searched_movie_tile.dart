import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/widgets/movie_card.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class SearchedMovieTile extends StatelessWidget {
  final List<Movie> searchedMovies;
  const SearchedMovieTile({super.key, required this.searchedMovies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchedMovies.length,

      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            onTap: () {
              context.pushNamed(
                AppRouteConstants.movieDetailsRouteName,
                extra: searchedMovies[index],
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  MovieCard(
                    movie: searchedMovies[index],
                    height: 100.h,
                    width: 130.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchedMovies[index].title,

                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          Constants.genreId[searchedMovies[index]
                                  .genreIds
                                  .first] ??
                              '',
                          style: TextStyle(
                            color: AppPallete.kGreyColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  Icon(Icons.more_horiz, color: AppPallete.kBlueColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
