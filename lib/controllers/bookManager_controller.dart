import 'dart:convert';

import 'package:books_uploader_app/loading_screen.dart';
import 'package:books_uploader_app/models/book.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookManagerController extends GetxController {
  List<Book> _booksList = [];

  List<Book> get bookList => _booksList;

  @override
  void onInit() {
    getBooksList();
    super.onInit();
  }

  void getBooksList() async {
    Uri booksUri = Uri.parse("https://bookapi.rentoch.com/books");
    var response = await http.get(booksUri);
    var decodedData = jsonDecode(response.body);
    for (var i = 0; i < decodedData.length; i++) {
      _booksList.add(Book.fromJson(decodedData[i]));
    }
    print("Got BooksList");
    update();
  }

  void removeBook(int index) async {
    Get.to(() => LoadingScreen());
    String id = _booksList[index].sId;
    Uri booksUri = Uri.parse("https://bookapi.rentoch.com/books/$id");
    try {
      await http.delete(booksUri);
    } catch (e) {
      print(e);
    }
    _booksList.clear();
    getBooksList();
    Get.back();
    Get.snackbar("Book removed successfully", "book has been removed successfully");
  }
}
