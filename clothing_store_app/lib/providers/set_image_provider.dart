import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProvider with ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  String _selectedImage = '';
  Uint8List? _selectedImageBytes;
  String get selectedImage => _selectedImage;
  Uint8List? get selectedImageBytes => _selectedImageBytes;

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImageBytes = await pickedImage.readAsBytes();
      _selectedImage = pickedImage.path;
      notifyListeners();
    } else {
      //
    }
  }

  Future<void> takePhoto() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _selectedImageBytes = await pickedImage.readAsBytes();
      _selectedImage = pickedImage.path;
      notifyListeners();
    } else {
      //
    }
  }
}
