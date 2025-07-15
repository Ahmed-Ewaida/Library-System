class ScannerModel {
  final String qrCode;
  final String location;

  const ScannerModel({
    required this.qrCode,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'qr_code': qrCode,
    'location': location,
  };
}
