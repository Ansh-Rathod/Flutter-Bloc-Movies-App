import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/blocs/bloc/search_tv_bloc.dart';
import 'package:movies/screens/search_tv/cubit/search_tv_shows_cubit.dart';
import 'package:movies/screens/search_tv/search_results.dart';
import 'package:movies/screens/widgets/tv_carausols.dart';

class SearchPageTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TMDB Show",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: BlocBuilder<SearchTvBloc, SearchTvState>(
        builder: (context, state) {
          if (state is SearchTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchTvError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something wents worng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Have another try?",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    textColor: Colors.white,
                    elevation: 0,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  SearchTvBloc()..add(SearchTvLoadContent()),
                              child: SearchPageTv(),
                            ),
                          ));
                    },
                    child: Text("Try again"),
                  )
                ],
              ),
            );
          } else if (state is SearchTvSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search Tv Shows..",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 5,
                                style: BorderStyle.solid,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15))),
                      onSubmitted: (value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => SearchTvShowsCubit(),
                                  child: InitalTv(value),
                                )));
                      },
                    ),
                  ),
                ),
                header("This week's Trending shows", () {}),
                SliverToBoxAdapter(
                    child: TvContainerSimilar(
                  listPaths: state.trending,
                )),
                header("Top rated shows", () {}),
                SliverToBoxAdapter(
                    child: TvContainerSimilar(
                  listPaths: state.rated,
                )),
                header("Popular shows", () {}),
                SliverToBoxAdapter(
                    child: TvContainerSimilar(
                  listPaths: state.popular,
                )),
              ],
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  SliverAppBar header(String info, Function ontap) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text(info,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
