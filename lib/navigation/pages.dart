import 'package:flutter/material.dart';

@immutable
class Pages {
  const Pages._();

  static const splash = '/splash';
  static const login = '/login';
  static const addProduct = 'add-product';
  static const addCategory = 'add-category';

  /// Shell routes
  static const products = '/products';
  static const users = '/users';
  static const locations = '/locations';
  static const profile = '/profile';
}
