import 'package:flutter_readrover/Data/Repository/ListRepository.dart';
import 'package:flutter_readrover/Domain/Entities/ListEntities.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> call() async {
    return await repository.getBooks();
  }
}