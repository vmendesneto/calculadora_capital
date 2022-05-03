// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:calculadora_capital/src/providers/theme_provider.dart';
import 'package:calculadora_capital/src/theme/theme_color.dart';
import 'package:calculadora_capital/views/home.dart';
import 'package:calculadora_capital/views/simulator_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Platform.isAndroid == true ? MaterialApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Capital de Giro',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
      },
      home: const HomePage(),
    ) :  CupertinoApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Capital de Giro',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
      },
      home: const HomePage(),
    );
  }
}
