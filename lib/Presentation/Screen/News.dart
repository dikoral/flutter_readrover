import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Bloc/News/news_bloc.dart';
import 'package:flutter_readrover/Presentation/Bloc/News/news_event.dart';
import 'package:flutter_readrover/Presentation/Bloc/News/news_state.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';


class BooksScreen extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;

  BooksScreen(this.getBooksUseCase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BookBloc(getBooksUseCase)..add(FetchBooks()),
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      // ignore: unnecessary_null_comparison
                      leading: book.imagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                book.imagePath,
                                width: 100,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 160,
                              color: MyColors.Constfive,
                            ),
                      title: Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Author: ${book.author}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            book.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.Constone, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              'Читать',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is BookError) {
              return Center(child: Text('Failed to fetch books'));
            }
            return Center(child: Text('No books available'));
          },
        ),
      ),
      backgroundColor: MyColors.Consttwo, 
    );
  }
}