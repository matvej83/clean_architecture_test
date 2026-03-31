import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileUtils {
  static Widget getLanguageIcon(String code) {
    var assetName = '';
    switch (code) {
      case 'en':
        assetName = 'assets/svg_icons/flag_us.svg';
        break;
      case 'ru':
        assetName = 'assets/svg_icons/flag_ru.svg';
        break;
      default:
        assetName = '';
        break;
    }
    return SizedBox(
      width: 32.0,
      height: 24.0,
      child: SvgPicture.asset(
        assetName,
        errorBuilder: (_, e, s) => const SizedBox(),
      ),
    );
  }
}
