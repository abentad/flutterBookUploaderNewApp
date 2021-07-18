import 'package:books_uploader_app/controllers/requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DisplayBooks extends StatelessWidget {
  final int selectedPurchaserIndex;
  DisplayBooks(this.selectedPurchaserIndex);

  final RequestsController _requestsController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(10),
            height: 200,
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
                        image: NetworkImage(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].posterImage),
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
                        Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].title),
                        Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].author),
                        Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].category),
                        Text(DateFormat('yMMMEd')
                            .format(DateTime.parse(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].postDate))
                            .toString()
                            .trim()),
                        Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].rating),
                        Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks[index].price),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
