import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/domain/entities/movie.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc({required SearchMovieState initialState})
    : super(initialState) {
    on<Search>(_search);
    on<ClearSearchField>(_clearSearchField);
  }

  FutureOr<void> _search(Search event, Emitter<SearchMovieState> emit) async {
    if (event.searchText.isEmpty) {
      emit(state.copyWith(searchedMovies: [], searchText: event.searchText));

      return;
    }

    final results =
        state.allMovies
            .where(
              (movie) => movie.title.toLowerCase().contains(
                event.searchText.toLowerCase(),
              ),
            )
            .toList();

    emit(state.copyWith(searchedMovies: results, searchText: event.searchText));
  }

  FutureOr<void> _clearSearchField(
    ClearSearchField event,
    Emitter<SearchMovieState> emit,
  ) {
    emit(state.copyWith(searchText: '', searchedMovies: []));
  }
}
