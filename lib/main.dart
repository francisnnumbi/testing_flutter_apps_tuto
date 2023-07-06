import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter_apps_tuto/news_page.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';

import 'news_change_notifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}