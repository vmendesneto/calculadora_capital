import 'package:calculadora_capital/src/controller/state_view.dart';

import 'package:calculadora_capital/src/providers/theme_provider.dart';
import 'package:calculadora_capital/src/theme/theme_color.dart';
import 'package:calculadora_capital/views/home.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


late SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SharedPreferences.getInstance().then((shared) {
    prefs = shared;
    runApp(const ProviderScope(
        child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = MediaQuery.of(context).size.width;
    if(_width == 0 || _width == null){
      variables.width = 392.77;
    }else{
      variables.width = _width;
    }
    final themesNotifier = ref.read(themeProvider.notifier);
    themesNotifier.setTheme(themes[prefs!.getInt("theme") ?? 0]);

    return MaterialApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Bancário',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // SplashScreenView(
      //   navigateRoute: const HomePage(),
      //   duration: 4000,
      //   text: "Loading.....",
      //   textType: TextType.ColorizeAnimationText,
      //   textStyle: const TextStyle(
      //     fontSize: 40.0,
      //   ),
      //   colors: const [
      //     Colors.white,
      //     Color(0xff082567),
      //     Color(0xff0000CD),
      //   ],
      //   backgroundColor: const Color(0xff082555),
      // ),
    );
  }
}
