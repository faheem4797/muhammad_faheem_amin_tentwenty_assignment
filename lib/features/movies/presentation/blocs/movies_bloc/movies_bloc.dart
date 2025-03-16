import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/usecase/usecase.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/usecases/get_trailer_path.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/mappers/movie_mapper.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends HydratedBloc<MoviesEvent, MoviesState> {
  final GetUpcomingMovies _getUpcomingMovies;
  final GetTrailerPath _getTrailerPath;
  MoviesBloc({
    required GetUpcomingMovies getUpcomingMovies,
    required GetTrailerPath getTrailerPath,
  }) : _getTrailerPath = getTrailerPath,
       _getUpcomingMovies = getUpcomingMovies,
       super(MoviesInitial()) {
    on<FetchUpcomingMoviesEvent>(_fetchUpcomingMoviesEvent);
  }

  FutureOr<void> _fetchUpcomingMoviesEvent(
    FetchUpcomingMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    List<Movie>? oldMovies;
    if (state is MoviesLoaded) {
      oldMovies = (state as MoviesLoaded).movies;
    }
    emit(MoviesLoading());
    final response = await _getUpcomingMovies(NoParams());

    response.fold(
      (l) {
        emit(MoviesError(message: l.message));
        if (oldMovies != null) {
          emit(MoviesLoaded(movies: oldMovies));
          return;
        }
      },
      (r) {
        emit(MoviesLoaded(movies: r));
      },
    );
  }

  Future<Either<String, String>> getTrailerPath(String movieId) async {
    final response = await _getTrailerPath(
      GetTrailerPathParams(movieId: movieId),
    );

    return response.fold(
      (l) {
        return Left(l.message);
        // if (oldMovies != null) {
        //   emit(MoviesLoaded(movies: oldMovies));
        //   return;
        // }
      },
      (r) {
        // List<Movie>? oldMovies;
        // if (state is MoviesLoaded) {
        //   oldMovies = (state as MoviesLoaded).movies;
        //   oldMovies.where((element) => (element.id.toString) == movieId).first.trailerPath = r;
        //   oldMovies
        //       .where((element) => (element.id.toString) == movieId)
        //       .first
        //       .trailerPath = r;
        // }

        // if (oldMovies != null) {
        //   emit(MoviesLoaded(movies: oldMovies));
        //   return;
        // }
        // emit(MoviesLoaded(movies: r));

        return Right(r);
      },
    );
  }

  @override
  MoviesState? fromJson(Map<String, dynamic> json) {
    try {
      return MoviesLoaded.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(MoviesState state) {
    if (state is MoviesLoaded) {
      return state.toJson();
    }

    return null;
  }
}
