
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/web_view_screen.dart';
import 'package:provider/provider.dart';
import '../models/my_article.dart';
import '../providers/bookmark_provider.dart';
import '../providers/news_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchNews();
      context.read<BookmarkProvider>().loadBookmarks();
    });
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();
    context.read<NewsProvider>().fetchNews(query);
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthName(date.month)}, ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();
    final bookmarkProvider = context.watch<BookmarkProvider>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 55,
          color: Colors.white12,
          child: CupertinoSearchTextField(
            controller: searchController,
            placeholder: "Search...",
            style: const TextStyle(color: Colors.grey),
            placeholderStyle: const TextStyle(color: Colors.grey),
            backgroundColor: Colors.grey.withOpacity(0.2),
            onChanged: (_) => _onSearchChanged(),
          ),
        ),
        Expanded(
          child: newsProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : newsProvider.articles.isEmpty
              ? const Center(child: Text('No articles found'))
              : ListView.builder(
            itemCount: newsProvider.articles.length,
            itemBuilder: (context, index) {
              final article = newsProvider.articles[index];
              final myArticle = MyArticle.fromArticle(article);
              final bookmarked =
              bookmarkProvider.isBookmarked(myArticle.url);

              return  Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: article.urlToImage != null
                      ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                      );
                    },
                  )
                      : Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  ),
                ),

                title: Text(
                    article.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            article.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              article.source.name ?? '',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          if (article.publishedAt != null)
                            Text(
                              '[${_formatDate(DateTime.parse(article.publishedAt!))}]',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      bookmarkProvider.toggleBookmark(myArticle);
                    },
                  ),
                  onTap: () {
                    final url = article.url;
                    if (url != null && url.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewScreen(url: url),
                        ),
                      );
                    }
                  },
                ),
              );

            },
          ),
        ),
      ],
    );
  }
}
