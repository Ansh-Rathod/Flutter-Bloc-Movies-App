import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
part 'search_state.dart';

class SearchMoviesCubit extends Cubit<SearchMovieState> {
  SearchMoviesCubit() : super(SearchMovieState.initial());

  void onSubmitted(String value) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      List movies = [];
      int lessthen;
      var comicCreaters = Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=84ebd14770d7675041b532f1d88ce324&query=$value&page=1&include_adult=true");

      final response = await http.get(comicCreaters);
      final data = json.decode(response.body);
      final comics = data['results'];
      if (data['total_pages'] > 10) {
        lessthen = 10;
        print(lessthen);
      } else {
        lessthen = data['total_pages'];
        print(lessthen);
      }
      print(lessthen);
      for (int i = 1; i <= lessthen; i++) {
        String index = i.toString();
        var moviesurl = Uri.parse(
            "https://api.themoviedb.org/3/search/movie?api_key=84ebd14770d7675041b532f1d88ce324&query=$value&page=$index&include_adult=true");

        final response1 = await http.get(moviesurl);
        final data1 = json.decode(response1.body);
        final allmovies = data1['results'];
        // print(allmovies);
        movies.addAll(allmovies);
      }
      if (movies.isEmpty) {
        emit(state.copyWith(
          status: MovieStatus.notFound,
        ));
      } else {
        emit(state.copyWith(status: MovieStatus.success, movies: movies));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: MovieStatus.error));
    }
  }
}
