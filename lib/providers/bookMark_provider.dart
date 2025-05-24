import 'package:flutter/cupertino.dart';

import '../models/my_article.dart';
import '../services/bookMark_services.dart';


class BookmarkProvider with ChangeNotifier {
  final BookmarkService _service = BookmarkService(); // Create an instance

  List<MyArticle> _bookmarks = [];

  List<MyArticle> get bookmarks => _bookmarks;

  Future<void> loadBookmarks() async {
    _bookmarks = await _service.loadBookmarks();
    notifyListeners();
  }

  Future<void> toggleBookmark(MyArticle article) async {
    if (_bookmarks.any((a) => a.url == article.url)) {
      _bookmarks.removeWhere((a) => a.url == article.url);
    } else {
      _bookmarks.add(article);
    }
    await _service.saveBookmarks(_bookmarks);
    notifyListeners();
  }

  bool isBookmarked(String url) => _bookmarks.any((a) => a.url == url);
}
