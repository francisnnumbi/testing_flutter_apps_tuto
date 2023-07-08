import 'package:get/get.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';

import 'article.dart';
import 'data_service.dart';

class NewsController extends GetxController {

  final NewsService _dataService;
  NewsController(this._dataService);

  void put()=>Get.put<NewsController>(this);

  static NewsController get to => Get.find();

  final _articles = <Article>[].obs;

  List<Article> get articles => _articles;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> getArticles() async {
    _isLoading.value = true;

    _articles.value = await _dataService.getArticles();

    _isLoading.value = false;
  }
}
