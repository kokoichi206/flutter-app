import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_sample/select_photo_options_screen.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({Key? key}) : super(key: key);

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      print("image.path: ${image.path}");
      setState(() {
        _image = img;

        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print("e: ${e}");
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
          child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _showSelectPhotoOptions(context);
          print("onTap");
        },
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: Center(
            child: _image == null
                ? const Text(
                    "No image selected",
                    style: TextStyle(fontSize: 16),
                  )
                : Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      )),
    );
  }
}
