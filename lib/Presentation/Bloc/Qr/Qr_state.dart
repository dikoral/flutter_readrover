abstract class QRScannerState {}

class QRInitial extends QRScannerState {}

class QRScannedState extends QRScannerState {
  final String qrCode;

  QRScannedState(this.qrCode);
}