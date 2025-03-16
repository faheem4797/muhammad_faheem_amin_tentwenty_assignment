part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  const MoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];

  Map<String, dynamic> toJson() {
    return {'movies': movies.map((movie) => MovieMapper.toMap(movie)).toList()};
  }

  factory MoviesLoaded.fromJson(Map<String, dynamic> json) {
    final moviesList =
        (json['movies'] as List)
            .map(
              (movieMap) =>
                  MovieMapper.fromMap(movieMap as Map<String, dynamic>),
            )
            .toList();
    return MoviesLoaded(movies: moviesList);
  }
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
