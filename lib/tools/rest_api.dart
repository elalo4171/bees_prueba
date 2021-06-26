import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/api.dart';
import 'package:bees_prueba/tools/request_provider.dart';

class RestApi {
  final RequestProvider _requestProvider = RequestProvider();

  Future<BookData> loadBooks() async {
    final response = await _requestProvider.request(Api.server, Api.news);
    return BookData.fromJson(response.body);
  }
}
