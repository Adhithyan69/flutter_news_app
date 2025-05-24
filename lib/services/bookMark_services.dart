import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/my_article.dart';

class BookmarkService {
  static const _key = 'bookmarks';

  Future<List<MyArticle>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => MyArticle.fromMap(json.decode(e))).toList();
  }

  Future<void> saveBookmarks(List<MyArticle> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = bookmarks.map((e) => json.encode(e.toMap())).toList();
    await prefs.setStringList(_key, data);
  }
}