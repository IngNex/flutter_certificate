import 'package:app_qr/ui/models/user_models.dart';
import 'package:app_qr/ui/screens/pdf/widget/stucture_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ImprimirPdf extends StatefulWidget {
  const ImprimirPdf({super.key, required this.certificate});

  final Certificate certificate;

  @override
  State<ImprimirPdf> createState() => _ImprimirPdfState();
}

class _ImprimirPdfState extends State<ImprimirPdf> {

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      onPressed: _createPdf,
      icon: const Icon(Icons.print),
      tooltip: 'Print',
    );
  }

  void _createPdf() async {
    final cert = widget.certificate;
    final doc = pw.Document();

    final logo = await imageFromAssetBundle('assets/images/logo.png');
    final image = await imageFromAssetBundle('assets/images/escudo.png');
    final firma = await imageFromAssetBundle('assets/images/firma.png');
    final brand = await imageFromAssetBundle('assets/images/brand_pdf.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return StructurePdf.buildStructurePdf(cert, logo, image, firma, brand);
        },
      ),
    );
    final title = cert.dni;
    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        format: PdfPageFormat.a4.landscape,
        name: "ESSAC_$title",
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    //await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  
}
/*

pw.Column(
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
                  style: pw.TextStyle(
                      fontSize: 30, fontWeight: pw.FontWeight.bold)),
              pw.Text('Otorgado a:', style: const pw.TextStyle(fontSize: 20)),
              pw.Text(
                cert.fullName!,
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Por haber aprobado satisfactoriamente el curso de:',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 18, fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(height: 5),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 30),
                child: pw.Text(
                  cert.course!,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Text(
                '( ${cert.modality} )',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Duración: ${cert.duration}  horas',
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
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
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                      pw.SizedBox(height:2),
                      pw.Text(cert.certification!, style: const pw.TextStyle(fontSize: 8)),
                    ],
                  ),
                ],
              ),
              pw.Text(
                'Av. República de Panamá 4575 Ofic.803-804. Lima 34 - Perú',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
              ),
            ],
          );
 */