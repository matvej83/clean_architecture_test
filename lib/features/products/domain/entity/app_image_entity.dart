import 'dart:typed_data';

class AppImageEntity {
  AppImageEntity({required this.bytes, required this.name});

  final Uint8List bytes;
  final String name;
}
