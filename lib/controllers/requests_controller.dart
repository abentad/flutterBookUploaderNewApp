import 'dart:convert';

import 'package:books_uploader_app/models/purchaser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestsController extends GetxController {
  List<Purchaser> _purchaserList = [];
  List<Purchaser> get purchaserList => _purchaserList;
  //

  @override
  void onInit() {
    getRequesters();
    super.onInit();
  }

  void getRequesters() async {
    Uri adminUrl = Uri.parse("https://bookapi.rentoch.com/admin");
    var response = await http.get(adminUrl);
    var decodedData = jsonDecode(response.body);
    print("printing");
    print(decodedData);
    for (var i = 0; i < decodedData.length; i++) {
      _purchaserList.add(Purchaser.fromJson(decodedData[i]));
    }
    update();
  }
}
