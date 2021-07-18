import 'package:books_uploader_app/controllers/bookManager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RemoveBookScreen extends StatelessWidget {
  final BookManagerController _bookManagerController = Get.find<BookManagerController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<BookManagerController>(
          builder: (controller) => Container(
            child: ListView.builder(
              itemCount: controller.bookList.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(10),
                height: 230,
                decoration: BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            // image: NetworkImage(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].posterImage),
                            image: NetworkImage(controller.bookList[index].posterImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.bookList[index].title),
                            Text(controller.bookList[index].author),
                            Text(controller.bookList[index].category),
                            Text(DateFormat('yMMMEd').format(DateTime.parse(controller.bookList[index].postDate))),
                            Text(controller.bookList[index].rating),
                            Text(controller.bookList[index].price),
                            // SizedBox(height: size.height * 0.04),
                            Spacer(),
                            MaterialButton(
                              onPressed: () {
                                controller.removeBook(index);
                              },
                              minWidth: double.infinity,
                              height: 50.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                children: [
                                  Icon(Icons.book, color: Colors.white),
                                  SizedBox(width: size.width * 0.05),
                                  Text("Remove Book", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                                ],
                              ),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
