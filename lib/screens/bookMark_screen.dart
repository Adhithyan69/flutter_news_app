import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/web_view_screen.dart';
import 'package:provider/provider.dart';

import '../models/my_article.dart';
import '../providers/bookmark_provider.dart';
import 'web_view_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final bookmarks = bookmarkProvider.bookmarks;

    if (bookmarks.isEmpty) {
      return const Center(child: Text('No bookmarks added.'));
    }

    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final article = bookmarks[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            leading: article.urlToImage != null
                ? Image.network(
              article.urlToImage!,
              width: 80,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.image_not_supported),
            title: Text(
              article.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(article.sourceName ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                bookmarkProvider.toggleBookmark(article);
              },
            ),
            onTap: () {
              if (article.url.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WebViewScreen(url: article.url),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
