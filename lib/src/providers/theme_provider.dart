import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/theme_color.dart';
import '../theme/themes.dart';


final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
      (ref) => ThemeNotifier(themes[0]),
);