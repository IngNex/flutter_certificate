import 'package:flutter/cupertino.dart';
import 'package:qr/auth/screens/login_page.dart';
import 'package:qr/common/page/main_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    if (true) {
      return const MainPage();
    } else {
      return const LoginPage();
    }
  }
}