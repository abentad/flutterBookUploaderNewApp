import 'package:books_uploader_app/controllers/requests_controller.dart';
import 'package:books_uploader_app/purchaserDetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RequestsScreen extends StatelessWidget {
  final RequestsController _requestsController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Purchasers", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      // ),
      body: SafeArea(
        child: GetBuilder<RequestsController>(
          builder: (controller) => Container(
            child: ListView.builder(
              itemCount: _requestsController.purchaserList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => Get.to(() => PurchaserDetailScreen(index)),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Name"),
                                  Text("Phone Number"),
                                  Text("City"),
                                  Text("Country"),
                                  Text("Purchased Date"),
                                  Text("Number of Books"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(_requestsController.purchaserList[index].name),
                                  Text(_requestsController.purchaserList[index].phoneNumber),
                                  Text(_requestsController.purchaserList[index].address.city),
                                  Text(_requestsController.purchaserList[index].address.country),
                                  Text(DateFormat('yMMMEd').format(DateTime.parse(_requestsController.purchaserList[index].purchasedDate)).toString().trim()),
                                  Text(_requestsController.purchaserList[index].purchasedBooks.length.toString() + " books"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
