import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PdfHelper{
  static Widget buildQR(id) {
    return QrImageView(
      data:
          'https://essac-certificados-qr.netlify.app/verificar-certificado?cod=${id}',
      version: QrVersions.auto,
      size: 200,
      //gapless: false,
    );
  }
}