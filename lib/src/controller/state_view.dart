import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ calculation/variables.dart';

class ViewState {
final bool isState,
    table;
final num resultado;



const ViewState({this.isState = false,this.resultado = 0, this.table = false });
}
Variables variables = Variables();
class ViewController extends StateNotifier<ViewState> {
  ViewController([ViewState? state]) : super(const ViewState());


  setTable(){
    state = ViewState(table: !state.table);
  }
  setState(num valor) {
    state = ViewState(isState: !state.isState, resultado: valor);
  }
  resetState() {
    state = ViewState(isState: !state.isState, resultado: 0);
  }
  Reset(variables) {
    resetState();
    variables.parcList.clear();
    variables.amorList.clear();
    variables.dateList.clear();
    variables.jurosList.clear();
    variables.dataList.clear();
    variables.tirList.clear();
    variables.date = DateTime.now();
    variables.newDate = null;
    variables.tir = 0;
    variables.origin = null;
    variables.taxa = 0;
    variables.tarifa = 0;
    variables.periodo = null;
    variables.carencia = 0;
  }
}