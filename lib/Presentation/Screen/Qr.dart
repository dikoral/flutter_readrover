import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_bloc.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_event.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_state.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/Presentation/Screen/QrGenerate.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  final QRScannerBloc qrBloc;

  QRScanner({Key? key, required this.qrBloc}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.QR_Scanner.tr()),
        backgroundColor: MyColors.Constone,
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: MyColors.Constsix,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: StreamBuilder(
                stream: widget.qrBloc.stream,
                builder: (context, AsyncSnapshot<QRScannerState> snapshot) {
                  if (snapshot.data is QRScannedState) {
                    return Text(
                      'Data: ${(snapshot.data as QRScannedState).qrCode}',
                      style: TextStyle(color: MyColors.Constone),
                    );
                  }
                  return Text('Scan a QR code', style: TextStyle(color: MyColors.Constone));
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRGeneratorWidget(),
                  ),
                );
              },
        child: Icon(Icons.qr_code_2),
        backgroundColor: MyColors.Constsix,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
  this.controller = controller;
  controller.scannedDataStream.listen((scanData) {
    if (mounted && scanData.code != null) {
      widget.qrBloc.add(QRScanEvent(scanData.code!));
    }
  });
}

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}