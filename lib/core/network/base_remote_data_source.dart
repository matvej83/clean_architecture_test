import 'package:flutter/material.dart';

import '../error/dio_error_parser.dart';

abstract class BaseRemoteDataSource {
  /// Is available only for Data Source children.
  @protected
  Future<T> makeRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      throw ApiErrorHandler.onError(e);
    }
  }
}
