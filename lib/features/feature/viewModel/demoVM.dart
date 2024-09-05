import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  final List<String> banners = [
    'lib/core/res/images/banner.svg',
    'lib/core/res/images/banner.svg',
    'lib/core/res/images/banner.svg',
  ];

  final List<Map<String, dynamic>> gridItems = List.generate(10, (index) {
    return {
      'image': 'lib/core/res/images/food.jpeg',
      'title': 'Title $index',
      'desc': 'Description $index',
      'star': 'lib/core/res/images/rating.svg',
      'rating': '${index / 10}',
    };
  });

  final List<Map<String, dynamic>> bottomWidgets = [
    {'image': 'lib/core/res/images/home.svg', 'text': 'Home'},
    {'image': 'lib/core/res/images/search.svg', 'text': 'Search'},
    {'image': 'lib/core/res/images/cart.svg', 'text': 'Cart'},
    {'image': 'lib/core/res/images/loc.svg', 'text': 'Location'},
  ];

  Future<void> saveToSharedPreferences(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<Map<String, String>> getAllFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    return Map.fromEntries(
        keys.map((key) => MapEntry(key, prefs.getString(key)!)));
  }
}
