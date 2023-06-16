import 'package:calculadora_capital/src/%20calculation/loan_calculation/iof_value.dart';
import 'package:calculadora_capital/src/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../src/controller/state_view.dart';
import '../../src/keys_utils.dart';
import '../../src/providers/price_provider.dart';
import '../../src/providers/sac_provider.dart';
import '../../src/providers/stateview_provider.dart';
import '../../src/providers/theme_provider.dart';
import 'detail_screen.dart';

class SimulatorScreen extends ConsumerStatefulWidget {
  const SimulatorScreen({Key? key}) : super(key: key);

  @override
  SimulatorScreenState createState() => SimulatorScreenState();
}

class SimulatorScreenState extends ConsumerState<SimulatorScreen> {
  static final _formKey = GlobalKey<FormState>();

  final controller = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  final conttx = MoneyMaskedTextController(
    decimalSeparator: ".",
    thousandSeparator: "",
  );

  final conttar = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
  );

  final contper = TextEditingController();

  final contcar = TextEditingController();
  InterstitialAd? _interstitialAd;
  final bankController = TextEditingController();

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
    final viewStateController = ref.read(stateViewProvider.notifier);
    final calculate = ref.watch(sacProvider.notifier);
    final calculateP = ref.watch(priceProvider.notifier);
    final api = ref.watch(apiProvider.notifier);
    int validationCarencia = 0;
    int validationPeriodo = 0;
    num validationEmprestimo = 0.00;
    num validationTarifas = 0.00;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Simulador de Empréstimo",
                  style: state.textTheme.bodySmall)),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
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
                                    height: _height * 0.01,
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
                                  Row(children: [
                                    Text(
                                      "Banco :",
                                      style: state.textTheme.headlineMedium,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        height: _height * 0.05,
                                        width: _width * 0.65,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: state.unselectedWidgetColor,
                                        ),
                                        child: TypeAheadFormField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              onChanged: (value) {
                                                variables.itemSelecionado =
                                                    value;
                                              },
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0.0),
                                                isDense: true,
                                                border: InputBorder.none,
                                              ),
                                              style:
                                                  state.textTheme.titleMedium,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    32)
                                              ],
                                              textInputAction:
                                                  TextInputAction.next,
                                              cursorColor: state.primaryColor,
                                              controller: bankController,
                                            ),
                                            suggestionsBoxDecoration:
                                                const SuggestionsBoxDecoration(
                                              color: Colors.lightBlue,
                                            ),
                                            suggestionsCallback:
                                                (pattern) async {
                                              return await api
                                                  .getSuggestionsBanks(pattern);
                                            },
                                            transitionBuilder: (context,
                                                suggestionsBox, controller) {
                                              return suggestionsBox;
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                title:
                                                    Text(suggestion.toString()),
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              bankController.text =
                                                  suggestion.toString();
                                              variables.itemSelecionado =
                                                  suggestion.toString();
                                            })),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            child: Row(children: [
                                          Checkbox(
                                              value: viewState.checkIof,
                                              onChanged: (val) {
                                                setState(() {
                                                  viewStateController.iof(val!);
                                                });
                                              }),
                                          Text(
                                            "Incluir IOF (0,0041%) ? ",
                                            style:
                                                state.textTheme.headlineMedium,
                                          ),
                                        ])),
                                        Container(
                                            child: Row(children: [
                                          Checkbox(
                                              value: viewState.checkIofAdc,
                                              onChanged: (val) {
                                                setState(() {
                                                  viewStateController
                                                      .iofAdc(val!);
                                                });
                                              }),
                                          Text(
                                            "Incluir IOF Adic. (0,38%) ? ",
                                            style:
                                                state.textTheme.headlineMedium,
                                          )
                                        ])),
                                      ]),
                                  SizedBox(
                                    height: _height * 0.01,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Valor do Empréstimo : R\$",
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
                                            height: _height * 0.06,
                                            width: _width * 0.45,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Informe o valor do empréstimo";
                                                }
                                                return null;
                                              },
                                              enabled: viewState.enabled == true
                                                  ? true
                                                  : false,
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
                                              style:
                                                  state.textTheme.titleMedium,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                variables.dado = num.parse(value
                                                    .replaceAll(r'.', "")
                                                    .replaceAll(r',', '.'));
                                                variables.emp = num.parse(value
                                                    .replaceAll(r'.', "")
                                                    .replaceAll(r',', '.'));
                                                variables.origin = num.parse(
                                                    value
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
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
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Taxa (a.m) : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.06,
                                          width: _width * 0.25,
                                          decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor,
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
                                                  variables.taxa =
                                                      num.parse(value);
                                                  variables.tx =
                                                      double.parse(value);
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
                                  Row(children: [
                                    Text("Outras Despesas : R\$   ",
                                        style: state.textTheme.headlineMedium),
                                    Container(
                                        height: _height * 0.05,
                                        width: _width * 0.4,
                                        decoration: BoxDecoration(
                                          color: state.unselectedWidgetColor,
                                        ),
                                        child: TextFormField(
                                          enabled: viewState.enabled == true
                                              ? true
                                              : false,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(9)
                                          ],
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: conttar,
                                        )),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Parcelas (mes): ",
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
                                                height: _height * 0.06,
                                                width: _width * 0.15,
                                                child: TextFormField(
                                                  enabled:
                                                      viewState.enabled == true
                                                          ? true
                                                          : false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Parcelas";
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
                                                  style: state
                                                      .textTheme.titleMedium,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        3)
                                                  ],
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onChanged: (value) {
                                                    variables.periodo =
                                                        num.parse(value);
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
                                    SizedBox(width: _width * 0.011),
                                    Text("Carência (mes): ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.03),
                                    Container(
                                        height: _height * 0.05,
                                        width: _width * 0.15,
                                        decoration: BoxDecoration(
                                          color: state.unselectedWidgetColor,
                                        ),
                                        child: SizedBox(
                                            height: _height * 0.06,
                                            width: _width * 0.15,
                                            child: TextFormField(
                                              enabled: viewState.enabled == true
                                                  ? true
                                                  : false,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              style:
                                                  state.textTheme.titleMedium,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    3)
                                              ],
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (value) {
                                                validationCarencia = contcar
                                                            .text ==
                                                        ""
                                                    ? 0
                                                    : int.parse(contcar.text);
                                                validationEmprestimo =
                                                    variables.dado;
                                                validationPeriodo = int.parse(
                                                    variables.periodo
                                                        .toString());
                                                validationTarifas = conttar
                                                            .text ==
                                                        ""
                                                    ? 0
                                                    : num.parse(conttar.text
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                                if (validationCarencia >
                                                    validationPeriodo) {
                                                  return showAlertDialog(
                                                      context,
                                                      state,
                                                      viewStateController,
                                                      "CARÊNCIA NÃO PODE SER MAIOR OU IGUAL QUE PARCELAS.");
                                                } else if (validationTarifas >
                                                    validationEmprestimo) {
                                                  return showAlertDialog(
                                                      context,
                                                      state,
                                                      viewStateController,
                                                      "OUTRAS DESPESAS NÃO PODE SER MAIOR OU IGUAL A EMPRÉSTIMO.");
                                                } else {
                                                  if (!_formKey.currentState!
                                                      .validate()) {
                                                    return;
                                                  } else {
                                                    showInterstitialAd();
                                                    buttonClick(
                                                        context,
                                                        state,
                                                        viewStateController,
                                                        controller,
                                                        viewState,
                                                        calculate,
                                                        calculateP,
                                                        contcar,
                                                        conttar,
                                                        bankController);
                                                  }
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              controller: contcar,
                                            ))),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      width: _width,
                                      height: _height * 0.07,
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
                                            validationCarencia =
                                                contcar.text == ""
                                                    ? 0
                                                    : int.parse(contcar.text);
                                            validationEmprestimo =
                                                variables.dado;
                                            validationPeriodo = int.parse(
                                                variables.periodo.toString());
                                            validationTarifas =
                                                conttar.text == ""
                                                    ? 0
                                                    : num.parse(conttar.text
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                            if (validationCarencia >
                                                validationPeriodo) {
                                              return showAlertDialog(
                                                  context,
                                                  state,
                                                  viewStateController,
                                                  "CARÊNCIA NÃO PODE SER MAIOR OU IGUAL QUE PARCELAS.");
                                            } else if (validationTarifas >
                                                validationEmprestimo) {
                                              return showAlertDialog(
                                                  context,
                                                  state,
                                                  viewStateController,
                                                  "OUTRAS DESPESAS NÃO PODE SER MAIOR OU IGUAL A EMPRÉSTIMO.");
                                            } else {
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              } else {
                                                showInterstitialAd();
                                                buttonClick(
                                                    context,
                                                    state,
                                                    viewStateController,
                                                    controller,
                                                    viewState,
                                                    calculate,
                                                    calculateP,
                                                    contcar,
                                                    conttar,
                                                    bankController);
                                              }
                                            }
                                          })),
                                ])))))));
  }

  buttonClick(BuildContext context, state, viewStateController, controller,
      viewState, calculate, calculateP, contcar, conttar, bankController) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      variables.carencia = contcar.text == "" ? 0 : num.parse(contcar.text);
      variables.total = 0;
      variables.dataList = [];
      variables.taxa = variables.taxa / 100;

      variables.tarifa = conttar.text == ""
          ? 0
          : num.parse(conttar.text.replaceAll(r'.', "").replaceAll(r',', '.'));
      if (bankController.text == "") {
        variables.itemSelecionado = "Simulação de Empréstimo";
      }
      if (bankController.text.length > 33) {
        variables.itemSelecionado = "";
        for (int i = 0; i < 33; i++) {
          variables.itemSelecionado += bankController.text[i];
        }
      }
      if (variables.carencia < variables.periodo) {
        if (viewState.checkIof == true) {
          variables.iof = (variables.dado * Iof().iofValue) * Iof().periodoIof;
        } else {
          variables.iof = 0;
        }
        if (viewState.checkIofAdc == true) {
          variables.iofa = (variables.dado * Iof().iofAdcValue);
        } else {
          variables.iofa = 0;
        }
        viewState.table == false
            ? calculate.simulationSac()
            : calculateP.simulationPrice();
        viewStateController.setState(variables.result);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailScreen()));
      } else {
        showAlertDialog(context, state, viewStateController,
            "CARÊNCIA NÃO PODE SER MAIOR OU IGUAL QUE PARCELAS.");
      }
    }
  }

  showAlertDialog(
      BuildContext context, state, viewStateController, String message) async {
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

    //await Future.delayed(const Duration(seconds: 2));
    //viewStateController.Reset(variables);
    // Navigator.pop(context);
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Keys().idInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print("Anúncio nulo");
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }
}
