import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Bloc/News/news_event.dart';
import 'package:flutter_readrover/Presentation/Bloc/News/news_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooksUseCase getBooksUseCase;

  BookBloc(this.getBooksUseCase) : super(BookInitial()) {
    on<FetchBooks>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      final books = await getBooksUseCase.call();
      emit(BookLoaded(books));
    } catch (_) {
      emit(BookError());
    }
  }
}