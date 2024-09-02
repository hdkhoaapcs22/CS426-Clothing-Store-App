import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProvider with ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  String _selectedImage = '';
  Uint8List? _selectedImageBytes;
  bool _isUploaded = false;

  String get selectedImage => _selectedImage;
  Uint8List? get selectedImageBytes => _selectedImageBytes;
  bool get isUploaded => _isUploaded;

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImageBytes = await pickedImage.readAsBytes();
      _selectedImage = pickedImage.path;
      _isUploaded = false;
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
      _isUploaded = false;
      notifyListeners();
    } else {
      //
    }
  }

  void updateUploadedPic() {
    _isUploaded = true;
    notifyListeners();
  }

  void reset() {
    _selectedImage = '';
    _selectedImageBytes = null;
    _isUploaded = false;
    notifyListeners();
  }
}