import 'package:calculadora_capital/src/controller/tir_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/state_view.dart';

class PriceState {
  final num encargos;

  const PriceState({this.encargos = 0});
}

class PriceController extends StateNotifier<PriceState> {
  PriceController([PriceState? state]) : super(const PriceState());

  simulationPrice() {
    variables.liquido =
        variables.emp - variables.iof - variables.iofa - variables.tarifa;
    var _empTir = -(variables.liquido);
    variables.tirList.add(_empTir);
    variables.saldodevedor = variables.dado!;
    int i = 0;
    int c = 1;
    int h = 1;
    variables.jurosList.add(0.00);
    variables.amorList.add(0.00);
    variables.parcList.add(0.00);
    variables.dataList.add(variables.emp);
    variables.dateList.add(DateFormat("dd/MM/yyyy").format(DateTime.now()));
    var elevado = (1 + variables.taxa);
    for (h; h < (variables.periodo! - variables.carencia); h++) {
      elevado = elevado * (1 + variables.taxa);
    }
    var price = variables.emp * ((elevado * variables.taxa) / (elevado - 1));
    for (i; i < variables.periodo!; i++) {
      if (variables.carencia >= c) {
        variables.amortiza = 0;
        variables.juros = variables.saldodevedor * variables.taxa;
        variables.saldodevedor = variables.saldodevedor;
        variables.dado = variables.saldodevedor;
        variables.dataList.add(variables.saldodevedor);
        variables.jurosList.add(variables.juros!);
        variables.amorList.add(variables.amortiza);
        variables.newDate =
            DateTime(variables.date.year, variables.date.month + 1,
                variables.date.day);
        variables.date = variables.newDate!;
        variables.dateList
            .add(DateFormat("dd/MM/yyyy").format(variables.date));
        variables.parcela = variables.juros!;
        variables.parcList.add(variables.parcela);
        variables.tirList.add(variables.parcela);
        variables.totalP = variables.totalP + variables.parcela;
        variables.totalJ = variables.totalJ + variables.juros!;
        c++;
      } else {
        variables.juros = variables.saldodevedor * variables.taxa;
        variables.amortiza = (price - variables.juros!);
        variables.amorList.add(variables.amortiza);
        variables.saldodevedor = variables.saldodevedor - variables.amortiza;
        variables.dado = variables.saldodevedor;
        variables.jurosList.add(variables.juros!);
        variables.parcela = variables.juros! + variables.amortiza;
        variables.result = variables.result + variables.parcela;
        variables.tirList.add(variables.parcela);
        variables.parcList.add(variables.parcela);
        variables.dataList.add(variables.saldodevedor);
        variables.newDate =
            DateTime(variables.date.year, variables.date.month + 1,
                variables.date.day);
        variables.date = variables.newDate!;
        variables.dateList
            .add(DateFormat("dd/MM/yyyy").format(variables.date));
        variables.totalP = variables.totalP + variables.parcela;
        variables.totalJ = variables.totalJ + variables.juros!;
      }
    }
    variables.tir = (tirController.irr(values: variables.tirList) * 100);
    var encargo = variables.iof + variables.iofa + variables.tarifa;
    state = PriceState(encargos: encargo);
  }
}