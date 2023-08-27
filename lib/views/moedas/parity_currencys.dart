import 'package:calculadora_capital/src/providers/api_currency_provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../src/keys_utils.dart';

import '../../src/providers/theme_provider.dart';

class ParityScreen extends ConsumerStatefulWidget {
  const ParityScreen({Key? key}) : super(key: key);

  @override
  ParityScreenState createState() => ParityScreenState();
}

class ParityScreenState extends ConsumerState<ParityScreen> {
  Future? initial;
  int id = -1;
  final inCoinCont = TextEditingController();
  final forCoinCont = TextEditingController();
  final controller = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  num? valor;

  @override
  void initState() {
    final apiCont = ref.read(apiCurrencyProvider.notifier);
    initial = apiCont.CurrencysList();
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(apiCurrencyProvider);
    final apiCont = ref.watch(apiCurrencyProvider.notifier);

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
            backgroundColor: state.hoverColor,
            iconTheme: IconThemeData(color: state.primaryColor),
            title: Center(
                child: Text("Cotações em Tempo Real",
                    style: state.textTheme.bodySmall)),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  inCoinCont.text = "";
                  forCoinCont.text = "";
                  controller.text = "0.00";
                  viewState.result = 0.00;
                  viewState.status = false;
                  setState(() {
                    initial = apiCont.CurrencysList();
                  });
                },
              ),
            ]),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
              color: state.primaryColor,
              height: _height,
              width: _width,
              child: FutureBuilder(
                  future: initial,
                  builder: (context, snapshot) {
                    if(viewState.status == true){
                      return Center(
                          child: Text("Verifique a conexão de Intenret", style: state.textTheme.labelMedium,
                              ));
                    }else{
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: state.hoverColor));
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: _height * 0.3,
                                width: _width,
                                color: Colors.green,
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(children: [
                                            Text(
                                              "De : ",
                                              style:
                                                  state.textTheme.labelMedium,
                                            ),
                                            SizedBox(
                                              height: _height * 0.01,
                                            ),
                                            Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 200),
                                                height: _height * 0.05,
                                                width: _width * 0.3,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: state
                                                      .unselectedWidgetColor,
                                                ),
                                                child: TypeAheadFormField(
                                                    textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0.0),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      style: state.textTheme
                                                          .titleMedium,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            3)
                                                      ],
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      cursorColor:
                                                          state.primaryColor,
                                                      controller: inCoinCont,
                                                    ),
                                                    suggestionsBoxDecoration:
                                                        const SuggestionsBoxDecoration(
                                                      color: Colors.lightBlue,
                                                    ),
                                                    suggestionsCallback:
                                                        (pattern) async {
                                                      return await apiCont
                                                          .getSuggestionsForCoin(
                                                              pattern);
                                                    },
                                                    transitionBuilder: (context,
                                                        suggestionsBox,
                                                        controller) {
                                                      return suggestionsBox;
                                                    },
                                                    itemBuilder:
                                                        (context, suggestion) {
                                                      return ListTile(
                                                        title: Text(suggestion
                                                            .toString()),
                                                      );
                                                    },
                                                    onSuggestionSelected:
                                                        (suggestion) {
                                                      inCoinCont.text =
                                                          suggestion.toString();

                                                    })),
                                          ]),
                                          Column(children: [
                                            Text(
                                              "Para : ",
                                              style:
                                                  state.textTheme.labelMedium,
                                            ),
                                            SizedBox(
                                              height: _height * 0.01,
                                            ),
                                            Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 200),
                                                height: _height * 0.05,
                                                width: _width * 0.3,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: state
                                                      .unselectedWidgetColor,
                                                ),
                                                child: TypeAheadFormField(
                                                    textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0.0),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      style: state.textTheme
                                                          .titleMedium,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            3)
                                                      ],
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      cursorColor:
                                                          state.primaryColor,
                                                      controller: forCoinCont,
                                                    ),
                                                    suggestionsBoxDecoration:
                                                        const SuggestionsBoxDecoration(
                                                      color: Colors.lightBlue,
                                                    ),
                                                    suggestionsCallback:
                                                        (pattern) async {
                                                      return await apiCont
                                                          .getSuggestionsForCoin(
                                                              pattern);
                                                    },
                                                    transitionBuilder: (context,
                                                        suggestionsBox,
                                                        controller) {
                                                      return suggestionsBox;
                                                    },
                                                    itemBuilder:
                                                        (context, suggestion) {
                                                      return ListTile(
                                                        title: Text(suggestion
                                                            .toString()),
                                                      );
                                                    },
                                                    onSuggestionSelected:
                                                        (suggestion) {
                                                      forCoinCont.text =
                                                          suggestion.toString();

                                                    })),
                                          ]),
                                        ]),
                                    SizedBox(
                                      height: _height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Valor : ",
                                          style: state.textTheme.labelMedium,
                                        ),
                                        SizedBox(
                                          width: _width * 0.01,
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: _height * 0.05,
                                              width: _width * 0.45,
                                              decoration: BoxDecoration(
                                                color:
                                                    state.unselectedWidgetColor,
                                              ),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                height: _height * 0.06,
                                                width: _width * 0.45,
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Informe o valor";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    valor = num.parse(controller
                                                        .text
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                                  },
                                                  decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'FuturaPTLight.otf',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.red),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.0))),
                                                  style: state
                                                      .textTheme.titleMedium,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  cursorColor:
                                                      state.primaryColor,
                                                  textAlign: TextAlign.center,
                                                  controller: controller,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Container(
                                      height: _height * 0.05,
                                      width: _width * 0.6,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (inCoinCont.text.length >= 3 &&
                                              forCoinCont.text.length >= 3) {
                                            if (inCoinCont.text.toUpperCase() ==
                                                forCoinCont.text.toUpperCase()) {
                                              showAlertDialog(context, state,
                                                  "MOEDAS SELECIONADAS SÃO IGUAIS.");
                                            } else if (controller.text
                                                    .replaceAll(r'.', "") ==
                                                "0,00") {
                                              showAlertDialog(context, state,
                                                  "VALOR INVÁLIDO.");
                                            }
                                            // else if(!viewState.inCoin.contains(inCoinCont.text.toUpperCase()) || !viewState.forCoin.contains(forCoinCont.text.toUpperCase())){
                                            //   showAlertDialog(context, state,
                                            //       "CAMPO MOEDA VAZIO OU INVÁLIDO.");
                                            // }
                                            else {
                                              valor = num.parse(controller.text
                                                  .replaceAll(r'.', "")
                                                  .replaceAll(r',', '.'));
                                              await apiCont.exchange(
                                                  inCoinCont.text.toUpperCase(),
                                                  forCoinCont.text.toUpperCase(),
                                                  valor!);
                                            }
                                          } else {
                                            showAlertDialog(context, state,
                                                "CAMPO MOEDA VAZIO OU INVÁLIDO.");
                                          }
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Calcular",
                                          style: state.textTheme.labelMedium,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Resultado : ",
                                          style: state.textTheme.labelMedium,
                                        ),
                                        SizedBox(
                                          width: _width * 0.01,
                                        ),
                                        viewState.result ==-1 ? Text("Cotação Indisponivel",style: state.textTheme.labelMedium,)
                                         :Text(
                                          viewState.result.toStringAsFixed(2).replaceAll(r'.', ','),
                                          style: state.textTheme.labelMedium,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.only(
                                  top: 2,
                                ),
                                height: _height * 0.42,
                                width: _width,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: state.hoverColor,
                                            width: 2.0),
                                        bottom: BorderSide(
                                            color: state.hoverColor,
                                            width: 2.0))),
                                child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(
                                              color: state.hoverColor,
                                            ),
                                    itemCount: viewState.currencysList.length,
                                    itemBuilder: (BuildContext context, i) {
                                      var outputFormat =
                                          DateFormat('dd/MM HH:mm');
                                      DateTime parseDate =
                                          DateFormat("yyyy-MM-dd HH:mm:ss")
                                              .parse(viewState.currencysList[i]
                                                  .Parity!.createDate
                                                  .toString());
                                      var hora = outputFormat.format(parseDate);
                                      var change = double.parse(viewState
                                          .currencysList[i].Parity!.varBid
                                          .toString());
                                      return Column(children: [
                                        Container(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (id == -1) {
                                                      id = i;
                                                    } else {
                                                      id = -1;
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            viewState
                                                                    .currencysList[
                                                                        i]
                                                                    .Parity!
                                                                    .code
                                                                    .toString() +
                                                                "/" +
                                                                viewState
                                                                    .currencysList[
                                                                        i]
                                                                    .Parity!
                                                                    .codein
                                                                    .toString(),
                                                            style: state
                                                                .textTheme
                                                                .labelMedium),
                                                        Text(
                                                            viewState
                                                                .currencysList[
                                                                    i]
                                                                .Parity!
                                                                .bid!
                                                                .toString()
                                                                .replaceAll(
                                                                    ".", ","),
                                                            style: state
                                                                .textTheme
                                                                .labelMedium),
                                                      ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(hora,
                                                              style: state
                                                                  .textTheme
                                                                  .labelMedium),
                                                          change >= 0
                                                              ? Text(
                                                                  "+${change.toString()}(+${viewState.currencysList[i].Parity!.pctChange}% )",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          14))
                                                              : Text(
                                                                  "${change.toString()}(${viewState.currencysList[i].Parity!.pctChange}% )",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          14)),
                                                        ]),
                                                  ],
                                                ))),
                                        id == i ? details(ref, i) : Container()
                                      ]);
                                    })),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.transparent,
                                width: _width * 0.9,
                                height: _height * 0.15,
                                child: AdWidget(
                                  ad: myBanner,
                                ),
                              ),
                            )
                          ]);
                    }
                  }}),
            )));
  }
}

showAlertDialog(BuildContext context, state, String message) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: state.primaryColor,
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: state.textTheme.subtitle2,
          )),
        );
      });
}

details(ref, int i) {
  final viewState = ref.watch(apiCurrencyProvider);
  final state = ref.watch(themeProvider);
  return Container(
      //height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: state.hoverColor),
        color: state.unselectedWidgetColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(viewState.currencysList[i].Parity!.name.toString(),
                  style: state.textTheme.titleMedium),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Minima : ${viewState.currencysList[i].Parity!.low.toString().replaceAll(".", ",")}",
                  style: state.textTheme.titleMedium),
              Text(
                  "Compra : ${viewState.currencysList[i].Parity!.bid.toString().replaceAll(".", ",")}",
                  style: state.textTheme.titleMedium),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                "Maxima : ${viewState.currencysList[i].Parity!.high.toString().replaceAll(".", ",")}",
                style: state.textTheme.titleMedium),
            Text(
                "Venda : ${viewState.currencysList[i].Parity!.ask.toString().replaceAll(".", ",")}",
                style: state.textTheme.titleMedium),
          ])
        ],
      ));
}

final BannerAd myBanner = BannerAd(
  adUnitId: Keys().idBanner,
  size: AdSize.largeBanner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);
