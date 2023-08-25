import 'package:calculadora_capital/src/providers/api_currency_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  setState(() {
                    initial = apiCont.CurrencysList();
                  });
                },
              ),
            ]),
        body: SingleChildScrollView(
        physics: const ScrollPhysics(),
    child: Container(
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            color: state.primaryColor,
            height: _height,
            width: _width,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: _height * 0.72,
                  width: _width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: state.hoverColor, width: 2.0))),
                  child: FutureBuilder(
                      future: initial,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: state.hoverColor));
                        } else {
                          return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                        color: state.hoverColor,
                                      ),
                              itemCount: viewState.currencysList.length,
                              itemBuilder: (BuildContext context, i) {
                                var outputFormat = DateFormat('dd/MM HH:mm');
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        viewState
                                            .currencysList[i].Parity!.createDate
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
                                                      viewState.currencysList[i]
                                                              .Parity!.code
                                                              .toString() +
                                                          "/" +
                                                          viewState
                                                              .currencysList[i]
                                                              .Parity!
                                                              .codein
                                                              .toString(),
                                                      style: state.textTheme
                                                          .labelMedium),
                                                  Text(
                                                      viewState.currencysList[i]
                                                          .Parity!.bid!
                                                          .toString()
                                                          .replaceAll(".", ","),
                                                      style: state.textTheme
                                                          .labelMedium),
                                                ],
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(hora,
                                                        style: state.textTheme
                                                            .labelMedium),
                                                    change >=
                                                            0
                                                        ? Text(
                                                            "+${change.toString()}(+${viewState.currencysList[i].Parity!.pctChange}% )",
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors
                                                                        .green,
                                                                fontSize: 14))
                                                        : Text(
                                                            "${change.toString()}(${viewState.currencysList[i].Parity!.pctChange}% )",
                                                            style:
                                                                const TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                    fontSize:
                                                                        14)),
                                                  ]),
                                            ],
                                          ))),
                                  id == i ? details(ref, i) : Container()
                                ]);
                              });
                        }
                      })),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: _width * 0.9,
                  height: _height * 0.15,
                  child: AdWidget(
                    ad: myBanner,
                  ),
                ),
              )
            ]))));
  }
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
