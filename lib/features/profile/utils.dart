import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/core/constants/app_strings.dart';

@immutable
class ProfileUtils {
  const ProfileUtils._();

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
