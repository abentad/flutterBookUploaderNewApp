import 'dart:convert';

import 'package:books_uploader_app/loading_screen.dart';
import 'package:books_uploader_app/models/book.dart';
import 'package:books_uploader_app/models/purchaser.dart';
import 'package:books_uploader_app/requests_screen.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
    print("Got Requesters");
    for (var i = 0; i < decodedData.length; i++) {
      _purchaserList.add(Purchaser.fromJson(decodedData[i]));
    }
    update();
  }

  void removePurchaser(String id) async {
    Get.to(() => LoadingScreen());
    Uri adminUrl = Uri.parse("https://bookapi.rentoch.com/admin/$id");
    try {
      await http.delete(
        adminUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      Get.snackbar("Error", e);
    }
    _purchaserList.clear();
    getRequesters();
    Get.offAll(() => RequestsScreen());
    Get.snackbar("purchaser removed", "purchaser has been successfully removed");
  }

  void call(String number) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(number);
    } catch (e) {
      print(e);
      Get.snackbar("Error", e);
    }
  }
}
