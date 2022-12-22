import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../keys_utils.dart';
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
    List<Bank> bank = List<Bank>.empty();
    var url = keys.baseUrl + search;
    return await http.get(Uri.parse(url));
  }

  BankList() async {
    String search = ""; // Codigo do Banco
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final List<int> codeList = [];
      final List<String> banksList = [];
      banksList.add("Select Bank");
      codeList.add(0);
      state = ApiState(
          banksList: banksList,
          codeList: codeList,
          banks: state.banks,
          bancos: state.bancos);
      return;
    } else {
      getBank(search).then((response) {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        if (response.statusCode == 200) {
          var banks = lista.map((model) => Bank.fromJson(model)).toList();
          //banks.sort((Bank a, Bank b) => a.fullName!.compareTo(b.fullName!));
          final List<int> codeList = [];
          final List<String> banksList = [];
          banksList.add("Select Bank");
          codeList.add(0);
          for (var i = 0; i < banks.length;) {
            if (banks[i].code == null) {
              i++;
            } else {
              banksList.add(banks[i].name!);
              codeList.add(banks[i].code!);
              i++;
            }
          }
          Map<String, int> novo = Map.fromIterables(banksList, codeList);
          banksList.sort((a, b) => a.compareTo(b));
          state = ApiState(
              banksList: banksList,
              codeList: codeList,
              banks: banks,
              bancos: novo);
        } else if (response.statusCode == 404) {
          print('sem internet');
        } else if (response.statusCode == 500) {
          print('sem internet');
        }
      });
    }
  }
}
