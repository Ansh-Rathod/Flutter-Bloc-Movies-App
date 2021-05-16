part of 'tv_info_bloc.dart';

@immutable
abstract class TvInfoState {}

class TvInfoInitial extends TvInfoState {}

class TvInfoLoading extends TvInfoState {}

class TvInfoError extends TvInfoState {}

class TvInfosuccess extends TvInfoState {
  final dynamic tmdb;
  final dynamic similar;
  final dynamic providers;
  final dynamic videos;
  final dynamic images;

  TvInfosuccess(
    this.tmdb,
    this.similar,
    this.providers,
    this.videos,
    this.images,
  );
}
