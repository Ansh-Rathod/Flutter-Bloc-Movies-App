part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoState {}

class MovieInfoInitial extends MovieInfoState {}

class MovieInfoLoading extends MovieInfoState {}

class MovieInfoError extends MovieInfoState {}

class MovieInfosuccess extends MovieInfoState {
  final dynamic tmdb;
  final dynamic omdb;
  final dynamic similar;
  final dynamic images;
  final dynamic videos;
  final List<dynamic> providers;

  MovieInfosuccess(
    this.tmdb,
    this.omdb,
    this.similar,
    this.images,
    this.videos,
    this.providers,
  );
}
