part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class Search extends SearchMovieEvent {
  final String searchText;
  const Search(this.searchText);

  @override
  List<Object> get props => [searchText];
}

class ClearSearchField extends SearchMovieEvent {}
