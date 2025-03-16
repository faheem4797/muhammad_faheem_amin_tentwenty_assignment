part of 'search_movie_bloc.dart';

final class SearchMovieState extends Equatable {
  const SearchMovieState({
    this.searchText = '',
    this.allMovies = const [],
    this.searchedMovies = const [],
  });

  final String searchText;
  final List<Movie> allMovies;
  final List<Movie> searchedMovies;

  @override
  List<Object?> get props => [searchText, allMovies, searchedMovies];

  SearchMovieState copyWith({
    String? searchText,
    List<Movie>? allMovies,
    List<Movie>? searchedMovies,
  }) {
    return SearchMovieState(
      searchText: searchText ?? this.searchText,
      allMovies: allMovies ?? this.allMovies,
      searchedMovies: searchedMovies ?? this.searchedMovies,
    );
  }
}
