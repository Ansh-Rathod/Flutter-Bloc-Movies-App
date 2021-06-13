import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:movies/blocs/movie_bloc/movie_info_bloc.dart';
import 'package:movies/screens/widgets/company_carasouls.dart';
import 'package:movies/screens/widgets/image_grid.dart';
import 'package:movies/screens/widgets/image_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movies/screens/widgets/movies_carausols.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieInfoBloc, MovieInfoState>(
        builder: (context, state) {
          if (state is MovieInfoLoading) {
            return Center(
              child: SpinKitSquareCircle(
                color: Colors.orangeAccent,
                size: 50.0,
              ),
            );
          } else if (state is MovieInfosuccess) {
            return Scaffold(
                body: Container(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.black),
                    title: Text("Information About Movie",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    actions: [
                      if (state.videos.containsKey('results'))
                        if (state.videos['results'].isNotEmpty)
                          if (state.videos['results'][0]['site'] == 'YouTube')
                            IconButton(
                              icon: Icon(Icons.open_in_browser,
                                  color: Colors.black),
                              onPressed: () {
                                launch(
                                    "https://youtu.be/${state.videos['results'][0]['key']}");
                              },
                            ),
                    ],
                    pinned: true,
                  ),
                  if (state.videos.containsKey('results'))
                    if (state.videos['results'].isNotEmpty)
                      if (state.videos['results'][0]['site'] == 'YouTube')
                        SliverToBoxAdapter(
                            child: RotatedBox(
                          quarterTurns: 4,
                          child: HtmlWidget(
                              '<iframe width="${MediaQuery.of(context).size.width}" height="260" src="https://www.youtube.com/embed/${state.videos['results'][0]['key']}"  allowfullscreen="allowfullscreen" mozallowfullscreen="mozallowfullscreen" msallowfullscreen="msallowfullscreen" oallowfullscreen="oallowfullscreen" webkitallowfullscreen="webkitallowfullscreen"></iframe>',
                              webView: true),
                        ))
                      else
                        SliverToBoxAdapter(
                          child: Container(
                            height: 240,
                            child: Image.network(
                                state.tmdb['backdrop_path'] == null
                                    ? "https://images.pexels.com/photos/3747132/pexels-photo-3747132.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                    : "https://image.tmdb.org/t/p/w500" +
                                        state.tmdb['backdrop_path'],
                                fit: BoxFit.cover),
                          ),
                        )
                    else
                      SliverToBoxAdapter(
                        child: Container(
                          height: 240,
                          child: Image.network(
                              state.tmdb['backdrop_path'] == null
                                  ? "https://images.pexels.com/photos/3747132/pexels-photo-3747132.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                  : "https://image.tmdb.org/t/p/w500" +
                                      state.tmdb['backdrop_path'],
                              fit: BoxFit.cover),
                        ),
                      )
                  else
                    SliverToBoxAdapter(
                      child: Container(
                        height: 240,
                        child: Image.network(
                            state.tmdb['backdrop_path'] == null
                                ? "https://images.pexels.com/photos/3747132/pexels-photo-3747132.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                : "https://image.tmdb.org/t/p/w500" +
                                    state.tmdb['backdrop_path'],
                            fit: BoxFit.cover),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "${state.tmdb['title']}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    state.omdb['Poster'],
                                    maxWidth: 130,
                                    maxHeight: 200,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * .6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Plot:\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(state.omdb['Plot'] == ""
                                      ? "No overview avalable for this movie."
                                      : state.omdb['Plot']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.providers.isNotEmpty)
                    SliverToBoxAdapter(
                      child: information("Images", "", true, context),
                    ),
                  if (state.providers.isNotEmpty)
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      sliver: SliverToBoxAdapter(
                        child: PhotoGrid(
                          imageUrls: state.providers,
                          onImageClicked: (i) {
                            pushNewScreen(
                              context,
                              screen: ViewPhotos(
                                imageIndex: i,
                                imageList: state.providers,
                              ),
                              withNavBar: false, // OPTIONAL VALUE. True b
                            );
                          },
                          onExpandClicked: () {
                            pushNewScreen(
                              context,
                              screen: ViewPhotos(
                                imageIndex: 3,
                                imageList: state.providers,
                              ),
                              withNavBar: false, // OPTIONAL VALUE. True by
                            );
                          },
                          maxImages: 4,
                        ),
                      ),
                    ),
                  if (state.images['results'].containsKey('US'))
                    if (state.images['results']['US'].containsKey('buy'))
                      SliverToBoxAdapter(
                        child: information("Buy on", "", true, context),
                      ),
                  if (state.images['results'].containsKey('US'))
                    if (state.images['results']['US'].containsKey('buy'))
                      SliverToBoxAdapter(
                        child: CompanyConatainer(
                          listPaths: state.images['results']['US']['buy'],
                          url: state.images['results']['US']['link'],
                        ),
                      ),
                  if (state.images['results'].containsKey('US'))
                    if (state.images['results']['US'].containsKey('flatrate'))
                      SliverToBoxAdapter(
                        child: information("Stream on", "", true, context),
                      ),
                  if (state.images['results'].containsKey('US'))
                    if (state.images['results']['US'].containsKey('flatrate'))
                      SliverToBoxAdapter(
                        child: CompanyConatainer(
                          listPaths: state.images['results']['US']['flatrate'],
                          url: state.images['results']['US']['link'],
                        ),
                      ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              information("Runtime", state.omdb['Runtime'],
                                  true, context),
                              information(
                                  "imdb rating",
                                  state.tmdb['vote_average'].toString(),
                                  false,
                                  context),
                              information(
                                  "Genre", state.omdb['Genre'], true, context),
                              information("Writer", state.omdb['Writer'], false,
                                  context),
                              information("Actors", state.omdb['Actors'], true,
                                  context),
                              information("Awards", state.omdb['Awards'], false,
                                  context),
                              information("Director", state.omdb['Director'],
                                  true, context),
                              information("Released", state.omdb['Released'],
                                  false, context),
                              information(
                                  "Rated", state.omdb['Rated'], true, context),
                              if (state.similar.containsKey('results'))
                                if (state.similar['results'].isNotEmpty)
                                  information(
                                      "Similar Movies", "", false, context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.similar.containsKey('results'))
                    if (state.similar['results'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: MoviesContainerSimilar(
                          listPaths: state.similar['results'],
                        ),
                      ),
                ],
              ),
            ));
          } else if (state is MovieInfoError) {
            return Center(child: Text("Errror"));
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  Widget information(
      String type, String info, bool isGrey, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: isGrey ? Colors.grey[300] : Colors.transparent,
      padding: EdgeInsets.all(20),
      child: RichText(
          text: TextSpan(style: TextStyle(color: Colors.black), children: [
        TextSpan(
          text: "$type",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (info != "")
          TextSpan(
            text: "\n$info",
          ),
      ])),
    );
  }
}
// YoutubePlayerIFrame(
                          //   controller: YoutubePlayerController(
                          //     initialVideoId: state.videos['results'][0]['key'],
                          //     params: YoutubePlayerParams(
                          //       showControls: true,
                          //       mute: true,
                          //       autoPlay: false,
                          //       showFullscreenButton: true,
                          //     ),
                          //   ),
                          //   aspectRatio: 16 / 9,
                          // ),