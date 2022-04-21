

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/state_view.dart';

final stateViewProvider = StateNotifierProvider<ViewController, ViewState>((ref) => ViewController());