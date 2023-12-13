import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorWidget extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.QR_Generator.tr()),
        backgroundColor: MyColors.Constone,
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: LocaleKeys.Enter.tr(),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.Constone),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _generateQR(context),
              child: Text(LocaleKeys.QR_Generator.tr()),
              style: ElevatedButton.styleFrom(
                foregroundColor: MyColors.Constfour, backgroundColor: MyColors.Constsix,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _generateQR(BuildContext context) {
    if (textController.text.isNotEmpty) {
      showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.QR_Generator.tr()),
      content: SizedBox(
        width: 200.0,
        height: 200.0,
        child: QrImageView(
          data: textController.text,
          version: QrVersions.auto,
        ),
      ),
    );
  },
);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.Please.tr()),
          backgroundColor: MyColors.Constone,
        ),
      );
    }
  }
}