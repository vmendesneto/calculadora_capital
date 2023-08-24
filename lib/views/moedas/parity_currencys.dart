import 'package:calculadora_capital/src/providers/api_currency_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../src/keys_utils.dart';

import '../../src/providers/theme_provider.dart';
import '../../consts/dialog_theme.dart';

class ParityScreen extends ConsumerStatefulWidget {
  const ParityScreen({Key? key}) : super(key: key);

  @override
  ParityScreenState createState() => ParityScreenState();
}

class ParityScreenState extends ConsumerState<ParityScreen> {
  Future? x;

  @override
  void initState() {
    final apiCont = ref.read(apiCurrencyProvider.notifier);
    x = apiCont.CurrencysList();
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
                    x = apiCont.CurrencysList();
                  });
                },
              ),
            ]),
        body: Container(
            margin: const EdgeInsets.only(top: 8, left: 2, right: 2),
            color: state.primaryColor,
            height: _height,
            width: _width,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: _height * 0.7,
                  width: _width,
                  child: FutureBuilder(
                      future: x,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.lightBlue));
                        } else {
                          return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemCount: viewState.currencysList.length,
                              itemBuilder: (BuildContext context, i) {
                                var outputFormat = DateFormat('dd/MM hh:mm');
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                                        viewState
                                            .currencysList[i].Parity!.createDate
                                            .toString());
                                var hora = outputFormat.format(parseDate);
                                var t = double.parse(viewState
                                    .currencysList[i].Parity!.varBid
                                    .toString());
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            viewState.currencysList[i].Parity!
                                                    .code
                                                    .toString() +
                                                "/" +
                                                viewState.currencysList[i]
                                                    .Parity!.codein
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                        Text(
                                            viewState
                                                .currencysList[i].Parity!.bid!
                                                .toString()
                                                .replaceAll(".", ","),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(hora,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          Text(
                                              t >= 0
                                                  ? "+${t.toString()}(+${viewState.currencysList[i].Parity!.pctChange}% )"
                                                  : "${t.toString()}(${viewState.currencysList[i].Parity!.pctChange}% )",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                        ])
                                  ],
                                );
                              });
                        }
                      })),
              SizedBox(
                height: _height * 0.05,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 320,
                  height: 100,
                  child: AdWidget(
                    ad: myBanner,
                  ),
                ),
              )
            ])));
  }
}

final BannerAd myBanner = BannerAd(
  adUnitId: Keys().idBanner,
  size: AdSize.largeBanner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);
