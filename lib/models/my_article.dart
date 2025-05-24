import 'package:news_api_flutter_package/model/article.dart';

class MyArticle {
  final String title;
  final String url;
  final String? urlToImage;
  final String sourceName;

  MyArticle({
    required this.title,
    required this.url,
    this.urlToImage,
    required this.sourceName,
  });

  factory MyArticle.fromArticle(Article article) {
    return MyArticle(
      title: article.title ?? '',
      url: article.url ?? '',
      urlToImage: article.urlToImage,
      sourceName: article.source.name ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'url': url,
    'urlToImage': urlToImage,
    'sourceName': sourceName,
  };

  factory MyArticle.fromMap(Map<String, dynamic> map) => MyArticle(
    title: map['title'],
    url: map['url'],
    urlToImage: map['urlToImage'],
    sourceName: map['sourceName'],
  );
}
