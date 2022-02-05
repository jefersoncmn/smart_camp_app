import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_camp/src/pages/switch_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Mantém o posicionamento da tela limitado
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Digital Docs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SwitchPage(),
      },
    );
  }
}
