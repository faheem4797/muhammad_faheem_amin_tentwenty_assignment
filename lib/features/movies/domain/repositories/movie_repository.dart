import 'package:fpdart/fpdart.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/failure.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<Movie>>> getUpcomingMovies();
  Future<Either<Failure, String>> getTrailerPath({required String movieId});
}
