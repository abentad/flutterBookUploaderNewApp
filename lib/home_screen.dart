import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  File _image;
  final picker = ImagePicker();
  Uri apiUrl = Uri.parse('https://bookapi.rentoch.com/books');
  String valueChoised;
  List<String> menuItems = ["Fiction", "Educational", "Non-Fiction"];

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: devHeight,
          width: devWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: devHeight * 0.02),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                  actions: [
                                    IconButton(
                                      onPressed: getImageFromGallery,
                                      icon: Icon(Icons.photo_album, size: 32.0),
                                    ),
                                    SizedBox(width: devWidth * 0.02),
                                    IconButton(
                                      onPressed: getImageFromCamera,
                                      icon: Icon(Icons.camera, size: 32.0),
                                    ),
                                  ],
                                  title: "Choose Image",
                                  middleText: "",
                                );
                              },
                              child: Container(
                                height: devHeight * 0.25,
                                width: devWidth * 0.33,
                                decoration: BoxDecoration(
                                  color: Color(0xffeeeeee),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [BoxShadow(color: Colors.purple, offset: Offset(2, 7), blurRadius: 10.0)],
                                  image: _image == null ? null : DecorationImage(image: FileImage(_image), fit: BoxFit.cover),
                                ),
                                child: _image == null ? Icon(Icons.add) : null,
                              ),
                            ),
                            SizedBox(width: devWidth * 0.02),
                            // Text(
                            //   _image == null ? "" : _image.path,
                            //   softWrap: true,
                            //   style: TextStyle(color: Colors.grey),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: devHeight * 0.02),
                      buildTextFormField(hintText: "Book Title", controllerName: _titleController),
                      SizedBox(height: devHeight * 0.02),
                      buildTextFormField(hintText: "Book Author", controllerName: _authorController),
                      SizedBox(height: devHeight * 0.02),
                      buildTextFormField(hintText: "Book Rating", controllerName: _ratingController),
                      SizedBox(height: devHeight * 0.02),
                      buildTextFormField(hintText: "Book Price", controllerName: _priceController),
                      SizedBox(height: devHeight * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 1), borderRadius: BorderRadius.circular(10.0)),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text("Select category"),
                            value: valueChoised,
                            style: TextStyle(color: Colors.black, fontSize: 18.0),
                            underline: SizedBox(),
                            // dropdownColor: Colors.grey,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoised = newValue;
                              });
                              // print("category: ${valueChoised.toString()}");
                            },
                            items: menuItems.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: devHeight * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: devHeight * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MaterialButton(
                    onPressed: () {
                      print("button pressed");
                      validateInput();
                    },
                    child: Text('Add Book', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    height: 50.0,
                    minWidth: double.infinity,
                  ),
                ),
                SizedBox(height: devHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({@required String hintText, @required TextEditingController controllerName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controllerName,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.purple)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.blue)),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Required";
          } else {
            return null;
          }
        },
      ),
    );
  }

  //
  //
  //
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("image = ${_image.path}");
      });
      print(_image.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("image = ${_image.path}");
      });
      print(_image.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }

  //
  //
  Future<Map<String, dynamic>> _uploadImage(File image) async {
    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension
    //imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['title'] = _titleController.text.toString();
    imageUploadRequest.fields['category'] = valueChoised.toString();
    imageUploadRequest.fields['description'] = _descriptionController.text.toString();
    imageUploadRequest.fields['author'] = _authorController.text.toString();
    imageUploadRequest.fields['rating'] = _ratingController.text.toString();
    imageUploadRequest.fields['price'] = "\$${_priceController.text.toString()}";
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showInSnackBar(title: "Success", bgColor: Colors.green, message: "uploaded successfully");
        return responseData;
      } else {
        print(response.statusCode);
        showInSnackBar(title: "Failed", bgColor: Colors.red, message: "cant upload, status code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showInSnackBar(title: "Failed", bgColor: Colors.red, message: "Cant upload error= $e");
      print(e);
      return null;
    }
  }

  void validateInput() async {
    //for unfocusing the keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    //will check if the current form state is validated
    if (_formKey.currentState.validate()) {
      print("validated");
      final Map<String, dynamic> response = await _uploadImage(_image);
      print(response);
    } else {
      print('not validated');
      showInSnackBar(title: "Failed", bgColor: Colors.yellow, message: "Please fill all inputs and choose image.");
    }
  }

  static void showInSnackBar({String title, String message, Color bgColor, Color txtColor = Colors.white}) {
    return Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor,
      colorText: txtColor,
      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      messageText: Text(message, style: TextStyle(fontWeight: FontWeight.bold, color: txtColor)),
      titleText: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: txtColor, fontSize: 20.0)),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controllerName;
  MyTextField({@required this.hintText, @required this.controllerName});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Required";
        } else {
          return null;
        }
      },
    );
  }
}
