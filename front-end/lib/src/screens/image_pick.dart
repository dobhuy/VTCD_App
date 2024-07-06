import 'dart:typed_data';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

final dio = Dio();

class ImageSelect extends StatefulWidget {
  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  var _isLoading = false;

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await dio.post(
      "http://192.168.102.6:3000/v1/program/getImageName",
      data: formData,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    // final response = await dio.post(
    //     "https://vtcrecognition.onrender.com/v1/program/getImageName",
    //     data: formData);
    // final response =
    //     await dio.get("http://192.168.2.67:3000/v1/item/getAllItems");
    // return response.data['id'];
    // print(response.data["message"].toString());
    final receivedData = response.data as Uint8List;
    print(receivedData);

    // if (receivedData.compareTo('[\'BanhTaiHeo\']') == 0) {
    //   print('Success');
    // }

    // switch (receivedData) {
    //   case '[\'BanhChung\']':
    //     receivedData = 'Banh Chung';
    //     break;
    //   case '[\'BanhGiayGio\']':
    //     receivedData = 'Banh Giay Gio';
    //     break;
    //   case '[\'BanhTaiHeo\']':
    //     receivedData = 'Banh Tai Heo';
    //     break;
    //   case '[\'BanhPia\']':
    //     receivedData = 'Banh Pia';
    //     break;
    //   case '[\'BanhCay\']':
    //     receivedData = 'Banh Cay';
    //     break;
    //   default:
    //     print('default');
    //     break;
    // }
    setState(() {
      _isLoading = false;
    });
    if (context.mounted) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text('Result')),
          backgroundColor: Color.fromARGB(255, 232, 231, 231),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Center(
            child: receivedData != null
                ? Image.memory(receivedData)
                : CircularProgressIndicator(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Center(
                child: Text(
                  'OK',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // ClipPath(
          //   clipper: CustomClipPathPurpleAccent(context: context),
          //   child: Container(
          //     color: Colors.deepPurpleAccent,
          //   ),
          // ),
          ClipPath(
            clipper: CustomClipPathPurple(context: context),
            child: Container(
              color: Colors.deepPurple,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'VTCD',
                    style: GoogleFonts.courgette(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                ElevatedButton(
                  onPressed: () {
                    myAlert();
                  },
                  child: Text(
                    'Upload Photo',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //if image not null show the image
                //if image null show text
                image != null
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              //to show image, you type like this.
                              File(image!.path),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "No Image Found",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                // ElevatedButton(
                //   onPressed: () {
                //     uploadImage(File(image!.path));
                //   },
                //   child: Text('Upload Image'),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: _isLoading == false
                      ? CustomButton(
                          buttonText: 'Detect',
                          isImageUploaded: image != null,
                          onHelpPressed: () {
                            uploadImage(File(image!.path));
                            setState(() {
                              _isLoading = true;
                            });
                          },
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.isImageUploaded,
      required this.onHelpPressed});

  final void Function() onHelpPressed;
  final bool isImageUploaded;
  final String buttonText;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isImageUploaded ? widget.onHelpPressed : null,
      onTapDown: (_) {
        if (widget.isImageUploaded) {
          setState(() {
            _padding = 0;
          });
        }
      },
      onTapCancel: () {
        // setState(() {
        //   _padding = 6;
        // });
        if (widget.isImageUploaded) {
          setState(() {
            _padding = 6;
          });
        }
      },
      onTapUp: (_) {
        // setState(() {
        //   _padding = 6;
        // });
        if (widget.isImageUploaded) {
          setState(() {
            _padding = 6;
          });
        }
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color:
              // widget.chosenAnswer.isEmpty ? Colors.grey[600] : Colors.blue[700],
              // Colors.deepPurple,
              widget.isImageUploaded ? Colors.deepPurple : Colors.grey[500],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
            // color: Colors.deepPurpleAccent,
            color:
                widget.isImageUploaded ? Colors.deepPurpleAccent : Colors.grey,
            border: Border.all(
              // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
              // color: Colors.deepPurpleAccent,
              color: widget.isImageUploaded
                  ? Colors.deepPurpleAccent
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPathPurple extends CustomClipper<Path> {
  CustomClipPathPurple({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.2);
    path.lineTo(w, h * 0.2);
    // path.quadraticBezierTo(w * 0.1, h * 0.12, w * 0.5, h * 0.08);
    // path.quadraticBezierTo(w * 0.8, h * 0.05, w, h * 0.11);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
