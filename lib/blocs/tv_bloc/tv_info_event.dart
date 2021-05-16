part of 'tv_info_bloc.dart';

@immutable
abstract class TvInfoEvent {}

class TvLoadContent extends TvInfoEvent {
  final int id;

  TvLoadContent(this.id);
}
