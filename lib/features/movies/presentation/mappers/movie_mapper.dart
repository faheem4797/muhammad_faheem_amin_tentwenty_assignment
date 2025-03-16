import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';

class MovieMapper {
  static Map<String, dynamic> toMap(Movie movie) {
    return {
      'backdrop_path': movie.backdropPath,
      'genre_ids': movie.genreIds,
      'id': movie.id,
      'overview': movie.overview,
      'poster_path': movie.posterPath,
      'release_date': movie.releaseDate,
      'title': movie.title,
      'trailer_path': movie.trailerPath,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    return Movie(
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id']?.toInt() ?? 0,
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      trailerPath: map['trailer_path'],
    );
  }
}
