import 'package:app_qr/auth/screens/auth_page.dart';
import 'package:app_qr/common/models/store_model.dart';
import 'package:app_qr/common/utils/auth_store.dart';
import 'package:app_qr/injectable.dart';
import 'package:app_qr/users/services/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:app_qr/ui/provider/api_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await dotenv.load(fileName: "lib/.env.dev");
  } else {
    await dotenv.load(fileName: "lib/.env.prod");
  }

  initInjectable();

  await AuthStore.read().then((value) {
    runApp(MyApp(
      user: value,
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.user});
  final StoreModel? user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //precacheImage(const AssetImage("images/logo-bg.png"), context);
    bool isLogged = false;
    //String version = dotenv.env['APP_VERSION']!;

    if (user != null) {
      isLogged = true;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => isLogged
                ? UserProvider.fromStore(user!)
                : UserProvider(isLogged)),
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        ),
        home: const AuthPage(),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
      ),
    );
  }
}
