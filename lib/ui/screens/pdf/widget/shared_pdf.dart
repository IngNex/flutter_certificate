import 'package:app_qr/ui/models/user_models.dart';
import 'package:app_qr/ui/screens/pdf/widget/stucture_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SharedPdf extends StatefulWidget {
  const SharedPdf({super.key, required this.certificate});

  final Certificate certificate;

  @override
  State<SharedPdf> createState() => _SharedPdfState();
}

class _SharedPdfState extends State<SharedPdf> {

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      onPressed: _createPdf,
      icon: const Icon(Icons.share_rounded),
      tooltip: 'Shared',
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
    // await Printing.layoutPdf(
    //     format: PdfPageFormat.a4.landscape,
    //     name: "ESSAC_$title",
    //     onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(bytes: await doc.save(), filename: 'ESSAC_$title.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  
}