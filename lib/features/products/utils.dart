import 'dart:developer';
import 'dart:typed_data';
import 'package:clean_architecture_test/features/products/domain/entity/app_image_entity.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ProductsUtils {
  static Future<AppImageEntity?> getImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked == null) return null;

    try {
      final bytes = await picked.readAsBytes();

      final normalizedBytes = await _normalizeImage(
        bytes,
        originalName: picked.name,
      );

      final fileName = _normalizeFileName(picked.name);

      return AppImageEntity(bytes: normalizedBytes, name: fileName);
    } catch (e) {
      log('getImageFromGallery error: $e');
      return null;
    }
  }

  static Future<Uint8List> _normalizeImage(
    Uint8List bytes, {
    String? originalName,
  }) async {
    try {
      final image = img.decodeImage(bytes);
      if (image == null) return bytes;

      final normalized = img.bakeOrientation(image);

      final ext = _getExtension(originalName);

      return _encode(normalized, ext);
    } catch (e) {
      log('normalizeImage error: $e');
      return bytes;
    }
  }

  static Uint8List _encode(img.Image image, String ext) {
    switch (ext) {
      case '.png':
        return Uint8List.fromList(img.encodePng(image));
      case '.bmp':
        return Uint8List.fromList(img.encodeBmp(image));
      case '.gif':
        return Uint8List.fromList(img.encodeGif(image));
      default:
        return Uint8List.fromList(img.encodeJpg(image, quality: 90));
    }
  }

  static String _getExtension(String? name) {
    if (name == null || !name.contains('.')) {
      return '.jpg';
    }

    return '.${name.split('.').last.toLowerCase()}';
  }

  static String _normalizeFileName(String originalName) {
    final base = originalName.split('.').first;
    final ext = _getExtension(originalName);
    return '$base$ext';
  }

  static Widget getFilterButton(
    BuildContext context, {
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? Colors.grey.shade600
        : Colors.grey.shade400;
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      onPressed: onTap,
      icon: Icon(
        isActive ? Icons.filter_alt : Icons.filter_alt_outlined,
        color: isActive ? Colors.blue : Colors.white,
        size: 24.0,
      ),
    );
  }
}
