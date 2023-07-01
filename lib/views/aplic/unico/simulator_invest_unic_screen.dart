import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../src/controller/state_view.dart';
import '../../../src/keys_utils.dart';
import '../../../src/providers/stateview_provider.dart';
import '../../../src/providers/theme_provider.dart';
import 'detail_invest_unic_screen.dart';

class SimulatorAplUnicScreen extends ConsumerStatefulWidget {
  const SimulatorAplUnicScreen({Key? key}) : super(key: key);

  @override
  SimulatorAplUnicScreenState createState() => SimulatorAplUnicScreenState();
}

class SimulatorAplUnicScreenState
    extends ConsumerState<SimulatorAplUnicScreen> {
  static final _formKey = GlobalKey<FormState>();

  final controller = MoneyMaskedTextController(
      decimalSeparator: ",", thousandSeparator: ".", initialValue: 0.00);
  final conttx = MoneyMaskedTextController(
    decimalSeparator: ".",
    thousandSeparator: "",
  );

  final contper = TextEditingController();
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);


    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Simulador de Aplicações",
                  style: state.textTheme.bodySmall)),
        ),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
                height: _height,
                width: _width,
                color: state.primaryColor,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    color: state.primaryColor,
                    child: Center(
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: _height * 0.08,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Digite os dados abaixo : ",
                                        style: state.textTheme.displayLarge,
                                      )),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  SizedBox(
                                    height: _height * 0.05,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Valor do Investimento: R\$",
                                      style: state.textTheme.headlineMedium,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Stack(
                                      children: [
                                        Container(
                                          height: _height * 0.05,
                                          width: _width * 0.45,
                                          decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor,
                                          ),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            height: _height * 0.075,
                                            width: _width * 0.45,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Informe o valor da Aplicação";
                                                }
                                                return null;
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
                                                                  width: 1.0))),
                                              style: state.textTheme.titleMedium,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              onChanged: (value) {
                                                variables.dado = num.parse(value
                                                    .replaceAll(r'.', "")
                                                    .replaceAll(r',', '.'));
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              controller: controller,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Row(children: [
                                    Text("Taxa (a.m) : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.05,
                                          width: _width * 0.25,
                                          decoration: BoxDecoration(
                                            color: state
                                                .unselectedWidgetColor, //preto
                                          )),
                                      Center(
                                          child: SizedBox(
                                              height: _height * 0.075,
                                              width: _width * 0.25,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Taxa";
                                                  }
                                                  return null;
                                                },
                                                enabled:
                                                    viewState.enabled == true
                                                        ? true
                                                        : false,
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    errorStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'FuturaPTLight.otf',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        color: Colors.red),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.0))),
                                                style:
                                                    state.textTheme.titleMedium,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      5)
                                                ],
                                                textInputAction:
                                                    TextInputAction.next,
                                                onChanged: (value) {
                                                  variables.tx =
                                                      double.parse(value);
                                                  variables.taxa =
                                                      num.parse(value);
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: state.primaryColor,
                                                textAlign: TextAlign.center,
                                                controller: conttx,
                                              ))),
                                    ]),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Row(children: [
                                    Text("Número de meses: ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.03),
                                    Stack(
                                      children: [
                                        Container(
                                            height: _height * 0.05,
                                            width: _width * 0.15,
                                            decoration: BoxDecoration(
                                              color:
                                                  state.unselectedWidgetColor,
                                            )),
                                        Center(
                                            child: SizedBox(
                                                height: _height * 0.075,
                                                width: _width * 0.15,
                                                child: TextFormField(
                                                  enabled:
                                                      viewState.enabled == true
                                                          ? true
                                                          : false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Meses";
                                                    }
                                                    return null;
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
                                                  style:
                                                      state.textTheme.titleMedium,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        3)
                                                  ],
                                                  onChanged: (value) {
                                                    variables.periodo =
                                                        num.parse(value);
                                                  },
                                                  //ALTERAR BOTÃO DO TECLADO
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  onFieldSubmitted: (value) {
                                                    showInterstitialAd();
                                                    buttonClick(context);
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      state.primaryColor,
                                                  textAlign: TextAlign.center,
                                                  controller: contper,
                                                )))
                                      ],
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.05,
                                  ),
                                    SizedBox(
                                        width: _width,
                                        height: _height * 0.06,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      state.indicatorColor),
                                            ),
                                            child: Text("SIMULAR",
                                                style: state.textTheme.bodySmall),
                                            onPressed: () {
                                              showInterstitialAd();
                                              buttonClick(context);
                                            })),


                                ])))))));
  }

  buttonClick(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      variables.tx = variables.taxa.toDouble();
      variables.taxa = variables.taxa / 100;
      variables.liquido = variables.dado;
      for (var i = 0; i < variables.periodo; i++) {
        variables.liquido =
            variables.liquido + (variables.liquido * variables.taxa);
      }

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreenAplUnic(
                    dado: variables.dado,
                    taxa: variables.tx,
                    periodo: variables.periodo,
                    liquido: variables.liquido,
                  )));
    }
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Keys().idInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {

          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {

      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(

      onAdDismissedFullScreenContent: (InterstitialAd ad) {

        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {

        ad.dispose();
      },

    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }
}
