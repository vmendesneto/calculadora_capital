import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ calculation/variables.dart';

class ViewState {
final bool isState;
final num resultado;


const ViewState({this.isState = false,this.resultado = 0 });
}
Variables variables = Variables();
class ViewController extends StateNotifier<ViewState> {
  ViewController([ViewState? state]) : super(ViewState()) {


  }

  setState(num valor) {
    state = ViewState(isState: !state.isState, resultado: valor);
  }
  resetState() {
    state = ViewState(isState: !state.isState, resultado: 0);
  }
}