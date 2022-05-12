import 'package:calculadora_capital/src/%20calculation/iof_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../src/controller/state_view.dart';
import '../src/providers/price_provider.dart';
import '../src/providers/sac_provider.dart';
import '../src/providers/stateview_provider.dart';
import '../src/providers/theme_provider.dart';
import 'detail_screen.dart';

class SimulatorScreen extends ConsumerStatefulWidget {
  const SimulatorScreen({Key? key}) : super(key: key);

  @override
  SimulatorScreenState createState() => SimulatorScreenState();
}

class SimulatorScreenState extends ConsumerState<SimulatorScreen> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);
    final viewStateController = ref.read(stateViewProvider.notifier);
    final calculate = ref.watch(sacProvider.notifier);
    final calculateP = ref.watch(priceProvider.notifier);
    final encargoState = ref.read(sacProvider);
    final encargoPriceState = ref.read(priceProvider);

    final controller = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: double.parse(variables.emp.toStringAsFixed(2)));
    final conttx = MoneyMaskedTextController(
        decimalSeparator: ".",
        thousandSeparator: "",
        initialValue: double.parse(variables.tx.toStringAsFixed(4)));

    final conttar = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: double.parse(variables.tarifa.toStringAsFixed(2)));

    final contper = TextEditingController(text: variables.periodo.toString());

    final contcar = TextEditingController(text: variables.carencia.toString());

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Simulador de Empréstimo",
                  style: state.textTheme.caption)),
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
                                        style: state.textTheme.headline1,
                                      )),
                                  SizedBox(
                                    height: _height * 0.05,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Valor do Empréstimo : R\$",
                                      style: state.textTheme.headline4,
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
                                              style: state.textTheme.subtitle1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              autofocus: true,
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
                                        style: state.textTheme.headline4),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.05,
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
                                                    state.textTheme.subtitle1,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      5)
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: state.primaryColor,
                                                textAlign: TextAlign.center,
                                                // autofocus: true,
                                                controller: conttx,
                                              ))),
                                    ]),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headline4),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(children: [
                                    Text("Outras Despesas : R\$   ",
                                        style: state.textTheme.headline4),
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
                                          style: state.textTheme.subtitle1,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(9)
                                          ],
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          // autofocus: true,
                                          controller: conttar,
                                        )),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Row(children: [
                                    Text("Periodo (mes): ",
                                        style: state.textTheme.headline4),
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
                                                      return "Periodo";
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
                                                      state.textTheme.subtitle1,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        3)
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      state.primaryColor,
                                                  textAlign: TextAlign.center,
                                                  //autofocus: true,
                                                  controller: contper,
                                                )))
                                      ],
                                    ),
                                    SizedBox(width: _width * 0.011),
                                    Text("Carência (mes): ",
                                        style: state.textTheme.headline4),
                                    SizedBox(width: _width * 0.03),
                                    Container(
                                        height: _height * 0.05,
                                        width: _width * 0.15,
                                        decoration: BoxDecoration(
                                          color: state.unselectedWidgetColor,
                                        ),
                                        child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: TextFormField(
                                              enabled: viewState.enabled == true
                                                  ? true
                                                  : false,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              style: state.textTheme.subtitle1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    3)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              // autofocus: true,
                                              controller: contcar,
                                            ))),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.05,
                                  ),
                                  viewState.isState == false
                                      ? SizedBox(
                                          width: _width * 0.7, // <-- Your width
                                          height: _height * 0.06,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.indicatorColor),
                                              ),
                                              child: Text("SIMULAR",
                                                  style:
                                                      state.textTheme.caption),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                  .validate()) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    variables.carencia =
                                                        contcar.text == ""
                                                            ? 0
                                                            : num.parse(
                                                                contcar.text);
                                                    variables.total = 0;
                                                    variables.dataList = [];
                                                    variables.taxa =
                                                        num.parse(conttx.text);
                                                    variables.tx = double.parse(
                                                        conttx.text);
                                                    variables.taxa =
                                                        variables.taxa / 100;
                                                    variables.dado = num.parse(
                                                        controller.text
                                                            .replaceAll(
                                                                r'.', "")
                                                            .replaceAll(
                                                                r',', '.'));
                                                    variables.origin =
                                                        num.parse(controller
                                                            .text
                                                            .replaceAll(
                                                                r'.', "")
                                                            .replaceAll(
                                                                r',', '.'));
                                                    variables.emp = num.parse(
                                                        controller.text
                                                            .replaceAll(
                                                                r'.', "")
                                                            .replaceAll(
                                                                r',', '.'));
                                                    variables.tarifa = conttar
                                                                .text ==
                                                            ""
                                                        ? 0
                                                        : num.parse(conttar.text
                                                            .replaceAll(
                                                                r'.', "")
                                                            .replaceAll(
                                                                r',', '.'));
                                                    variables.periodo =
                                                        num.parse(contper.text);

                                                    if (variables.carencia < variables.periodo) {
                                                    variables.iof = (variables
                                                                .dado! *
                                                            Iof().iofValue) *
                                                        Iof().periodoIof;
                                                    variables.iofa =
                                                        (variables.dado! *
                                                            Iof().iofAdcValue);
                                                    viewState.table == false
                                                        ? calculate
                                                            .simulationSac()
                                                        : calculateP
                                                            .simulationPrice();
                                                    viewStateController
                                                        .setState(
                                                            variables.result);
                                                  }else {
                                                      showAlertDialog(
                                                          context, state,viewStateController);

                                                    }
                                                }
                                              }))
                                      : Container(),
                                  viewState.isState != false
                                      ? Column(
                                          children: [
                                            SizedBox(height: _height * 0.025),
                                            Center(
                                                child: Row(children: [
                                              Text("Taxa Real (a.m) : ",
                                                  style: state
                                                      .textTheme.subtitle2),
                                              SizedBox(width: _width * 0.01),
                                              Text(
                                                  variables.tir
                                                      .toStringAsFixed(2),
                                                  style: state
                                                      .textTheme.subtitle2),
                                              SizedBox(width: _width * 0.005),
                                              Text(" % ",
                                                  style: state
                                                      .textTheme.subtitle2),
                                            ])),
                                            SizedBox(height: _height * 0.025),
                                            Center(
                                                child: Row(children: [
                                              Text(
                                                  "Valor Final :  R\$ ",
                                                  style: state
                                                      .textTheme.subtitle2),
                                              SizedBox(width: _width * 0.01),
                                              Text(
                                                  viewState.resultado
                                                      .toStringAsFixed(2)
                                                      .replaceAll(r'.', ","),
                                                  style: state
                                                      .textTheme.subtitle2),
                                            ])),
                                            SizedBox(height: _height * 0.025),
                                            Center(
                                                child: Row(children: [
                                              Text("Total dos Encargos :  R\$ ",
                                                  style: state
                                                      .textTheme.subtitle2),
                                              SizedBox(width: _width * 0.01),
                                              Text(
                                                 viewState.table == false ? encargoState.encargos
                                                      .toStringAsFixed(2)
                                                      .replaceAll(r'.', ",") :
                                                 encargoPriceState.encargos.toStringAsFixed(2)
                                                     .replaceAll(r'.', ",")
                                                  ,
                                                  style: state
                                                      .textTheme.subtitle2),
                                            ])),
                                            SizedBox(height: _height * 0.025),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width: _width * 0.6,
                                                    height: _height * 0.06,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(state
                                                                      .indicatorColor),
                                                        ),
                                                        child: Text(
                                                            "Ver Detalhamento",
                                                            style: state
                                                                .textTheme
                                                                .caption),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const DetailScreen()));
                                                        })),
                                                const Spacer(),
                                                SizedBox(
                                                    width: _width * 0.26,
                                                    height: _height * 0.06,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(state
                                                                      .primaryColorDark),
                                                        ),
                                                        child: const Text(
                                                            "Limpar",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontSize: 25)),
                                                        onPressed: () {
                                                          setState(() {
                                                            viewStateController
                                                                .Reset(
                                                                    variables);
                                                          });
                                                        })),
                                              ],
                                            )
                                          ],
                                        )
                                      : Container()
                                ])))))));
  }

  showAlertDialog(BuildContext context, state,viewStateController) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: state.primaryColor,
            title: Center(
                child: Text(
              "CARÊNCIA não pode ser maior que o PERíODO.", textAlign: TextAlign.center,
              style: state.textTheme.subtitle2,
            )),
          );
        });

    await Future.delayed(const Duration(seconds: 5));
    viewStateController
        .Reset(
        variables);
    Navigator.pop(context);
  }
}
