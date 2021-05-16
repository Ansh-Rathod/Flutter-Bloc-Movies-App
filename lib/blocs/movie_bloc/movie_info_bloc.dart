import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/repo/repo.dart';
import 'package:http/http.dart' as http;

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  MovieInfoBloc() : super(MovieInfoInitial());
  final repo = GetData();
  @override
  Stream<MovieInfoState> mapEventToState(
    MovieInfoEvent event,
  ) async* {
    if (event is MovieLoadContent) {
      yield MovieInfoLoading();
      try {
        List dataimages = [];
        var url = Uri.parse(
            'https://api.themoviedb.org/3/movie/${event.id}?api_key=84ebd14770d7675041b532f1d88ce324&adult=true');
        final response = await http.get(url);
        final data1 = json.decode(response.body);
        final imdbId = data1['imdb_id'];
        var omdburl =
            Uri.parse('http://www.omdbapi.com/?i=$imdbId&apikey=114165f2');
        final response2 = await http.get(omdburl);
        final data2 = json.decode(response2.body);
        var urlSimlar = Uri.parse(
            'https://api.themoviedb.org/3/movie/${event.id}/similar?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response3 = await http.get(urlSimlar);
        final data3 = json.decode(response3.body);
        var urlImages = Uri.parse(
            'https://api.themoviedb.org/3/movie/${event.id}/watch/providers?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response4 = await http.get(urlImages);
        final data4 = json.decode(response4.body);
        var urlVideos = Uri.parse(
            'https://api.themoviedb.org/3/movie/${event.id}/videos?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US');
        final response5 = await http.get(urlVideos);
        final data5 = json.decode(response5.body);
        var urlNew = Uri.parse(
            'https://api.themoviedb.org/3/movie/${event.id}/images?api_key=84ebd14770d7675041b532f1d88ce324&language=en-US&include_image_language=en');
        final response6 = await http.get(urlNew);
        final data6 = json.decode(response6.body);
        dataimages.addAll(data6['backdrops']);
        dataimages.addAll(data6['posters']);

        yield MovieInfosuccess(
          data1,
          data2,
          data3,
          data4,
          data5,
          dataimages,
        );
      } catch (e) {
        print(e.toString());
        yield MovieInfoError();
      }
    }
  }
}
