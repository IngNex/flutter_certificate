import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatelessWidget {
  const QR({super.key});

  @override
  Widget build(BuildContext context) {
    final String id= "ES-INST-23-0300";
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          QrImageView(
            data: 'https://essac-certificados-qr.netlify.app/verificar-certificado?cod=${id}',
            version: QrVersions.auto,
            size: 200,
            //gapless: false,
           
          )
        ],
      )),
    );
  }
}
