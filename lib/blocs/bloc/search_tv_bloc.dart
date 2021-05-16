import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  SearchTvBloc() : super(SearchTvInitial());

  @override
  Stream<SearchTvState> mapEventToState(
    SearchTvEvent event,
  ) async* {
    if (event is SearchTvEvent) {
      try {
        yield SearchTvLoading();
        var url = Uri.parse(
            'https://api.themoviedb.org/3/trending/tv/day?api_key=84ebd14770d7675041b532f1d88ce324');
        final response = await http.get(url);
        final data1 = json.decode(response.body);
        var list = data1['results'];
        var urlPopular = Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=84ebd14770d7675041b532f1d88ce324');
        final responsePop = await http.get(urlPopular);
        final datapop = json.decode(responsePop.body);
        var listPop = datapop['results'];
        var urlrated = Uri.parse(
            'https://api.themoviedb.org/3/tv/top_rated?api_key=84ebd14770d7675041b532f1d88ce324');
        final responserated = await http.get(urlrated);
        final datarated = json.decode(responserated.body);
        var listrated = datarated['results'];

        yield SearchTvSucess(
          popular: listPop,
          trending: list,
          rated: listrated,
        );
      } catch (e) {
        print(e.toString());
        yield SearchTvError();
      }
    }
    // TODO: implement mapEventToState
  }
}
