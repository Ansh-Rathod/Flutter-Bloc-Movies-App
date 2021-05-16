import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/models/models.dart';

class GetData {
  Future<TrendingList> getData() async {
    final doc = await FirebaseFirestore.instance
        .collection("HomeScreen")
        .doc('FullHomeScreen')
        .get();
    return TrendingList.fromDocument(doc);
  }

  Future<dynamic> getMovieDataById(String id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=84ebd14770d7675041b532f1d88ce324');
    final response = await http.get(url);
    final data1 = json.decode(response.body);
    final imdb_id = data1['imdb_id'];
    return data1;
  }

  Future<dynamic> getMoviesByIdOmdb(String id) async {
    var omdburl = Uri.parse('http://www.omdbapi.com/?i=$id&apikey=114165f2');
    final response2 = await http.get(omdburl);
    final data2 = json.decode(response2.body);
    return data2;
  }
}
