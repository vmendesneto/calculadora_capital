
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../engine/api_currency/api_currency_connect.dart';

final apiCurrencyProvider = StateNotifierProvider<ApiCurrencyController, ApiCurrencyState>((ref) => ApiCurrencyController());