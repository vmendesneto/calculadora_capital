import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ calculation/variables.dart';

class DescViewState {
  final bool isState, table, enabled;
  final num resultado;


   DescViewState({
    this.isState = false,
    this.resultado = 0,
    this.table = false,
    this.enabled = true,
  });
}

Variables variables = Variables();

class DescViewController extends StateNotifier<DescViewState> {
  DescViewController([DescViewState? state]) : super( DescViewState());

  TextEditingController dateCtl = TextEditingController();

  descReset(variables){

    variables.dado = 0.00;
    if(variables.check == false){
      variables.tx = 0.00;
    }
    if(variables.checkVenc == false){
      dateCtl.text = "";
      variables.dateVenc = DateTime.now();
    }
  }


}
