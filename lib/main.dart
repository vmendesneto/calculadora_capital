import 'package:calculadora_capital/src/providers/api_provider.dart';
import 'package:calculadora_capital/src/providers/theme_provider.dart';
import 'package:calculadora_capital/src/theme/theme_color.dart';
import 'package:calculadora_capital/views/home.dart';
import 'package:calculadora_capital/views/home_emp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/ calculation/loan_calculation/iof_value.dart';

late SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((shared) {
    prefs = shared;
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themesNotifier = ref.read(themeProvider.notifier);
    themesNotifier.setTheme(themes[prefs!.getInt("theme") ?? 0]);
    final apiController = ref.watch(apiProvider.notifier);
      apiController.BankList();



    return MaterialApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Bancário',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
      },
      home: const HomePage(),
    );

  }
}
