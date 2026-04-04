import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProductsUtils {
  static Future<File?> getImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return _normalizeImage(File(picked.path));
  }

  static Future<File> _normalizeImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return file;

      final normalized = img.bakeOrientation(image);
      final ext = path.extension(file.path).toLowerCase();
      final encoder = _getEncoder(ext);
      final resultBytes = encoder(normalized);

      final newPath = path.join(
        path.dirname(file.path),
        '${path.basenameWithoutExtension(file.path)}_normalized$ext',
      );
      final newFile = await File(
        newPath,
      ).writeAsBytes(resultBytes, flush: true);

      // removing the old file
      await removeImage(file);

      return newFile;
    } catch (e) {
      debugPrint('normalizeImage error: $e');
      return file;
    }
  }

  static Uint8List Function(img.Image image) _getEncoder(String ext) {
    switch (ext) {
      case '.png':
        return img.encodePng;
      case '.bmp':
        return img.encodeBmp;
      case '.gif':
        return img.encodeGif;
      default:
        return img.encodeJpg;
    }
  }

  static Future<void> removeImage(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('deleting file error: $e');
    }
  }
}
