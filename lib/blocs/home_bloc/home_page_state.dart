part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class FetchHomeSucess extends HomePageState {
  final List trending;
  final List marvel;
  final List company;
  final List tv;
  final List category1;
  final List category2;
  final List category3;

  final List category4;
  final List category5;
  final List category6;
  final List category7;
  final List tvcategory1;
  final List tvcategory2;
  final List tvcategory3;
  final List tvcategory4;
  FetchHomeSucess({
    this.trending,
    this.marvel,
    this.company,
    this.tv,
    this.category1,
    this.category2,
    this.category3,
    this.category4,
    this.category5,
    this.category6,
    this.category7,
    this.tvcategory1,
    this.tvcategory2,
    this.tvcategory3,
    this.tvcategory4,
  });
}

class FetchHomeError extends HomePageState {}

class FetchHomeLoading extends HomePageState {}
