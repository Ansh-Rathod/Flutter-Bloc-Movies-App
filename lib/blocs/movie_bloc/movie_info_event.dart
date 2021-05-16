part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoEvent {}

class MovieLoadContent extends MovieInfoEvent {
  final int id;

  MovieLoadContent(this.id);
}
