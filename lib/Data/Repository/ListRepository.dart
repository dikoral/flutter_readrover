import 'package:flutter_readrover/Data/DataSource/ListDataSource.dart';
import 'package:flutter_readrover/Domain/Entities/ListEntities.dart';
import 'package:dio/dio.dart'; 

class BookRepository {
  final BookDataSource dataSource;

  BookRepository(this.dataSource);

  Future<List<BookEntity>> getBooks() async {
    try {
      final books = await dataSource.getBooks();
      return books.map((book) => BookEntity(
        id: book.id,
        title: book.title,
        author: book.author,
        description: book.description,
        imagePath: book.imagePath,
      )).toList();
    } on DioError catch (e) {
      print("Dio error: ${e.message}");
      if (e.response != null) {
        print("Got response: ${e.response!.data}");
      } else {
        print("Error sending request: ${e.requestOptions}");
      }
      return []; 
    } catch (e) {
      print("Other error: $e");
      return []; 
    }
  }
}