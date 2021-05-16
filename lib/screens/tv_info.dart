import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/movie_bloc/movie_info_bloc.dart';
import 'package:movies/blocs/tv_bloc/tv_info_bloc.dart';
import 'package:movies/screens/widgets/company_carasouls.dart';
import 'package:movies/screens/widgets/image_grid.dart';
import 'package:movies/screens/widgets/image_view.dart';

import 'package:movies/screens/widgets/movies_carausols.dart';
import 'package:movies/screens/widgets/show_text.dart';
import 'package:movies/screens/widgets/tv_carausols.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TvInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvInfoBloc, TvInfoState>(
        builder: (context, state) {
          if (state is TvInfoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvInfosuccess) {
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
                    title: Text(
                      "Information About Show",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
                            )
                    ],
                    pinned: true,
                  ),
                  if (state.videos.containsKey('results'))
                    if (state.videos['results'].isNotEmpty)
                      if (state.videos['results'][0]['site'] == 'YouTube')
                        SliverToBoxAdapter(
                            child: RotatedBox(
                          quarterTurns: 4,
                          child: YoutubePlayerIFrame(
                            controller: YoutubePlayerController(
                              initialVideoId: state.videos['results'][0]['key'],
                              params: YoutubePlayerParams(
                                playlist: [
                                  ...state.videos['results']
                                      .map((vid) => vid['key'])
                                      .toList()
                                ],
                                showControls: true,
                                mute: true,
                                autoPlay: false,
                                showFullscreenButton: true,
                              ),
                            ),
                            aspectRatio: 16 / 9,
                          ),
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
                        "${state.tmdb['name']}",
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
                                    "https://image.tmdb.org/t/p/w500" +
                                        state.tmdb['poster_path'],
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
                                  state.tmdb['overview'] == ""
                                      ? Text("No Overview found for this Show.")
                                      : ExpandableText(
                                          state.tmdb['overview'],
                                          trimLines: 3,
                                        ),
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
                          imageUrls: state.images,
                          onImageClicked: (i) {
                            pushNewScreen(
                              context,
                              screen: ViewPhotos(
                                imageIndex: i,
                                imageList: state.images,
                              ),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by defaul
                            );
                          },
                          onExpandClicked: () {
                            pushNewScreen(
                              context,
                              screen: ViewPhotos(
                                imageIndex: 3,
                                imageList: state.images,
                              ),
                              withNavBar: false, // OPTIONAL VALUE. True by
                            );
                          },
                          maxImages: 4,
                        ),
                      ),
                    ),
                  if (state.providers['results'].containsKey('US'))
                    if (state.providers['results']['US'].containsKey('buy'))
                      SliverToBoxAdapter(
                        child: information("Buy on", "", true, context),
                      ),
                  if (state.providers['results'].containsKey('US'))
                    if (state.providers['results']['US'].containsKey('buy'))
                      SliverToBoxAdapter(
                        child: CompanyConatainer(
                          listPaths: state.providers['results']['US']['buy'],
                          url: state.providers['results']['US']['link'],
                        ),
                      ),
                  if (state.providers['results'].containsKey('US'))
                    if (state.providers['results']['US']
                        .containsKey('flatrate'))
                      SliverToBoxAdapter(
                        child: information("Stream on", "", true, context),
                      ),
                  if (state.providers['results'].containsKey('US'))
                    if (state.providers['results']['US']
                        .containsKey('flatrate'))
                      SliverToBoxAdapter(
                        child: CompanyConatainer(
                          listPaths: state.providers['results']['US']
                              ['flatrate'],
                          url: state.providers['results']['US']['link'],
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
                              information(
                                  "Number of episodes",
                                  state.tmdb['number_of_episodes'].toString(),
                                  true,
                                  context),
                              information(
                                  "number of seasons",
                                  state.tmdb['number_of_seasons'].toString(),
                                  false,
                                  context),
                              information("tagline", state.tmdb['tagline'],
                                  true, context),
                              information("status", state.tmdb['status'], false,
                                  context),
                              information(
                                  "Rating",
                                  state.tmdb['vote_average'].toString(),
                                  true,
                                  context),
                              information("Seasons", "", false, context),
                              ...state.tmdb['seasons']
                                  .map((data) => seasons(data, context))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.similar.containsKey('results'))
                    if (state.similar['results'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text("Similar Shows",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                  if (state.similar.containsKey('results'))
                    if (state.similar['results'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: TvContainerSimilar(
                          listPaths: state.similar['results'],
                        ),
                      ),
                ],
              ),
            ));
          } else if (state is TvInfoError) {
            return Center(child: Text("Errror"));
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
          text: "$type:\n",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: "$info",
        ),
      ])),
    );
  }

  Widget seasons(data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  data['poster_path'] == null
                      ? "https://images.pexels.com/photos/3747159/pexels-photo-3747159.jpeg?cs=srgb&dl=pexels-polina-zimmerman-3747159.jpg&fm=jpg"
                      : "https://image.tmdb.org/t/p/w500${data['poster_path']}",
                  maxWidth: 130,
                  maxHeight: 200,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'] + "\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                data['overview'] == "" || data['overview'] == null
                    ? Text("No overview available for this season.")
                    // : Text(data['overview'])
                    : ExpandableText(
                        data['overview'],
                        trimLines: 3,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
