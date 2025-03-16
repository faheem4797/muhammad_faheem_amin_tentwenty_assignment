import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/widgets/searched_movie_tile.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: AppPallete.kLightGreyColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              return TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchMovieBloc>().add(Search(value));
                },
                onSubmitted: (value) {
                  context.read<SearchMovieBloc>().add(Search(value));
                  context.pushNamed(
                    AppRouteConstants.searchResultRouteName,
                    extra: state.searchedMovies,
                  );
                },
                decoration: InputDecoration(
                  hintText: Constants.searchHint,
                  hintStyle: TextStyle(
                    color: AppPallete.kGreyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  prefixIcon: IconButton(
                    onPressed: () {
                      context.pushNamed(
                        AppRouteConstants.searchResultRouteName,
                        extra: state.searchedMovies,
                      );
                    },
                    icon: Icon(Icons.search, size: 20),
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SearchMovieBloc>().add(ClearSearchField());
                      _searchController.clear();
                    },
                    icon: Icon(Icons.close, size: 20),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
          builder: (context, state) {
            if (state.searchText.trim().isEmpty) {
              return SearchGenreWidget();
            } else if (state.searchText.trim().isNotEmpty) {
              if (state.searchedMovies.isEmpty) {
                return Center(
                  child: Text(
                    Constants.noMoviesFound,
                    style: TextStyle(
                      color: AppPallete.kDarkColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Constants.topResults),
                    Divider(),
                    Expanded(
                      child: SearchedMovieTile(
                        searchedMovies: state.searchedMovies,
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class SearchGenreWidget extends StatelessWidget {
  const SearchGenreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Genre Grid
        Expanded(
          child: Center(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.62,
              ),
              itemCount: Constants.genresOnSearchPage.length,
              itemBuilder: (context, index) {
                return GenreCard(
                  name: Constants.genresOnSearchPage[index]["name"]!,
                  imagePath: Constants.genresOnSearchPage[index]["image"]!,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class GenreCard extends StatelessWidget {
  final String name;
  final String imagePath;

  const GenreCard({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.fill),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppPallete.kDarkColor.withValues(alpha: 0.2),
                  AppPallete.kDarkColor.withValues(alpha: 0.5),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Text(
              name,
              style: TextStyle(
                color: AppPallete.kWhiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
