import 'package:books_uploader_app/home_screen.dart';
import 'package:books_uploader_app/remove_book_screen.dart';
import 'package:books_uploader_app/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            // height: 200,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                SizedBox(height: 20.0),
                MaterialButton(
                  onPressed: () => Get.to(() => HomeScreen(), transition: Transition.fadeIn),
                  height: 50.0,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Add New Book', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.purple,
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  onPressed: () => Get.to(() => RemoveBookScreen(), transition: Transition.fadeIn),
                  height: 50.0,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Remove Book', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.red[600],
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  onPressed: () => Get.to(() => RequestsScreen(), transition: Transition.fadeIn),
                  height: 50.0,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Text('See requests', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.orange,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
