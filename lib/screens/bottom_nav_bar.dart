import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/bloc/search_tv_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:movies/blocs/home_bloc/home_page_bloc.dart';
import 'package:movies/blocs/search_bloc/search_movies_bloc.dart';
import 'package:movies/screens/Homepage.dart';
import 'package:movies/screens/search_page/serach.dart';
import 'package:movies/screens/search_tv/search.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => HomePageBloc()..add(HomePageContent()),
      child: Home(),
    ),
    BlocProvider(
      create: (context) => SearchMoviesBloc()..add(SearchLoadContent()),
      child: SearchPage(),
    ),
    BlocProvider(
      create: (context) => SearchTvBloc()..add(SearchTvLoadContent()),
      child: SearchPageTv(),
    ),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.home),
        activeColorPrimary: Colors.blue,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.search),
        activeColorPrimary: Colors.blue,
        title: ("Movies"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.tv),
        activeColorPrimary: Colors.blue,
        title: ("Tv Shows"),
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.local_activity),
      //   inactiveColorPrimary: Colors.grey,
      //   activeColorPrimary: Colors.red,
      //   title: ("ProfileScreen"),
      // ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
