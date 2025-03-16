import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/error/failure.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/usecase/usecase.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/repositories/movie_repository.dart';

class GetTrailerPath implements UseCase<String, GetTrailerPathParams> {
  final MovieRepository movieRepository;
  GetTrailerPath({required this.movieRepository});
  @override
  Future<Either<Failure, String>> call(GetTrailerPathParams params) async {
    return await movieRepository.getTrailerPath(movieId: params.movieId);
  }
}

class GetTrailerPathParams extends Equatable {
  final String movieId;

  const GetTrailerPathParams({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
