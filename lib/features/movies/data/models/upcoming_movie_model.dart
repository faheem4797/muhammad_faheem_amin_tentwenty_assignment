import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';

class UpcomingMovieModel extends Movie {
  const UpcomingMovieModel({
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.trailerPath,
  });

  factory UpcomingMovieModel.fromMap(Map<String, dynamic> map) {
    return UpcomingMovieModel(
      id: map['id']?.toInt() ?? 0,
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids']),
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      trailerPath: map['trailer_path'],
    );
  }
}
