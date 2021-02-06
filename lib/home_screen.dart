import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("image = ${_image.path}");
      });
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
    } else {
      print('No image selected.');
    }
  }

  Uri apiUrl = Uri.parse('https://ab-books-api.vercel.app/books');

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension
    //imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['title'] = _titleController.text.toString();
    imageUploadRequest.fields['category'] = _categoryController.text.toString();
    imageUploadRequest.fields['description'] =
        _descriptionController.text.toString();
    imageUploadRequest.fields['author'] = _authorController.text.toString();
    imageUploadRequest.fields['rating'] = _ratingController.text.toString();
    imageUploadRequest.fields['price'] =
        "\$${_priceController.text.toString()}";
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showInSnackBar(bgColor: Colors.green, value: "uploaded successfully");
        return responseData;
      } else {
        print(response.statusCode);
        showInSnackBar(
            bgColor: Colors.red,
            value: "cant upload, status code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showInSnackBar(bgColor: Colors.red, value: "Cant upload error= $e");
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
      showInSnackBar(
          bgColor: Colors.yellow,
          value: "Please fill all inputs and choose image.");
    }
  }

  void showInSnackBar({String value, Color bgColor}) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: bgColor,
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Book Uploader'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      hintText: "Title",
                      controllerName: _titleController,
                    ),
                    MyTextField(
                      hintText: "Category",
                      controllerName: _categoryController,
                    ),
                    MyTextField(
                      hintText: "Author",
                      controllerName: _authorController,
                    ),
                    MyTextField(
                      hintText: "Rating",
                      controllerName: _ratingController,
                    ),
                    MyTextField(
                      hintText: "Price",
                      controllerName: _priceController,
                    ),
                    SizedBox(height: 15.0),
                    Text("Description",
                        style: TextStyle(color: Colors.grey[700])),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
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
                    SizedBox(height: 20.0),
                    Text(
                      'Image',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[600]),
                    ),
                    Text(
                      _image == null ? "" : _image.path,
                      softWrap: true,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: getImageFromGallery,
                          icon: Icon(Icons.photo_album),
                        ),
                        IconButton(
                          onPressed: getImageFromCamera,
                          icon: Icon(Icons.camera),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: validateInput,
                child: Text('Upload', style: TextStyle(color: Colors.white)),
                color: Colors.deepOrangeAccent,
                minWidth: double.infinity,
                height: 50.0,
              )
            ],
          ),
        ),
      ),
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
