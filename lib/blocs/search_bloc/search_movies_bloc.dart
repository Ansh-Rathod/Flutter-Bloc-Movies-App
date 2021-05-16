import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMoviesBloc() : super(SearchMoviesInitial());

  @override
  Stream<SearchMoviesState> mapEventToState(
    SearchMoviesEvent event,
  ) async* {
    if (event is SearchMoviesEvent) {
      try {
        yield SearchMoviesLoading();
        var url = Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/day?api_key=84ebd14770d7675041b532f1d88ce324');
        final response = await http.get(url);
        final data1 = json.decode(response.body);
        var list = data1['results'];
        var urlPopular = Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=84ebd14770d7675041b532f1d88ce324');
        final responsePop = await http.get(urlPopular);
        final datapop = json.decode(responsePop.body);
        var listPop = datapop['results'];
        var urlrated = Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=84ebd14770d7675041b532f1d88ce324');
        final responserated = await http.get(urlrated);
        final datarated = json.decode(responserated.body);
        var listrated = datarated['results'];
        var urlup = Uri.parse(
            'https://api.themoviedb.org/3/movie/upcoming?api_key=84ebd14770d7675041b532f1d88ce324');
        final responseup = await http.get(urlup);
        final dataup = json.decode(responseup.body);
        var listup = dataup['results'];
        yield SearchMoviesSucess(
          popular: listPop,
          trending: list,
          rated: listrated,
          upcoming: listup,
        );
      } catch (e) {
        print(e.toString());
        yield SearchMoviesError();
      }
    }
    // TODO: implement mapEventToState
  }
}
