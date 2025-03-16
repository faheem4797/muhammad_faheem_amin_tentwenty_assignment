import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/widgets/searched_movie_tile.dart';

class SearchResultPage extends StatelessWidget {
  final List<Movie> searchedMovies;
  const SearchResultPage({super.key, required this.searchedMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.kWhiteColor,
        elevation: 0,
        title: Text(
          searchedMovies.length > 1
              ? '${searchedMovies.length} Results Found'
              : '${searchedMovies.length} Result Found',
          style: TextStyle(
            color: AppPallete.kDarkColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SearchedMovieTile(searchedMovies: searchedMovies),
      ),
    );
  }
}
