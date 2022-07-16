
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/desc_controller.dart';


final DescStateViewProvider = StateNotifierProvider<DescViewController, DescViewState>((ref) => DescViewController());