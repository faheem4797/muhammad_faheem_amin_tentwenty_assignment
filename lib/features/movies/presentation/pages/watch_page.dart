import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/common/widgets/loader.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/utils/show_snackbar.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/widgets/movie_card.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppPallete.kWhiteColor,
        elevation: 0,
        title: Text(
          Constants.watchTitle,
          style: TextStyle(
            color: AppPallete.kDarkColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppPallete.kDarkColor, size: 19.r),
            onPressed: () {
              if (context.read<MoviesBloc>().state is! MoviesLoaded) {
                return;
              }
              context.pushNamed(
                AppRouteConstants.searchRouteName,
                extra: SearchMovieState(
                  searchText: '',
                  allMovies:
                      (context.read<MoviesBloc>().state as MoviesLoaded).movies,
                  searchedMovies: [],
                ),
              );
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (context, state) {
          if (state is MoviesError) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is MoviesInitial || state is MoviesLoading) {
            return Loader();
          } else if (state is MoviesLoaded) {
            return _buildMovieList(state.movies);
          }
          // else if (state is MoviesSearchResult) {
          //   return _buildMovieList(state.movies);
          // }
          else if (state is MoviesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: AppPallete.kRedColor),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoviesBloc>().add(
                        FetchUpcomingMoviesEvent(),
                      );
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: MovieCard(movie: movie),
        );
      },
    );
  }
}
