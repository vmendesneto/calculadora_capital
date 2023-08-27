import 'package:calculadora_capital/views/desc/desc_screen.dart';
import 'package:calculadora_capital/views/emp/home_emp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../src/keys_utils.dart';
import '../src/providers/api_currency_provider.dart';
import '../src/providers/api_provider.dart';
import '../src/providers/stateview_provider.dart';
import '../src/providers/theme_provider.dart';
import '../consts/dialog_theme.dart';
import 'aplic/home_aplic.dart';
import 'markup/markup_screen.dart';
import 'moedas/parity_currencys.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    final apiController = ref.read(apiProvider.notifier);
    apiController.BankList();
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider.notifier);
    final vState = ref.watch(apiProvider);
    final apiController = ref.read(apiProvider.notifier);
    final apiCurrState = ref.watch(apiCurrencyProvider);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: state.hoverColor,
            iconTheme: IconThemeData(color: state.primaryColor),
            title: Center(
                child: Text("CalculoFacil",
                    style: state.textTheme.bodySmall)),
            actions: [
              PopupMenuButton(
                  color: state.primaryColor,
                  elevation: 20,
                  enabled: true,
                  onSelected: (value) {
                    setState(() {
                      Navigator.of(context)
                          .push(showThemeChangerDialog(context));
                      // : Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const ConfigScreen()));
                    });
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "Trocar o Tema",
                            style: TextStyle(
                                color: state.unselectedWidgetColor,
                                fontSize: 10),
                          ),
                          value: 1,
                        ),
                        // PopupMenuItem(
                        //   child:  Text(
                        //     "Configurações",
                        //     style: TextStyle(color: state.unselectedWidgetColor, fontSize: 10),
                        //   ),
                        //   value: 2,
                        // ),
                      ])
            ]),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              color: state.primaryColor,
              height: _height,
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        viewState.resetButton();
                        vState.status == true ? apiController.BankList():Container();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePageEmp()));
                      },
                      child: SizedBox(
                          height: _height * 0.13,
                          width: _width * 0.9,
                          child: Card(
                            elevation: 20,
                            color: state.indicatorColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.attach_money_outlined,
                                  color: state.primaryColor,
                                ),
                                Text(
                                  "Emprestimo",
                                  style: state.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        viewState.resetButton();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DescScreen()));
                      },
                      child: SizedBox(
                          height: _height * 0.13,
                          width: _width * 0.9,
                          child: Card(
                            elevation: 20,
                            color: state.indicatorColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.money_off,
                                  color: state.primaryColor,
                                ),
                                Text(
                                  "Desc. Titulos",
                                  style: state.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        viewState.resetButton();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MarkupScreen()));
                      },
                      child: SizedBox(
                          height: _height * 0.13,
                          width: _width * 0.9,
                          child: Card(
                            elevation: 20,
                            color: state.indicatorColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.point_of_sale_outlined,
                                  color: state.primaryColor,
                                ),
                                Text(
                                  "Preço de Venda",
                                  style: state.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        viewState.resetButton();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePageAplic()));
                      },
                      child: SizedBox(
                          height: _height * 0.13,
                          width: _width * 0.9,
                          child: Card(
                            elevation: 20,
                            color: state.indicatorColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: state.primaryColor,
                                ),
                                Text(
                                  "Aplicação",
                                  style: state.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        viewState.resetButton();
                        apiCurrState.result = "0.00";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParityScreen()));
                      },
                      child: SizedBox(
                          height: _height * 0.13,
                          width: _width * 0.9,
                          child: Card(
                            elevation: 20,
                            color: state.indicatorColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: state.primaryColor,
                                ),
                                Text(
                                  "Cotações de Moedas",
                                  style: state.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.transparent,
                      width: 320,
                      height: 100,
                      child: AdWidget(
                        ad: myBanner,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: Keys().idBanner,
    size: AdSize.largeBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
}
