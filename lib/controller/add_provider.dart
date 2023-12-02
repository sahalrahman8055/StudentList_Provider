import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProvider extends ChangeNotifier {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  File? file;

  ImagePicker image = ImagePicker();

  getcam() async {
    var img = await image.pickImage(source: ImageSource.camera);

    file = File(img!.path);
    notifyListeners();
  }

  getgall() async {
    var img = await image.pickImage(source: ImageSource.gallery);
       
      file = File(img!.path);
    notifyListeners();
 
  }
}
