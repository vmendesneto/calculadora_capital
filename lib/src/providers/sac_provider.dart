
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ calculation/calculation_sac.dart';

final sacProvider = StateNotifierProvider<SacController, SacState>((ref) => SacController());