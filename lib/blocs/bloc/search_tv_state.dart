part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTvState {}

class SearchTvInitial extends SearchTvState {}

class SearchTvSucess extends SearchTvState {
  final List popular;
  final List trending;
  final List upcoming;
  final List rated;
  SearchTvSucess({
    this.popular,
    this.trending,
    this.upcoming,
    this.rated,
  });
}

class SearchTvError extends SearchTvState {}

class SearchTvLoading extends SearchTvState {}
