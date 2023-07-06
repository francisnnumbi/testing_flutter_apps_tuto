import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter_apps_tuto/article.dart';
import 'package:testing_flutter_apps_tuto/news_change_notifier.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';
import 'package:mocktail/mocktail.dart';

/*class BadMockNewsService implements NewsService{
  bool getArticlesCalled = false;
  @override
  Future<List<Article>> getArticles() async {
    getArticlesCalled = true;
   return [
     Article(title: 'Test 1', content: 'Test 1 content'),
     Article(title: 'Test 2', content: 'Test 2 content'),
     Article(title: 'Test 3', content: 'Test 3 content'),
   ];
  }

}*/

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut; // System Under Test
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test(
    "initial values are correct",
    () {
      expect(sut.articles, []);
      expect(sut.isLoading, false);
    },
  );

  group('getArticles', () {
    final articlesfromService = [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];
    void arrangeNewsServiceReturn3Articles() {
      when(() => mockNewsService.getArticles()).thenAnswer(
        (_) async => articlesfromService,
      );
    }

    ;

    // Arrange Act Assert
    test("gets articles using the NewsService", () async {
      arrangeNewsServiceReturn3Articles(); // Arrange
      await sut.getArticles(); // Act
      verify(() => mockNewsService.getArticles()).called(1); // Assert
    });

    test("""indicates loading of data, 
    sets articles to the ones from the service,
    indicate that data is not being loaded anymore""", () async {
      arrangeNewsServiceReturn3Articles();
      final future = sut.getArticles();
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, articlesfromService);
      expect(sut.isLoading, false);
    });
  });
}
