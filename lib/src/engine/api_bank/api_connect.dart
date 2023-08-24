import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../keys_utils.dart';
import 'mockup_bank.dart';

class ApiState {
  // A URL da API
  List<Bank>? banks; // = List<Bank>.empty(); // Lista dos bancos
  final List<String> banksList;
  final List<int> codeList;
  final Map<String, int> bancos;

  ApiState(
      {this.banks,
      this.banksList = const [],
      this.bancos = const {},
      this.codeList = const []});
}

class ApiController extends StateNotifier<ApiState> {
  ApiController([ApiState? state]) : super(ApiState());
 Keys keys = Keys();
  Future getBank(search) async {
    var url = keys.baseUrl + search;
    return await http.get(Uri.parse(url));
  }

  BankList() async {
    String search = ""; // Codigo do Banco
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final List<String> banksList = [];
      banksList.add("Select Bank");
      state = ApiState(
          banksList: banksList,
          banks: state.banks,
          bancos: state.bancos);
      return;
    } else {
      getBank(search).then((response) {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        if (response.statusCode == 200) {
          var banks = lista.map((model) => Bank.fromJson(model)).toList();
          final List<String> banksList = [];
          banksList.add("Particular");
          for (var i = 0; i < banks.length;) {
            if (banks[i].code == null) {
              i++;
            } else {
              String bank = banks[i].name!.toUpperCase().replaceAll('BCO', 'BANCO');
              banksList.add(bank);
              i++;
            }
          }
          print(banksList);
          banksList.sort((a, b) => a.compareTo(b));
          state = ApiState(
              banksList: banksList,
              banks: banks,
              );
        } else if (response.statusCode == 404) {
          List<String> banksList = [];
          banksList.add('Sem Internet');
          state = ApiState(
            banksList: banksList,
            banks: state.banks,
          );
          print('sem internet');
        } else if (response.statusCode == 500) {
          List<String> banksList = [];
          banksList.add('Sem Internet');
          state = ApiState(
            banksList: banksList,
            banks: state.banks,
          );
        }
      });
    }
  }

  List<String> getSuggestionsBanks(String query) {
    List<String> bank = [];
    if (state.banksList != null) {
      bank = state.banksList;
      bank = Set.of(bank).toList();
    }
    bank.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return bank;
  }
}
