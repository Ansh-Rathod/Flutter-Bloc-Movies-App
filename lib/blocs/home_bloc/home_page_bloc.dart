import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/repo/repo.dart';
import 'package:http/http.dart' as http;
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial());
  final repo = GetData();
  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is HomePageEvent) {
      yield FetchHomeLoading();
      try {
        var url = Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/week?api_key=84ebd14770d7675041b532f1d88ce324');
        final response = await http.get(url);
        final data1 = json.decode(response.body);
        var list = data1['results'];
        var urltv = Uri.parse(
            'https://api.themoviedb.org/3/trending/tv/week?api_key=84ebd14770d7675041b532f1d88ce324');
        final responsetv = await http.get(urltv);
        final datatv = json.decode(responsetv.body);
        var listtv = datatv['results'];
        var urlPopular = Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=84ebd14770d7675041b532f1d88ce324');
        final responsePop = await http.get(urlPopular);
        final datapop = json.decode(responsePop.body);
        var listPop = datapop['results'];
        var urlPopulartv = Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=84ebd14770d7675041b532f1d88ce324');
        final responsePoptv = await http.get(urlPopulartv);
        final datapoptv = json.decode(responsePoptv.body);
        var listPoptv = datapoptv['results'];

        final data = await repo.getData();
        yield FetchHomeSucess(
          trending: list,
          marvel: data.marvel,
          company: data.company,
          tv: listtv,
          category1: data.catergory1,
          category2: data.catergory2,
          category3: data.catergory3,
          category4: data.catergory4,
          category5: data.catergory5,
          category6: data.catergory6,
          category7: data.catergory7,
          tvcategory1: listPop,
          tvcategory2: listPoptv,
        );
      } catch (e) {
        yield FetchHomeError();
      }
    }
  }
}
