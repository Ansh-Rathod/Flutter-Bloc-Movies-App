import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'tv_info_event.dart';
part 'tv_info_state.dart';

class TvInfoBloc extends Bloc<TvInfoEvent, TvInfoState> {
  TvInfoBloc() : super(TvInfoInitial());

  @override
  Stream<TvInfoState> mapEventToState(
    TvInfoEvent event,
  ) async* {
    if (event is TvLoadContent) {
      yield TvInfoLoading();

      try {
        List dataimages = [];
        var url = Uri.parse(
            'https://api.themoviedb.org/3/tv/${event.id}?api_key=84ebd14770d7675041b532f1d88ce324');
        final response = await http.get(url);
        final data1 = json.decode(response.body);

        var urlSimlar = Uri.parse(
            'https://api.themoviedb.org/3/tv/${event.id}/similar?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response3 = await http.get(urlSimlar);
        final data3 = json.decode(response3.body);
        var urlImages = Uri.parse(
            'https://api.themoviedb.org/3/tv/${event.id}/watch/providers?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response4 = await http.get(urlImages);
        final data4 = json.decode(response4.body);
        var urlVideos = Uri.parse(
            'https://api.themoviedb.org/3/tv/${event.id}/videos?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response5 = await http.get(urlVideos);
        final data5 = json.decode(response5.body);
        var urlNew = Uri.parse(
            'https://api.themoviedb.org/3/tv/${event.id}/images?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US&include_image_language=en');
        final response6 = await http.get(urlNew);
        final data6 = json.decode(response6.body);
        dataimages.addAll(data6['backdrops']);
        dataimages.addAll(data6['posters']);
        yield TvInfosuccess(data1, data3, data4, data5, dataimages);
      } catch (e) {
        yield TvInfoError();
      }
    }
  }
}
