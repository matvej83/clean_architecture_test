import 'package:clean_architecture_test/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileUtils {
  static Widget getLanguageIcon(String code) {
    var assetName = '';
    switch (code) {
      case 'en':
        assetName = AppStrings.flagUsa;
        break;
      case 'ru':
        assetName = AppStrings.flagRu;
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
