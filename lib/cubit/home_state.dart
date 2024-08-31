part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoding extends HomeState {}

final class HomeSucess extends HomeState {
  List<String> categoris;
  List<ProductModel> productList;
  int intex;
  HomeSucess(this.categoris, this.productList, this.intex);
}

final class HomeFail extends HomeState {
  String error;

  HomeFail(this.error);
}
