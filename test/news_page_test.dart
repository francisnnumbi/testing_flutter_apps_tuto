import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_flutter_apps_tuto/article.dart';
import 'package:testing_flutter_apps_tuto/news_controller.dart';
import 'package:testing_flutter_apps_tuto/news_page.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';

class MockNewsService extends GetxController with Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService = MockNewsService();

  List<Article> articlesfromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content'),
  ];
  void arrangeNewsServiceReturn0Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((invocation) async => []);
  }
  void arrangeNewsServiceReturn3Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((invocation) async => articlesfromService);
  }

  void arrangeNewsServiceReturn3ArticlesAfter2SecondWait() {
      when(() => mockNewsService.getArticles())
          .thenAnswer((invocation) async {
              await Future.delayed(const Duration(seconds: 5));
              return articlesfromService;
      });
  }

  //Get.put(NewsController(mockNewsService));

  Widget createWidgetUnderTest() => GetMaterialApp(
        title: 'News App',
        home: NewsPage(),
      );

  testWidgets('title is displayed', (WidgetTester tester) async {
    Get.put(NewsController(mockNewsService));
    arrangeNewsServiceReturn0Articles();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('News'), findsOneWidget);
  });

  testWidgets('loading indicator is displayed while waiting for articles', (WidgetTester tester) async {
      Get.put(NewsController(mockNewsService));
      arrangeNewsServiceReturn3ArticlesAfter2SecondWait();
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const Key("np-cpi02")), findsOneWidget);
      await tester.pumpAndSettle();
  });

  testWidgets('articles are displayed', (WidgetTester tester) async {
    Get.put(NewsController(mockNewsService));
    arrangeNewsServiceReturn3Articles();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    for (final article in articlesfromService) {
      expect(find.text(article.title), findsOneWidget);
      expect(find.text(article.content), findsOneWidget);
    }
    await tester.pumpAndSettle();
  });
}
