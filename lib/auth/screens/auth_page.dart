import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:app_qr/auth/screens/login_page.dart';
import 'package:app_qr/auth/user_provider.dart';
import 'package:app_qr/common/page/main_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    if (user.isLogged) {
      return const MainPage();
    } else {
      return const LoginPage();
    }
  }
}