import 'package:app_qr/common/models/store_model.dart';
import 'package:app_qr/ui/screens/home_page.dart';
import 'package:app_qr/users/services/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_qr/auth/infrastructure/models/login_model.dart';
import 'package:app_qr/auth/services/auth_service.dart';
import 'package:app_qr/common/models/api_error_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../injectable.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = locator<AuthService>();
  String error = '';
  bool _isObscured = true;

  bool termsAccepted = false;

  @override
  void dispose() {
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }

  Future<StoreModel?> signIn() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        error = 'Usuario y/o contraseña no pueden ser vacíos';
      });
      return null;
    }

    try {
      print('holaaa'+username+password);
      return await authService.login(LoginModel(username, password));
    } catch (e) {
      _passwordController.clear();
      if (e is ApiErrorModel) {
        setState(() => error = e.message.toString());
        return null;
      }
      setState(() => error = 'Hubo un error');
      return null;
    }
  }

  void nextScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider logo = const AssetImage("assets/images/logo.png");
    //MainPageProvider provider = Provider.of<MainPageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  decoration:
                      BoxDecoration(image: DecorationImage(image: logo)),
                ),
                const SizedBox(
                  height: 30,
                ),
                form(),
                error.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(height: 20),
                termsCheckbox(),
                loginButton(),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Términos y Condiciones',
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              'https://essac-inspect-gestion.netlify.app/terminos-y-condiciones'));
                        },
                    ),
                  ],
                )),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'ESSAC Inspect (GESTION) - v 1.1.1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      height: MediaQuery.of(context).size.height / 4.1,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) => {
                if (value.isNotEmpty) {setState(() => error = '')}
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  controller: _passwordController,
                  obscuringCharacter: '*',
                  obscureText: _isObscured,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Password",
                    hintText: '*********',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Visibility(
                        visible: _isObscured,
                        replacement: const Icon(Icons.visibility),
                        child: const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget termsCheckbox() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Acepto los términos y condiciones'.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Checkbox(
            value: termsAccepted,
            onChanged: (value) {
              setState(() {
                termsAccepted = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    UserProvider user = Provider.of<UserProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
        onPressed: !termsAccepted
            ? null
            : () async {
                final navigator = Navigator.of(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  },
                );
                StoreModel? store = await signIn();
                if (store != null) {
                  user.login(store: store);
                }
                navigator.pop();
                if (error.isEmpty) {
                  nextScreen();
                }
              },
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
