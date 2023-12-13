
import 'package:flutter_readrover/Data/Models/ListModel.dart';
import 'package:flutter_readrover/Data/Repository/BookRepository.dart';


class BookDataSource {
  final ApiService _apiService;

  BookDataSource(this._apiService);

  Future<List<Book>> getBooks() async {
    return await _apiService.getBooks();
  }
}