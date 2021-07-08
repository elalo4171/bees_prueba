import 'package:bees_prueba/model/book.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/api.dart';
import 'package:bees_prueba/tools/request_provider.dart';

class RestApi {
  final RequestProvider _requestProvider = RequestProvider();

  Future<BookData> loadBooks() async {
    final response = await _requestProvider.request(Api.server, Api.news);
    return BookData.fromJson(response.body);
  }

  Future<BookData> searchBooks(String query, int page) async {
    final response = await _requestProvider.request(
        Api.server, Api.searchPagnitation(query, page));
    return BookData.fromJson(response.body);
  }

  Future<Book> getBook(String isbn13) async {
    final response =
        await _requestProvider.request(Api.server, Api.book(isbn13));
    return Book.fromJson(response.body);
  }
}
