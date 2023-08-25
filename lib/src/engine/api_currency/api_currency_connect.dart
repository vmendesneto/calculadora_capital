import 'dart:convert' as convert;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../keys_utils.dart';
import 'mockup_currency.dart';

class ApiCurrencyState {
  // A URL da API
  List<String>? status; // = List<Bank>.empty(); // Lista dos bancos
  final List<Currency> currencysList;


  ApiCurrencyState({
    this.status,
    this.currencysList = const [],
  });
}

class ApiCurrencyController extends StateNotifier<ApiCurrencyState> {
  ApiCurrencyController([ApiCurrencyState? state]) : super(ApiCurrencyState());
  Keys keys = Keys();

  Future getCurrency(String pair) async {
    var url = keys.baseUrlCurrency + pair;
    return await http.get(Uri.parse(url));
  }

  CurrencysList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = ApiCurrencyState(
        currencysList: state.currencysList,
        status: state.status,

      );
      return;
    } else {
      List<Currency> fetchedCurrencies = [];
      for (var i = 0; i < keys.currencyPairs.length; i++) {
        var response = await getCurrency(keys.currencyPairs[i].toString());
        if (response.statusCode == 200) {
          Map<String,dynamic> jsonResponse = convert.jsonDecode(response.body);
          final lista = Currency.fromJson(keys.currencyPairs[i].toString().replaceAll("-", ""),jsonResponse);
          fetchedCurrencies.add(lista);
        } else if (response.statusCode == 404) {
          List<String> status = [];
          status.add('Sem Internet');
          state = ApiCurrencyState(
            currencysList: state.currencysList,
            status: status,

          );
          print('sem internet');
        } else if (response.statusCode == 500) {
          List<String> status = [];
          status.add('Sem Internet');
          state = ApiCurrencyState(
            currencysList: state.currencysList,
            status: status,

          );
        }
      }

      print("FINALIZADO API COTAÇÕES");
      state = ApiCurrencyState(
          currencysList: fetchedCurrencies,
          status: state.status,

      );

    }
  }
}
