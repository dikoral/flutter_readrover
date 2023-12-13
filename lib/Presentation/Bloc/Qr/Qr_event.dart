abstract class QRScannerEvent {}

class QRScanEvent extends QRScannerEvent {
  final String qrCode;

  QRScanEvent(this.qrCode);
}