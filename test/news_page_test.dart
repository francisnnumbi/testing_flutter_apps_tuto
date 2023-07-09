import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_flutter_apps_tuto/article.dart';
import 'package:testing_flutter_apps_tuto/news_service.dart';

class MockNewsService extends GetxController with Mock implements NewsService {}

    void main(){
        late MockNewsService mockNewsService;
        setUp(() {
            mockNewsService = MockNewsService();
        });

        testWidgets('', ()async{});

      
    }