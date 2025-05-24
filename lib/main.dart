import 'package:flutter/material.dart';
import 'package:flutter_news_app/providers/bookmark_provider.dart';
import 'package:flutter_news_app/providers/news_provider.dart';
import 'package:flutter_news_app/screens/home_page.dart';
import 'package:flutter_news_app/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()..loadBookmarks()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : const UserLogin(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const UserLogin(),
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_news_app/screens/login_page.dart';
// void main(){
//   runApp( MaterialApp(home: UserLogin()));
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
