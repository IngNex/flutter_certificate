import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/ui/provider/api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final certificate = apiProvider.certificate;
    return Scaffold(
        body: SafeArea(
      child:
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              itemCount: certificate.length,
              itemBuilder: (context, index) {
                return Text(certificate[index].fullName, style: const TextStyle(color: Colors.red),);
              }
            )
          ),
    ));
  }
}
