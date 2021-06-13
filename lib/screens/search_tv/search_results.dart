import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/blocs/movie_bloc/movie_info_bloc.dart';
import 'package:movies/blocs/tv_bloc/tv_info_bloc.dart';
import 'package:movies/screens/movieinfo.dart';
import 'package:movies/screens/search_page/cubit/search_cubit.dart';
import 'package:movies/screens/search_tv/cubit/search_tv_shows_cubit.dart';
import 'package:movies/screens/tv_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InitalTv extends StatelessWidget {
  final String value;

  InitalTv(this.value);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchTvShowsCubit>(context).onSubmitted(value);
    return BlocBuilder<SearchTvShowsCubit, SearchTvShowsState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Shows",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: state.status == TvStatus.loading
            ? Center(
                child: SpinKitSquareCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              )
            : state.status == TvStatus.success
                ? Gridmovies(movies: state.movies)
                : state.status == TvStatus.error
                    ? Center(child: Text("Shows Not found"))
                    : state.movies == null
                        ? Center(
                            child: Text(
                            "404\Shows Not found.",
                            textAlign: TextAlign.center,
                          ))
                        : Container(),
      );
    });
  }
}

class Gridmovies extends StatelessWidget {
  final List movies;

  const Gridmovies({Key key, this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
          ),
          itemCount: movies.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        TvInfoBloc()..add(TvLoadContent(movies[i]['id'])),
                    child: TvInfo(),
                  ),
                ));
              },
              child: Container(
                foregroundDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.grey,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          movies[i]['poster_path'] == null
                              ? "https://images.pexels.com/photos/3747159/pexels-photo-3747159.jpeg?cs=srgb&dl=pexels-polina-zimmerman-3747159.jpg&fm=jpg"
                              : "https://image.tmdb.org/t/p/original" +
                                  movies[i]['poster_path'],
                        ))),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    movies[i]['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
