import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../variables.dart';

class ViewState {
final bool isState;
final num resultado;


const ViewState({this.isState = false,this.resultado = 0 });
}
Variables variables = Variables();
class ViewController extends StateNotifier<ViewState> {
  ViewController([ViewState? state]) : super(ViewState()) {
    //startSettings();

  }

  setState(num valor) {
    state = ViewState(isState: !state.isState, resultado: valor);
  }
}