import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/blocs/home_bloc/home_page_bloc.dart';
import 'package:movies/blocs/search_bloc/search_movies_bloc.dart';
import 'package:movies/screens/search_page/cubit/search_cubit.dart';
import 'package:movies/screens/search_page/search_results.dart';
import 'package:movies/screens/widgets/company_carasouls.dart';
import 'package:movies/screens/widgets/movies_carausols.dart';
import 'package:movies/screens/widgets/treanding.dart';
import 'package:movies/screens/widgets/trending_tv.dart';
import 'package:movies/screens/widgets/tv_carausols.dart';

class SearchPage extends StatelessWidget {
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
      body: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchMoviesError) {
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
                                  SearchMoviesBloc()..add(SearchLoadContent()),
                              child: SearchPage(),
                            ),
                          ));
                    },
                    child: Text("Try again"),
                  )
                ],
              ),
            );
          } else if (state is SearchMoviesSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search Movies..",
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
                                  create: (context) => SearchMoviesCubit(),
                                  child: Initalmovies(value),
                                )));
                      },
                    ),
                  ),
                ),
                header("This week's Trending Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.trending,
                )),
                header("Top rated Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.rated,
                )),
                header("Popular Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.popular,
                )),
                header("Upcoming movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.upcoming,
                )),
              ],
            );
          }
          return Container();
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
