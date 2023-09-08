import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class StructurePdf {
  static Widget buildStructurePdf(cert, logo, image, firma, brand) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(logo, width: 150),
              pw.Image(image, width: 60),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text('CERTIFICADO',
              style:
                  pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
          pw.Text('Otorgado a:', style: const pw.TextStyle(fontSize: 20)),
          pw.Text(
            cert.fullName!,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Por haber aprobado satisfactoriamente el curso de:',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 18, fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 5),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 30),
            child: pw.Text(
              cert.course!,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(
            '( ${cert.modality} )',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Duración: ${cert.duration}  horas',
            style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Brindando a la empresa ${cert.company} \nel ${cert.date}',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 14,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.Stack(
            alignment: pw.Alignment.bottomCenter,
            children: [
              pw.Container(
                  margin: const pw.EdgeInsets.only(top: 75),
                  height: 1.2,
                  width: 180,
                  color: PdfColor.fromHex('000000')),
              pw.Positioned(
                child: pw.Image(firma, width: 100),
              )
            ],
          ),
          pw.Text(
            'Sandra Otero Kruger',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Jefa de Capacitación',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(brand, width: 120),
              pw.Column(
                children: [
                  pw.BarcodeWidget(
                    color: PdfColor.fromHex("#000000"),
                    barcode: pw.Barcode.qrCode(),
                    width: 60,
                    height: 60,
                    data:
                        "https://essac-certificados-qr.netlify.app/verificar-certificado?cod=${cert.certification}",
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(cert.certification!,
                      style: const pw.TextStyle(fontSize: 8)),
                ],
              ),
            ],
          ),
          pw.Text(
            'Av. República de Panamá 4575 Ofic.803-804. Lima 34 - Perú',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
          ),
        ],
      );
}
