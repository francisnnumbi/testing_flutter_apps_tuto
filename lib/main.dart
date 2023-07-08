import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_flutter_apps_tuto/news_controller.dart';
import 'package:testing_flutter_apps_tuto/news_page.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key}){
   NewsController(NewsService()).put();
  }
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'News App',
      home: NewsPage(),
    );
  }
}