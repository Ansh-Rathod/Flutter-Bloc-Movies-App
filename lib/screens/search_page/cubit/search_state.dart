part of 'search_cubit.dart';

enum MovieStatus { loading, success, error, initial, notFound }

class SearchMovieState extends Equatable {
  final MovieStatus status;
  final String error;
  final List movies;
  SearchMovieState({this.status, this.movies, this.error});

  factory SearchMovieState.initial() {
    return SearchMovieState(
      movies: [],
      status: MovieStatus.initial,
      error: '',
    );
  }
  @override
  List<Object> get props => [status, error, movies];
  @override
  bool get stringify => true;

  SearchMovieState copyWith({
    MovieStatus status,
    String error,
    List movies,
  }) {
    return SearchMovieState(
      status: status ?? this.status,
      error: error ?? this.error,
      movies: movies ?? this.movies,
    );
  }
}
