import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class NewsProvider with ChangeNotifier {
  final NewsAPI _newsAPI = NewsAPI(apiKey: '679a1b2f1cd74ce79f38c14054f71ba8');

  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;

  bool get isLoading => _isLoading;

  Future<void> fetchNews([String? query]) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsAPI.getTopHeadlines(
        query: query?.isNotEmpty == true ? query : null,
        country: "us",
        category: "general",
      );
    } catch (e) {
      _articles = [];
      debugPrint("Error fetching news: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

}