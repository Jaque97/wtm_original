import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImageService {
  Future<String> saveFiles(String image, String folder) async {
    String url;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (image == null) return null;
      await FirebaseStorage.instance
          .ref()
          .child(folder)
          .child(id)
          .putFile(File(image))
          .then((value) async {
        url = await value.ref.getDownloadURL();
      });
      return url;
    } catch (err) {
      print(err);
      print('error in saving profile image: ${err.code}');
      return null;
    }
  }
}
