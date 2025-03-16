import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/app_bloc_observer.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/network/connection_checker.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/repositories/movie_repository.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/usecases/get_trailer_path.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/search_movie_bloc/search_movie_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'init_dependencies.main.dart';
