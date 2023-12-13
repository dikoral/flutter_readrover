import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';

class LanguageSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language), 
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Select Language'), 
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('en')); 
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.Constone,
                    textStyle: TextStyle(color: MyColors.Constthree),
                  ),
                  child: Text('English'),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('kk')); 
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.Constone,
                    textStyle: TextStyle(color: MyColors.Constthree),
                  ),
                  child: Text('Kazakh'),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('ru')); 
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.Constone,
                    textStyle: TextStyle(color: MyColors.Constthree),
                  ),
                  child: Text('Russian'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}