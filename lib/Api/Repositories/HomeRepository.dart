import 'package:ekartapp/Api/apiController.dart';
import 'package:ekartapp/core/constants/constants.dart';

import '../Models/ProductModel.dart';

abstract class HomeReop {
  Future<List<String>> getCategories();
  Future<List<ProductModel>> getProducts(String categoryName);
}

class HomeRepository extends HomeReop {
  ApiController apiController = ApiController();

  @override
  Future<List<String>> getCategories() async {
    try {
      var data = await apiController.getData(constants.getCategoris);
      List<String> categoris = List<String>.from(data);
      return categoris;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<ProductModel>> getProducts(String categoryName) async {
    try {
      List<dynamic> jsonResponse =
          await apiController.getData("category" + "/${categoryName}");

      List<ProductModel> products = jsonResponse
          .map((productJson) =>
              ProductModel.fromJson(productJson as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
