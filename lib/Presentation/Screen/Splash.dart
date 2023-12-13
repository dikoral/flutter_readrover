import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Screen/Login.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  final GetBooksUseCase getBooksUseCase;

  SplashScreen({required this.getBooksUseCase}); 

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage(getBooksUseCase: widget.getBooksUseCase)), 
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.Constone, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/animation/book.json', 
              width: 400, 
              height: 400, 
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), 
            Text(
              'READROVER',
              style: TextStyle(
                fontSize: 24,
                color: MyColors.Constthree,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}