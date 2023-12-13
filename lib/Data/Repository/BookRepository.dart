import 'package:flutter_readrover/Data/Models/ListModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'BookRepository.g.dart';

@RestApi(baseUrl: "https://readrover-eb615-default-rtdb.firebaseio.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/book.json")
  Future<List<Book>> getBooks();
}