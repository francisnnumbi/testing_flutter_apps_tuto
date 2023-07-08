import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_flutter_apps_tuto/article.dart';
import 'package:testing_flutter_apps_tuto/news_controller.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';

class MockNewsService extends GetxController with Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService = MockNewsService();
  late NewsController controller = NewsController(mockNewsService);
  //Get.put(controller);
  //controller.put();
  List<Article> articlesfromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content'),
  ];
  void arrangeNewsServiceReturn3Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((invocation) async => articlesfromService);
  }
  arrangeNewsServiceReturn3Articles();

  test("initial values are correct", () {
    expect(controller.articles, []);
    expect(controller.isLoading, false);
  });

  group("NewsController getArticles", () {

    test("gets articles using the NewsService", () async {
      final future = controller.getArticles(); // Act
      verify(() => mockNewsService.getArticles()).called(1); // Assert
      expect(controller.isLoading, true);
      await future;
      expect(controller.articles, articlesfromService);
      expect(controller.isLoading, false);
    });
  });
}
