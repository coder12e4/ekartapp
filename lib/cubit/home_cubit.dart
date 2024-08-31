import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Api/Models/ProductModel.dart';
import '../Api/Repositories/HomeRepository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());
  Future<void> getCategories(int index) async {
    emit(HomeLoding());
    try {
      var data = await homeRepository.getCategories();
      var productList = await homeRepository.getProducts(data[index]);
      emit(HomeSucess(data, productList, index));
    } catch (e) {
      print(e);
      emit(HomeFail(e.toString()));
    }
  }
}
