import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/data/di/injection.dart';
import 'package:photo_editor_app/data/service/local/local_service.dart';

class ImageNotifier extends ChangeNotifier {
  final _localService = getIt.get<LocalService>();
  final _imagePicker = getIt.get<ImagePicker>();
  final _imageCropper = getIt.get<ImageCropper>();

  final List<File> _images = [];
  List<File> get images => _images;

  File? _image;
  File? get image => _image;

  ImageNotifier() {
    _loadImages();
  }

  set image(File? image) {
    _image = image;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _images.add(file);
      _image = file;
      await _saveImages();
      notifyListeners();
    }
  }

  Future<void> cropImage() async {
    if (_image != null) {
      final croppedFile = await _cropImage(_image!);
      if (croppedFile != null) {
        final index = _images.indexOf(_image!);
        if (index != -1) {
          _images[index] = croppedFile;
        }
        _image = croppedFile;
        await _saveImages();
        notifyListeners();
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final cropped = await _imageCropper.cropImage(
      sourcePath: imageFile.path,
    );
    return cropped != null ? File(cropped.path) : null;
  }

  Future<void> _saveImages() async {
    final imagePaths = _images.map((image) => image.path).toList();
    await _localService.write('images', imagePaths);
  }

  Future<void> _loadImages() async {
    final imagePaths = await _localService.read('images') as List<dynamic>?;
    if (imagePaths != null) {
      _images.clear();
      _images.addAll(imagePaths.map((path) => File(path as String)));
      notifyListeners();
    }
  }

  clearList() async {
    _images.clear();
    await _localService.clear();
    notifyListeners();
  }
}
