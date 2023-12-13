import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';


class Book extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.Best.tr(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.yellow,
      ),
      home: BeautifulBookListPage(),
    );
  }
}

class BeautifulBookListPage extends StatefulWidget {
  @override
  _BeautifulBookListPageState createState() => _BeautifulBookListPageState();
}

class _BeautifulBookListPageState extends State<BeautifulBookListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _books = [];
  List<String> _allBooks = [
    '1984 by George Orwell',
    LocaleKeys.The.tr(),
    LocaleKeys.Pride.tr(),
    LocaleKeys.Murder.tr(),
    LocaleKeys.Harry.tr(),
    LocaleKeys.The.tr(),
    LocaleKeys.Gone.tr(),
    LocaleKeys.Alice.tr(),
    LocaleKeys.Little.tr(),
    LocaleKeys.Adventures.tr()
  ];

  @override
  void initState() {
    super.initState();
    _addBooksSequentially();
  }

  void _addBooksSequentially() async {
    for (var book in _allBooks) {
      await Future.delayed(Duration(milliseconds: 500));
      _books.add(book);
      _listKey.currentState?.insertItem(_books.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Best.tr()),
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _books.length,
        itemBuilder: (context, index, animation) {
          return _buildAnimatedBookCard(_books[index], animation);
        },
      ),
      backgroundColor: MyColors.Consttwo,
    );
  }

  Widget _buildAnimatedBookCard(String book, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: MyColors.Constthree,
        child: ListTile(
          title: Text(
            book,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.Constone,
            ),
          ),
          leading: Icon(Icons.book, color: MyColors.Constsix),
          trailing: Icon(Icons.arrow_forward_ios, color: MyColors.Constone),
        ),
      ),
    );
  }
}