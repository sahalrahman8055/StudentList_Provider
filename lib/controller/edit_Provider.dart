import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProvider extends ChangeNotifier {
  File? file; //
  TextEditingController studentname = TextEditingController();

  TextEditingController studentage = TextEditingController();

  TextEditingController studentaddress = TextEditingController();

  TextEditingController studentphone = TextEditingController();

  String profilephoto = '';
  ImagePicker image = ImagePicker();
  getimage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final XFile? _wantimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_wantimage != null) {
      file = File(_wantimage.path);
      profilephoto = _wantimage.path;
      notifyListeners();
    }
  }

  getcam() async {
    final XFile? _wantimage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (_wantimage != null) {
      file = File(_wantimage.path);
      profilephoto = _wantimage.path;
      notifyListeners();
    }
  }
}
