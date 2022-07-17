
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'mockup_bank.dart';

class ApiState {
  // A URL da API
  final baseUrl;
  List<Bank>? banks; // = List<Bank>.empty(); // Lista dos bancos
  final List<String> banksList;
  final List<String> codeList;

  ApiState(
      {this.banks,
      this.baseUrl = "https://brasilapi.com.br/api/banks/v1",
      this.banksList = const [],
      this.codeList = const []});
}

class ApiController extends StateNotifier<ApiState> {
  ApiController([ApiState? state]) : super(ApiState());

  Future getBank(search) async {
    //const site = "https://brasilapi.com.br/api/banks/v1";
    List<Bank> bank = List<Bank>.empty();
    var url = state.baseUrl + search;
    print(url);
    //state = ApiState(baseUrl: site);
    return await http.get(Uri.parse(url));
  }

  BankList() {
    String search = ""; // Codigo do Banco
    getBank(search).then((response) {
      Iterable lista = json.decode(response.body); // Usamos um iterator
      if (response.statusCode == 200) {
        var banks = lista.map((model) => Bank.fromJson(model)).toList();
        //banks.sort((Bank a, Bank b) => a.fullName!.compareTo(b.fullName!));
        print(banks.length);
        final List<String> codeList = [];
        final List<String> banksList = [];
        banksList.add("Select Bank");
        for (var i = 0; i < banks.length; i++) {
          banksList.add(banks[i].name!);
          codeList.add(banks[i].code.toString());
        }
        state = ApiState(banksList: banksList, codeList: codeList, baseUrl: state.baseUrl, banks: banks);
        // state = ApiState(
        //     banks: banks,
        //     baseUrl: state.baseUrl,
        //     banksList: banksList,
        //     codeList: state.codeList);
      }else if(response.statusCode == 404){
        print('sem internet');
      }else if(response.statusCode == 500){
        print('sem internet');
      }
    });
  }
}

