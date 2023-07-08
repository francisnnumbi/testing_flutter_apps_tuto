import 'package:testing_flutter_apps_tuto/article.dart';

abstract class DataService{
   late List<Article> _articles;
  Future<List<Article>> getArticles();
}