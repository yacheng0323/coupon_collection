import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageHelper extends ChangeNotifier {
  Future<File?> getImage({required bool fromCamera}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 720,
    );

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File? croppedImage = await cropImage(pickerImage: image);

      Directory documentDirectory = await getTemporaryDirectory();
      String relativePath = '${DateTime.now().millisecondsSinceEpoch}.png';
      String imagepath;

      if (croppedImage != null) {
        imagepath = path.join(documentDirectory.path, relativePath);
        // _imageFile = croppedImage;

        log("croppedImage = ${croppedImage.lengthSync() / 1024} kb");

        return await croppedImage.copy(imagepath);
      } else {
        imagepath = path.join(documentDirectory.path, relativePath);
        // _imageFile = image;

        log("image = ${image.lengthSync() / 1024} kb");

        return await image.copy(imagepath);
      }

      // _displayImagePath = imagepath;
      // _databaseImagePath = relativePath;

      // notifyListeners();
    }
  }

  Future<File?> cropImage({required File pickerImage}) async {
    final cropped = await ImageCropper().cropImage(
        maxHeight: 720,
        maxWidth: 1280,
        sourcePath: pickerImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          IOSUiSettings(title: "Cropper", aspectRatioLockEnabled: true)
        ],
        compressQuality: 90);

    if (cropped != null) {
      return File(cropped.path);
    }
    return null;
  }

  Future<String?> setImageFromDB(String? newImageFile) async {
    if (newImageFile != null) {
      // _databaseImagePath = newImageFile;

      Directory documentDirectory = await getApplicationDocumentsDirectory();

      File imageFile = File(path.join(documentDirectory.path, newImageFile));

      if (imageFile.existsSync()) {
        return imageFile.path;
        // _displayImagePath = imageFile.path;
        // notifyListeners();
      } else {
        return null;
        // log("Image file does not exist");
      }
    } else {
      return null;
      // log("Path is empty");
    }
  }
}
