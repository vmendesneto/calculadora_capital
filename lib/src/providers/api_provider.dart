
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../engine/api_bank/api_connect.dart';

final apiProvider = StateNotifierProvider<ApiController, ApiState>((ref) => ApiController());