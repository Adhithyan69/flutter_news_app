import 'package:flutter/material.dart';

import 'bookMark_screen.dart';
import 'news_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade100,
            title: const Text(
              'Flutter News App',
              style: TextStyle(
                fontFamily: 'Prompt',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            bottom: TabBar(
              dividerColor: Colors.grey,
              indicatorColor: Colors.black,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.black54,
              labelStyle: TextStyle(fontSize: 15),
              tabs: const [
                Tab(text: 'News'),
                Tab(text: 'Bookmarks'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NewsScreen(),
              const BookmarksScreen(),
            ],
          )),
    );
  }
}
