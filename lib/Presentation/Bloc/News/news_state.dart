import 'package:flutter_readrover/Domain/Entities/ListEntities.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookEntity> books;
  BookLoaded(this.books);
}

class BookError extends BookState {}