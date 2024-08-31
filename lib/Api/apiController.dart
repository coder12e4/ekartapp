import 'dart:convert';
import 'package:ekartapp/core/constants/constants.dart';
import 'package:http/http.dart' as http;

class ApiController {
  //final String baseUrl;

  ApiController();

  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(Uri.parse(constants.baseUrl + endpoint));
    try {
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }
}
