import 'dart:convert' as convert;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../keys_utils.dart';
import 'mockup_currency.dart';

class ApiCurrencyState {
  bool? status;
  final List<Currency> currencysList;
  final List<String> inCoin;
  final List<String> forCoin;
  num result;

  ApiCurrencyState({
    this.result = 0,
    this.status = false,
    this.inCoin = const [],
    this.forCoin = const [],
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
        inCoin: state.inCoin,
        forCoin: state.forCoin,
        result: state.result,
        currencysList: state.currencysList,
        status: true,
      );
      return;
    } else {
      List<Currency> fetchedCurrencies = [];
      List<String> inCoinList = [];
      List<String> forCoinList = [];
      for (var i = 0; i < keys.currencyPairs.length; i++) {
        var response = await getCurrency(keys.currencyPairs[i].toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
          final lista = Currency.fromJson(
              keys.currencyPairs[i].toString().replaceAll("-", ""),
              jsonResponse);
          fetchedCurrencies.add(lista);
          //ficou invertido pra melhor entendimento do usuario, USD/BRL ficará BRL/USD.
          inCoinList.add(lista.Parity!.codein!.trim().toUpperCase());
          forCoinList.add(lista.Parity!.code!.trim().toUpperCase());
        } else {
          List<String> status = [];
          status.add('Sem Internet');
          state = ApiCurrencyState(
            inCoin: inCoinList,
            forCoin: forCoinList,
            currencysList: fetchedCurrencies,
            result: state.result,
            status: state.status,
          );
          print('sem internet');
        }
      }
      List<String> a = List.from(inCoinList.toSet());
      List<String> b = List.from(forCoinList.toSet());
      state = ApiCurrencyState(
        inCoin: a,
        forCoin: b,
        currencysList: fetchedCurrencies,
        result: state.result,
        status: state.status,
      );
    }
  }

  exchange(String inCoin, String forCoin, num value) async {
    List<Currency> fetchedCurrencies = await state.currencysList;
    num cotacao = 0;
    num resultado = 0;
    //Verificar se existe a cotação na lista de possibilidades
    String texto = inCoin+"-"+forCoin;
    String textoInvertido = forCoin +"-"+inCoin;
    if(keys.currencyPairs.contains(texto.toUpperCase())) {
      for (var i = 0; i < fetchedCurrencies.length; i++) {
        if (fetchedCurrencies[i].Parity!.code == inCoin &&
            fetchedCurrencies[i].Parity!.codein == forCoin) {
          cotacao = num.parse(fetchedCurrencies[i].Parity!.bid!);
        }
      }
      resultado = value * cotacao;
    }else if (keys.currencyPairs.contains(textoInvertido.toUpperCase())){
      for (var i = 0; i < fetchedCurrencies.length; i++) {
        if (fetchedCurrencies[i].Parity!.code == forCoin &&
            fetchedCurrencies[i].Parity!.codein == inCoin) {
          cotacao = num.parse(fetchedCurrencies[i].Parity!.bid!);
        }
      }
      resultado = value / cotacao;
    }else{
      resultado = -1;
    }
    state = ApiCurrencyState(
      inCoin: state.inCoin,
      forCoin: state.forCoin,
      currencysList: state.currencysList,
      result: resultado,
      status: state.status,
    );
  }

  List<String> getSuggestionsInCoin(String query) {
    List<String> coin = [];
    if (state.inCoin != null) {
      coin = state.inCoin;
      coin = Set.of(coin).toList();
    }
    coin.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return coin;
  }
  List<String> getSuggestionsForCoin(String query) {
    List<String> coin = [];
    if (state.forCoin != null) {
      coin = state.forCoin;
      coin = Set.of(coin).toList();
    }
    coin.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return coin;
  }
}