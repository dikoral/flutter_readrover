import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_event.dart';
import 'package:flutter_readrover/Presentation/Bloc/Qr/Qr_state.dart';


class QRScannerBloc extends Bloc<QRScannerEvent, QRScannerState> {
  QRScannerBloc() : super(QRInitial()) {
    on<QRScanEvent>((event, emit) {
      emit(QRScannedState(event.qrCode));
    });
  }
}