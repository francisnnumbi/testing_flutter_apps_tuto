import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_flutter_apps_tuto/article_page.dart';
import 'package:testing_flutter_apps_tuto/news_controller.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key}) {
    NewsController.to.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
       actions: [
          Obx(
            () => (NewsController.to.articles.isEmpty)
                ? const Center(
                child: CircularProgressIndicator(
                  key: Key("np-cpi01"),
                  color: Colors.white,
                ),)
                : const SizedBox(),

          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: Obx(() {
        return NewsController.to.articles.isEmpty
            ? const Center(child: CircularProgressIndicator(key: Key("np-cpi02"),))
            : ListView.builder(
                itemCount: NewsController.to.articles.length,
                itemBuilder: (_, index) {
                  final article = NewsController.to.articles[index];
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ArticlePage(article: article),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(article.title),
                        subtitle: Text(
                          article.content,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              );
      }),
    );
  }
}
