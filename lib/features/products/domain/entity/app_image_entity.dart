import 'dart:typed_data';

class AppImageEntity {
  final Uint8List bytes;
  final String name;

  AppImageEntity({required this.bytes, required this.name});
}
