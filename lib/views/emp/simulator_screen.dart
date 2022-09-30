import 'package:calculadora_capital/src/%20calculation/loan_calculation/iof_value.dart';
import 'package:calculadora_capital/src/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../../src/controller/state_view.dart';
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
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);
    final viewStateController = ref.read(stateViewProvider.notifier);
    final calculate = ref.watch(sacProvider.notifier);
    final calculateP = ref.watch(priceProvider.notifier);
    final apiState = ref.read(apiProvider);


print(viewState.checkIof);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Simulador de Empréstimo",
                  style: state.textTheme.caption)),
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
                                        style: state.textTheme.headline1,
                                      )),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  variables.itemSelecionado != "error"
                                      ? DropdownButton<String>(
                                          dropdownColor: state.primaryColor,
                                          items: apiState.banksList
                                              .map((String dropDownStringItem) {
                                            return DropdownMenuItem<String>(
                                                value: dropDownStringItem,
                                                child: Text(
                                                  dropDownStringItem,
                                                  style:
                                                      state.textTheme.headline5,
                                                ));
                                          }).toList(),
                                          autofocus: true,
                                          isExpanded: true,
                                          onChanged:
                                              (String? novoItemSelecionado) {
                                            _dropDownItemSelected(
                                                novoItemSelecionado!);
                                            setState(() {
                                              variables.itemSelecionado =
                                                  novoItemSelecionado;
                                            });
                                          },
                                          value: variables.itemSelecionado,
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly  , children: [
                                    Container(child: Row(children : [
                                      Checkbox(
                                          value: viewState.checkIof,
                                          onChanged: (val) {
                                            setState(() {
                                              viewStateController.iof(val!);
                                            });
                                          }),
                                      Text("Cobrará IOF ? "),
                                    ])),
                                    Container(child: Row(children : [
                                      Checkbox(
                                          value: viewState.checkIofAdc,
                                          onChanged: (val) {
                                            setState(() {
                                              viewStateController.iofAdc(val!);
                                            });
                                          }),
                                      Text("Cobrará IOF Adic. ? ")
                                    ])),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.01,
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
                                              style: state.textTheme.subtitle1,
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
                                        style: state.textTheme.headline4),
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
                                                    state.textTheme.subtitle1,
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
                                        style: state.textTheme.headline4),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
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
                                                  style:
                                                      state.textTheme.subtitle1,
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
                                        style: state.textTheme.headline4),
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
                                              style: state.textTheme.subtitle1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    3)
                                              ],
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (value) {
                                                buttonClick(
                                                    context,
                                                    state,
                                                    viewStateController,
                                                    controller,
                                                    viewState,
                                                    calculate,
                                                    calculateP,
                                                    contcar,
                                                    conttar,);
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

                                  Row(
                                    children: [
                                      SizedBox(
                                          width: _width * 0.5,
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
                                                // if(variables.itemSelecionado == 'Select Bank'){
                                                //   showAlertDialog2(
                                                //       context,
                                                //       state,
                                                //       viewStateController);
                                                // }else{
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
                                                );
                                              })),
                                      const Spacer(),
                                      SizedBox(
                                          width: _width * 0.26,
                                          height: _height * 0.06,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.primaryColorDark),
                                              ),
                                              child: Text("Limpar",
                                                  style:
                                                      state.textTheme.button),
                                              onPressed: () {
                                                setState(() {
                                                  viewStateController.Reset(
                                                      variables);
                                                });
                                              })),
                                    ],
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                ])))))));
  }

  buttonClick(BuildContext context, state, viewStateController, controller,
      viewState, calculate, calculateP, contcar, conttar) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      variables.carencia = contcar.text == "" ? 0 : num.parse(contcar.text);
      variables.total = 0;
      variables.dataList = [];
      variables.taxa = variables.taxa / 100;

      variables.tarifa = conttar.text == ""
          ? 0
          : num.parse(conttar.text.replaceAll(r'.', "").replaceAll(r',', '.'));
      if (variables.carencia < variables.periodo) {
        if(viewState.checkIof == true){
        variables.iof = (variables.dado * Iof().iofValue) * Iof().periodoIof;
        }else{
        variables.iof = 0;
        }
        if(viewState.checkIofAdc == true){
        variables.iofa = (variables.dado * Iof().iofAdcValue);
        }else{
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
        showAlertDialog(context, state, viewStateController);
      }
    }
  }

  showAlertDialog(BuildContext context, state, viewStateController) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: state.primaryColor,
            title: Center(
                child: Text(
              "CARÊNCIA NÃO PODE SER MAIOR OU IGUAL QUE PARCELAS.",
              textAlign: TextAlign.center,
              style: state.textTheme.subtitle2,
            )),
          );
        });

    await Future.delayed(const Duration(seconds: 4));
    viewStateController.Reset(variables);
    Navigator.pop(context);
  }

  // showAlertDialog2(BuildContext context, state, viewStateController) async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: state.primaryColor,
  //           title: Center(
  //               child: Text(
  //                 "Selecione um Banco",
  //                 textAlign: TextAlign.center,
  //                 style: state.textTheme.subtitle2,
  //               )),
  //         );
  //       });
  //
  //   await Future.delayed(const Duration(seconds: 3));
  //  // viewStateController.Reset(variables);
  //   Navigator.pop(context);
  // }

  void _dropDownItemSelected(String novoItem) {
    // setState(() {
    variables.itemSelecionado = novoItem;
    //});
  }
}
