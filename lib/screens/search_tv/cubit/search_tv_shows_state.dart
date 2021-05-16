part of 'search_tv_shows_cubit.dart';

enum TvStatus { loading, success, error, initial, notFound }

class SearchTvShowsState extends Equatable {
  final TvStatus status;
  final String error;
  final List movies;
  SearchTvShowsState({this.status, this.movies, this.error});

  factory SearchTvShowsState.initial() {
    return SearchTvShowsState(
      movies: [],
      status: TvStatus.initial,
      error: '',
    );
  }
  @override
  List<Object> get props => [status, error, movies];
  @override
  bool get stringify => true;

  SearchTvShowsState copyWith({
    TvStatus status,
    String error,
    List movies,
  }) {
    return SearchTvShowsState(
      status: status ?? this.status,
      error: error ?? this.error,
      movies: movies ?? this.movies,
    );
  }
}
