import 'package:flutter/material.dart';
import 'package:app_qr/ui/models/user_models.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key, required this.user_certificate});

  final Certificate user_certificate;

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    final user_cert = widget.user_certificate;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Imprimir'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage('assets/images/logo.png'),
                                width: 180,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage('assets/images/escudo.png'),
                                width: 80,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('CERTIFICADO',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold)),
                        ),
                        const Text('Otorgado a:',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400)),
                        Text(
                          user_cert.fullName.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 38, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Por haber aprobado\nsatisfactoriamente el curso de:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            user_cert.course.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '( ${user_cert.modality} )',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Duración: ${user_cert.duration} horas',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Brindando a la empresa ${user_cert.company} \nel ${user_cert.date}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 2,
                                width: 200,
                                color: Colors.black),
                            const Positioned(
                                top: 0,
                                child: Image(
                                    image: AssetImage('assets/images/firma.png'),
                                    width: 180))
                          ],
                        ),
                        const Text(
                          'Sandra Otero Kruger',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Jefa de Capacitación',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Image(
                              image: AssetImage('assets/images/brand.png'),
                              color: Colors.grey,
                              width: 240),
                        ),
                        const Text(
                          'Av. República de Panamá 4575 Ofic.\n803-804. Lima 34 - Perú',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
