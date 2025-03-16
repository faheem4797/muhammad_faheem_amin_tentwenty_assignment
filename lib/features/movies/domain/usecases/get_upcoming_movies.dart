import 'package:fpdart/fpdart.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/failure.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/usecase/usecase.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/repositories/movie_repository.dart';

class GetUpcomingMovies implements UseCase<List<Movie>, NoParams> {
  final MovieRepository movieRepository;
  GetUpcomingMovies({required this.movieRepository});
  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await movieRepository.getUpcomingMovies();
  }
}
