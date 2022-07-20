import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ calculation/variables.dart';

class ViewState {
  final bool isState, table, enabled, checkIof, checkIofAdc;
  final num resultado;

  const ViewState({
    this.isState = false,
    this.resultado = 0,
    this.table = false,
    this.enabled = true,
    this.checkIofAdc = true,
    this.checkIof = true,
  });
}

Variables variables = Variables();

class ViewController extends StateNotifier<ViewState> {
  ViewController([ViewState? state]) : super(const ViewState());

  setTable() {
    state = ViewState(
      table: !state.table,
    );
  }

  setState(num valor) {
    state = ViewState(
        isState: !state.isState,
        resultado: valor,
        enabled: !state.enabled,
        table: state.table);
  }

  resetState() {
    state = ViewState(isState: !state.isState, resultado: 0);
  }

  resetButton() {
    Reset(variables);
    state = const ViewState(isState: false, resultado: 0);
  }
iof(bool val){
    bool check = val;
state = ViewState(checkIof: check, isState: state.isState,table : state.table, enabled: state.enabled, checkIofAdc: state.checkIofAdc, resultado: state.resultado );
}

  iofAdc(bool val){
    bool check = val;
    state = ViewState(checkIof: state.checkIof, isState: state.isState,table : state.table, enabled: state.enabled, checkIofAdc: check, resultado: state.resultado );
  }

  Reset(variables) {
    resetState();
    variables.dataMap.clear();
    variables.daysList.clear();
    variables.check = false;
    variables.checkVenc = false;
    variables.parcList.clear();
    variables.amorList.clear();
    variables.dateList.clear();
    variables.jurosList.clear();
    variables.dataList.clear();
    variables.tirList.clear();
    variables.date = DateTime.now();
    variables.dado = 0.00;
    variables.dateVenc = DateTime.now();
    variables.newDate = null;
    variables.tir = 0;
    variables.totalJ = 0;
    variables.origin = null;
    variables.taxa = 0;
    variables.tarifa = 0;
    variables.periodo = 0;
    variables.carencia = 0;
    variables.emp = 0;
    variables.tx = 0.00;
    variables.validate = false;
    variables.itemSelecionado = 'Select Bank';
    state = const ViewState(enabled: true);
  }
}
