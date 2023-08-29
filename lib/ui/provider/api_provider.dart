import 'package:flutter/material.dart';
import 'package:qr/ui/models/user_models.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier{
  final url = 'essac-certificados-qr.netlify.app';
  List<Certificate> certificate=[];
  final String token= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ZDI4NmJlLTViOGYtNDQ3YS05OWNmLTM1NTc4NjUwYmUxYiIsIm5hbWUiOiJhZG1pbiIsImlhdCI6MTY5MzI0MTMxMiwiZXhwIjoxNjk0MTA1MzEyfQ.BOyzgslJfISg7T7X9C2Zr3RvYE3MojHXTsNk5i6r1lQ";

  Future<void> getCertificados() async{
    final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

     final api = Uri.parse("https://essac-certificados-qr.netlify.app/api/v1/certificates");

    final result = await http.get(api, headers: headers);
    print(result);
    final response = certificateFromJson(result.body);
    certificate.addAll(response);
    notifyListeners();
  }
}