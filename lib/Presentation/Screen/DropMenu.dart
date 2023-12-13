import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_bloc.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Screen/Animation.dart';
import 'package:flutter_readrover/Presentation/Screen/News.dart';
import 'package:flutter_readrover/Presentation/Screen/Qr.dart';
import 'package:flutter_readrover/Presentation/Screen/Stories.dart';
import 'package:flutter_readrover/Presentation/Screen/User.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';


class Menu extends StatefulWidget {
  final GetBooksUseCase getBooksUseCase;

  Menu(this.getBooksUseCase);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _advancedDrawerController,
      drawer: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color:  MyColors.Constone, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person, color: MyColors.Constsix),
                title: Text(LocaleKeys.Profile.tr(), style: TextStyle(color: MyColors.Constthree)),
                onTap: () => _navigateTo(UserPage()),
              ),
              ListTile(
                leading: Icon(Icons.camera, color: MyColors.Constsix),
                title: Text(LocaleKeys.Stories.tr(), style: TextStyle(color: MyColors.Constthree)),
                onTap: () => _navigateTo(Stories()),
              ),
              ListTile(
                leading: Icon(Icons.animation, color: MyColors.Constsix),
                title: Text(LocaleKeys.Animation.tr(), style: TextStyle(color: MyColors.Constthree)),
                onTap: () => _navigateTo(Book()),
              ),
              ListTile(
                leading: Icon(Icons.qr_code, color: MyColors.Constsix),
                title: Text(LocaleKeys.QR.tr(), style: TextStyle(color: MyColors.Constthree)),
                onTap: () {
               QRScannerBloc qrBloc = QRScannerBloc();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScanner(qrBloc: qrBloc)),
               );
              },
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: MyColors.Constsix),
            onPressed: _handleMenuButtonPressed,
          ),
        ),
        body: BooksScreen(widget.getBooksUseCase),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}









