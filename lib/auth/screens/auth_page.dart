import 'package:app_qr/auth/screens/login_page.dart';
import 'package:app_qr/ui/screens/home_page.dart';
import 'package:app_qr/users/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    if (user.isLogged) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
