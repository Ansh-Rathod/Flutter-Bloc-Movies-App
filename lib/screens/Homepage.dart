import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/blocs/home_bloc/home_page_bloc.dart';
import 'package:movies/screens/widgets/company_carasouls.dart';
import 'package:movies/screens/widgets/movies_carausols.dart';
import 'package:movies/screens/widgets/treanding.dart';
import 'package:movies/screens/widgets/trending_tv.dart';
import 'package:movies/screens/widgets/tv_carausols.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TMDB",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is FetchHomeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchHomeError) {
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
                                  HomePageBloc()..add(HomePageContent()),
                              child: Home(),
                            ),
                          ));
                    },
                    child: Text("Try again"),
                  )
                ],
              ),
            );
          } else if (state is FetchHomeSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                header("This week's Trending Movies", () {}),
                SliverToBoxAdapter(
                    child: TrendingContainer(
                  listPaths: state.trending,
                )),
                header("Popular sci-fi/action movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category1,
                )),
                header("Classic Adventure/fantacy movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category2,
                )),
                header("This week's trending Tv Shows", () {}),
                SliverToBoxAdapter(
                    child: TrendingContainertv(
                  listPaths: state.tv,
                )),
                header("Popular Tv shows", () {}),
                SliverToBoxAdapter(
                    child: TvContainer(
                  listPaths: state.tvcategory2,
                )),
                header("Populer Marvel Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.marvel,
                )),
                header("Similar to \"Titanic\" ", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category3,
                )),
                header("Popular Movies", () {}),
                SliverToBoxAdapter(
                    child: TrendingContainer(
                  listPaths: state.tvcategory1,
                )),
                header("Good Drama Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category4,
                )),
                header("Popular Musical/Drama movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category5,
                )),
                header("Populer Crime and action movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category6,
                )),
                header("Historical based on Novel movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainer(
                  listPaths: state.category7,
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
