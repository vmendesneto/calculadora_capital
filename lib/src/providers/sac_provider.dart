
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ calculation/loan_calculation/calculation_sac.dart';

final sacProvider = StateNotifierProvider<SacController, SacState>((ref) => SacController());