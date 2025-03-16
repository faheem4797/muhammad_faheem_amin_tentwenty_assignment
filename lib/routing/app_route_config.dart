import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/get_tickets.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/movie_details_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/search_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/search_result_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/seat_selection_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/trailer_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/pages/watch_page.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/init_dependencies.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/widgets/scaffold_with_bottom_navbar.dart';

class MyAppRouter {
  // Private navigator keys for each tab
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _watchNavigatorKey = GlobalKey<NavigatorState>();
  static final _libraryNavigatorKey = GlobalKey<NavigatorState>();
  static final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final _moreNavigatorKey = GlobalKey<NavigatorState>();

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConstants.initialRoutePath,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // Movie details route
      GoRoute(
        path: AppRouteConstants.movieDetailsRoutePath,
        name: AppRouteConstants.movieDetailsRouteName,
        pageBuilder: (context, state) {
          // You can extract movie data from state.extra if passed
          final movie = state.extra as Movie;
          return MaterialPage(child: MovieDetailsScreen(movie: movie));
        },
        routes: [
          GoRoute(
            path: AppRouteConstants.watchTrailerRoutePath,
            name: AppRouteConstants.watchTrailerRouteName,
            pageBuilder: (context, state) {
              final youtubeUrl = state.extra as String;

              return MaterialPage(child: TrailerPage(videoUrl: youtubeUrl));
            },
          ),
          GoRoute(
            path: AppRouteConstants.getTicketsRoutePath.substring(1),
            name: AppRouteConstants.getTicketsRouteName,
            pageBuilder: (context, state) {
              final movie = state.extra as Movie;

              return MaterialPage(child: GetTicketsPage(movie: movie));
            },
            routes: [
              // Select Seats route
              GoRoute(
                path: AppRouteConstants.selectSeatsRoutePath.substring(1),
                name: AppRouteConstants.selectSeatsRouteName,
                pageBuilder: (context, state) {
                  final movie = state.extra as Movie;

                  return MaterialPage(
                    child: SeatSelectionPage(movie: movie),
                    // SelectSeatsScreen(
                    //   bookingData: bookingData,
                    // ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      // Main scaffold with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Return your scaffold with bottom navigation
          return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Dashboard Tab Branch
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstants.dashboardRoutePath,
                name: AppRouteConstants.dashboardRouteName,
                pageBuilder:
                    (context, state) => const NoTransitionPage(
                      // child: DashboardScreen()
                      child: Scaffold(
                        body: Center(child: Text("Dashboard Screen")),
                      ),
                    ),
              ),
            ],
          ),

          // Watch Tab Branch
          StatefulShellBranch(
            navigatorKey: _watchNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstants.watchRoutePath,
                name: AppRouteConstants.watchRouteName,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: WatchScreen()),
                routes: [
                  // Search route
                  GoRoute(
                    path: AppRouteConstants.searchRoutePath.substring(1),
                    name: AppRouteConstants.searchRouteName,
                    pageBuilder: (context, state) {
                      final initialState = state.extra as SearchMovieState;
                      return MaterialPage(
                        child: BlocProvider(
                          create:
                              (context) => serviceLocator<SearchMovieBloc>(
                                param1: initialState,
                              ),
                          child: const SearchPage(),
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.searchResultRoutePath.substring(
                      1,
                    ), // Remove leading slash
                    name: AppRouteConstants.searchResultRouteName,
                    pageBuilder: (context, state) {
                      final initialState = state.extra as List<Movie>;
                      return MaterialPage(
                        child: SearchResultPage(searchedMovies: initialState),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstants.movieLibraryRoutePath,
                name: AppRouteConstants.movieLibraryRouteName,
                pageBuilder:
                    (context, state) => const NoTransitionPage(
                      child:
                      // MovieLibraryScreen()
                      Scaffold(
                        body: Center(child: Text("Media Library Screen")),
                      ),
                    ),
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _moreNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstants.moreRoutePath,
                name: AppRouteConstants.moreRouteName,
                pageBuilder:
                    (context, state) => const NoTransitionPage(
                      child:
                      // MoreScreen()
                      Scaffold(body: Center(child: Text("More Screen"))),
                    ),
              ),
            ],
          ),
        ],
      ),

      // Redirect root to watch screen
      GoRoute(
        path: AppRouteConstants.initialRoutePath,
        redirect: (context, state) => AppRouteConstants.watchRoutePath,
      ),
    ],
  );
}
