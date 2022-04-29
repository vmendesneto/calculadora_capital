import 'package:calculadora_capital/src/controller/tir_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controller/state_view.dart';
import 'variables.dart';


class SacState {
  final num encargos;
const SacState({this.encargos = 0});
}

class SacController extends StateNotifier<SacState> {




  SacController([SacState? state]) : super(const SacState());


  simulationSac() {

      var _liquido =
          variables.emp - variables.iof - variables.iofa - variables.tarifa;
      var _empTir = -(_liquido);
      variables.tirList.add(_empTir);
      variables.saldodevedor = variables.dado!;
      int i = 1;
      int c = 1;
      variables.result = 0;
      // variables.dateList
      //     .add(DateFormat("dd/MM/yyyy").format(DateTime.now()));
       variables.jurosList.add(0.00);
       variables.amorList.add(0.00);
       variables.parcList.add(0.00);
       variables.dataList.add(variables.emp);
       variables.dateList.add(DateFormat("dd/MM/yyyy").format(DateTime.now()));
      for (i; i <= variables.periodo!; i++) {
        variables.amortiza =
            (variables.emp / (variables.periodo! - variables.carencia));
        if (variables.carencia >= c) {
          variables.amortiza = 0;
          variables.juros = variables.saldodevedor * variables.taxa;
          variables.saldodevedor = variables.saldodevedor;
          variables.dado = variables.saldodevedor;
          variables.dataList.add(variables.saldodevedor);
          variables.jurosList.add(variables.juros!);
          variables.amorList.add(variables.amortiza);
          variables.newDate = DateTime(variables.date.year,
              variables.date.month + 1, variables.date.day);
          variables.date = variables.newDate!;
          variables.dateList
              .add(DateFormat("dd/MM/yyyy").format(variables.newDate!));
          variables.parcela = variables.juros!;
          variables.parcList.add(variables.parcela);
          variables.tirList.add(variables.parcela);
          variables.totalP = variables.totalP + variables.parcela;
          c++;
        } else {
          variables.amorList.add(variables.amortiza);
          variables.juros = variables.saldodevedor * variables.taxa;
          variables.saldodevedor = variables.saldodevedor - variables.amortiza;
          variables.dado = variables.saldodevedor;
          variables.jurosList.add(variables.juros!);
          variables.parcela = variables.juros! + variables.amortiza;
          variables.result = variables.result + variables.parcela;
          variables.tirList.add(variables.parcela);
          variables.parcList.add(variables.parcela);
          variables.dataList.add(variables.saldodevedor);
          variables.newDate = DateTime(variables.date.year,
              variables.date.month + 1, variables.date.day);
          variables.date = variables.newDate!;
          variables.dateList
              .add(DateFormat("dd/MM/yyyy").format(variables.newDate!));
          variables.totalP = variables.totalP + variables.parcela;

          variables.parcList = variables.parcList;
          variables.amorList = variables.amorList;
          variables.dateList = variables.dateList;
          variables.jurosList = variables.jurosList;
          variables.dataList = variables.dataList;
        }
      }
    variables.tir = (tirController.irr(values: variables.tirList) * 100);
      var encargo = variables.iof + variables.iofa + variables.tarifa;
    state = SacState(encargos: encargo);
    print(variables.result);
    print(variables.jurosList);
  }
}
