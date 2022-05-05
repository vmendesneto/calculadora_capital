

import 'package:calculadora_capital/src/%20calculation/calculation_price.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceProvider = StateNotifierProvider<PriceController, PriceState>((ref) => PriceController());