import 'dart:convert';
import 'dart:typed_data';

import 'package:barber_queue/models/imgmodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Imgprovider with ChangeNotifier {
  static const String apiKey = "d5df40d97ab012de4d16922075739af9";

  ImageModel? _imageModel;

  ImageModel? get Image => _imageModel;

// rasmlarni yuklash
  Future<void> uploadImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
          withData: true //web uchun img memory olish
          );
      if (result != null) {
        Uint8List? imageBytes = result.files.first.bytes;
        String fileName = result.files.first.name;

        if (imageBytes != null) {
          await _uploadToImageBB(imageBytes, fileName);
        }
      }
    } catch (e) {
      print("❌ Xatolik: ${e.toString()}");
    }
  }

  Future<void> _uploadToImageBB(Uint8List imageBytes, String fileName) async {
    try {
      final Uri apiUrl =
          Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');
      String base64Image = base64Encode(imageBytes);
      final response = await http.post(apiUrl, body: {
        "image": base64Image,
        "name": fileName,
      });

      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonData['data'] != null) {
        _imageModel = ImageModel.fromJson(jsonData);
        notifyListeners();
      } else {
        print("❌ Xatolik: ${jsonData['message']}");
      }
    } catch (e) {
      print("❌ Xatolik: ${e.toString()}");
    }
  }

  // Rasmni o'chirish
  Future<void> deleteImage(String deleteUrl) async {
    try {
      print("DELETE $deleteUrl");
      final response = await http.delete(Uri.parse(deleteUrl));
      print("SATUS: ${response.statusCode}");
      if (response.statusCode == 200) {
        notifyListeners();
      }
    } catch (e) {
      print("❌ Xatolik: ${e.toString()}");
    }
  }
}
