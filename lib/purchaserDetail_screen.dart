import 'package:books_uploader_app/booksDisplay_screen.dart';
import 'package:books_uploader_app/controllers/requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaserDetailScreen extends StatelessWidget {
  final int selectedPurchaserIndex;
  final RequestsController _requestsController = Get.find<RequestsController>();

  PurchaserDetailScreen(this.selectedPurchaserIndex);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            // height: size.height * 0.5,
            width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: size.height * 0.5,
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
                              Text("poiName"),
                              Text("poiAddrStreet"),
                              Text("staddress"),
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
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].name.capitalize),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].phoneNumber),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].address.city),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].address.country),
                              Text(DateFormat('yMMMEd').format(DateTime.parse(_requestsController.purchaserList[selectedPurchaserIndex].purchasedDate)).toString().trim()),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].purchasedBooks.length.toString() + " books"),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].address.poiName, style: TextStyle(fontSize: 12.0)),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].address.poiAddrStreet, style: TextStyle(fontSize: 12.0)),
                              Text(_requestsController.purchaserList[selectedPurchaserIndex].address.staddress),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                MaterialButton(
                  onPressed: () {
                    Get.to(() => DisplayBooks(selectedPurchaserIndex));
                  },
                  minWidth: double.infinity,
                  height: 50.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Icon(Icons.book, color: Colors.white),
                      SizedBox(width: size.width * 0.05),
                      Text("Display Books", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                  color: Colors.orange,
                ),
                SizedBox(height: size.height * 0.02),
                MaterialButton(
                  onPressed: () {
                    _requestsController.call("0${_requestsController.purchaserList[selectedPurchaserIndex].phoneNumber}");
                  },
                  minWidth: double.infinity,
                  height: 50.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(width: size.width * 0.05),
                      Text("Call", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                  color: Colors.green,
                ),
                SizedBox(height: size.height * 0.02),
                MaterialButton(
                  onPressed: () {
                    print(_requestsController.purchaserList[selectedPurchaserIndex].sId);
                    _requestsController.removePurchaser(_requestsController.purchaserList[selectedPurchaserIndex].sId);
                  },
                  minWidth: double.infinity,
                  height: 50.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Icon(Icons.remove, color: Colors.white),
                      SizedBox(width: size.width * 0.05),
                      Text("Regect", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
