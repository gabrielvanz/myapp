import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> product) {
    final isExist = _favorites.contains(product);
    if (isExist) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> product) {
    return _favorites.contains(product);
  }
} 