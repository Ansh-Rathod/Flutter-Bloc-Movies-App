part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesSucess extends SearchMoviesState {
  final List popular;
  final List trending;
  final List upcoming;
  final List rated;
  SearchMoviesSucess({
    this.popular,
    this.trending,
    this.upcoming,
    this.rated,
  });
}

class SearchMoviesError extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}
