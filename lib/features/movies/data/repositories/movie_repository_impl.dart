import 'package:fpdart/fpdart.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/constants/constants.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/connection_exception.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/failure.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/server_exception.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/network/connection_checker.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;
  final ConnectionChecker connectionChecker;

  MovieRepositoryImpl({
    required this.movieRemoteDatasource,
    required this.connectionChecker,
  });
  @override
  Future<Either<Failure, String>> getTrailerPath({
    required String movieId,
  }) async {
    if (await connectionChecker.isConnected) {
      try {
        final videoModel = await movieRemoteDatasource.getTrailerPath(
          movieId: movieId,
        );
        return Right(Constants.youtubeBaseUrl + videoModel.key);
      } on ServerException catch (e) {
        return Left(Failure(e.message));
      } on ConnectionException catch (e) {
        return Left(Failure(e.message));
      } catch (e) {
        return Left(Failure());
      }
    } else {
      return Left(Failure(Constants.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() async {
    if (await connectionChecker.isConnected) {
      try {
        final movieModels = await movieRemoteDatasource.getUpcomingMovies();
        return Right(movieModels);
      } on ServerException catch (e) {
        return Left(Failure(e.message));
      } on ConnectionException catch (e) {
        return Left(Failure(e.message));
      } catch (e) {
        return Left(Failure());
      }
    } else {
      return Left(Failure(Constants.noInternetConnection));
    }
  }
}
