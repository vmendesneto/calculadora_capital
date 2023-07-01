import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/controller/state_view.dart';
import '../../src/providers/stateview_provider.dart';
import '../../src/providers/theme_provider.dart';

class MarkupScreen extends ConsumerStatefulWidget {
  const MarkupScreen({Key? key}) : super(key: key);

  @override
  MarkupScreenState createState() => MarkupScreenState();
}

class MarkupScreenState extends ConsumerState<MarkupScreen> {
  static final _formKey = GlobalKey<FormState>();

  final contFat = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  final contCusto = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  final contCompra = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  final conttx = MoneyMaskedTextController(
    decimalSeparator: ".",
    thousandSeparator: "",
    initialValue: 0.00,
  );
  final contEmp = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  bool btalterar = false;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Preço de Venda", style: state.textTheme.bodySmall)),
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
                                      "Faturamento Médio: R\$",
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
                                                  return "Informe o fautramento médio";
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
                                              style:
                                                  state.textTheme.titleMedium,
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
                                              controller: contFat,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Row(children: [
                                    Text(
                                      "Custo Fixo + Custo Variavél : R\$",
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
                                                  return "Informe a média dos custos";
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
                                              style:
                                                  state.textTheme.titleMedium,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              onChanged: (value) {
                                                variables.totalP = num.parse(
                                                    value
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              controller: contCusto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Row(children: [
                                    Text(
                                      "Preço de Compra : R\$",
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
                                                  return "Informe o preço de compra";
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
                                              style:
                                                  state.textTheme.titleMedium,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              onChanged: (value) {
                                                variables.totalJ = num.parse(
                                                    value
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              controller: contCompra,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Row(children: [
                                    Text("Lucro : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.06,
                                          width: _width * 0.25,
                                          decoration: BoxDecoration(
                                            color: btalterar == false
                                                ? state.unselectedWidgetColor
                                                : state.disabledColor,
                                          )),
                                      Center(
                                          child: SizedBox(
                                              height: _height * 0.075,
                                              width: _width * 0.25,
                                              child: btalterar == false
                                                  ? TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Lucro";
                                                        }
                                                        return null;
                                                      },
                                                      enabled:
                                                          viewState.enabled ==
                                                                  true
                                                              ? true
                                                              : false,
                                                      decoration: const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          errorStyle: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'FuturaPTLight.otf',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.red),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.0))),
                                                      style: state.textTheme
                                                          .titleMedium,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            4)
                                                      ],
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onChanged: (value) {
                                                        variables.taxa =
                                                            num.parse(value);
                                                        // variables.tx =
                                                        //     double.parse(value);
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor:
                                                          state.primaryColor,
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: conttx,
                                                    )
                                                  : Center(
                                                      child: Text(
                                                      variables.taxa
                                                          .toStringAsFixed(2),
                                                      style: state.textTheme
                                                          .titleMedium,
                                                    )))),
                                    ]),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  Row(children: [
                                    Text("Custo : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.06,
                                          width: _width * 0.25,
                                          decoration: BoxDecoration(
                                            color: state.disabledColor,
                                          )),
                                      Center(
                                          child: SizedBox(
                                              height: _height * 0.075,
                                              width: _width * 0.25,
                                              child: Center(
                                                  child: Text(
                                                variables.tx.toStringAsFixed(2),
                                                style:
                                                    state.textTheme.titleMedium,
                                              )))),
                                    ]),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  Row(children: [
                                    Text(
                                      "Preço de Venda : R\$",
                                      style: state.textTheme.headlineMedium,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.06,
                                          width: _width * 0.35,
                                          decoration: BoxDecoration(
                                            color: btalterar == false
                                                ? state.disabledColor
                                                : state.unselectedWidgetColor,
                                          )),
                                      Center(
                                          child: SizedBox(
                                              height: _height * 0.075,
                                              width: _width * 0.35,
                                              child: Center(
                                                child: btalterar == false
                                                    ? Text(
                                                        contEmp.text
                                                            ,
                                                        style: state.textTheme
                                                            .titleMedium,
                                                      )
                                                    : TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Preço de venda";
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
                                                  style:
                                                  state.textTheme.titleMedium,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  onChanged: (value) {
                                                    variables.emp = num.parse(value
                                                        .replaceAll(r'.', "")
                                                        .replaceAll(r',', '.'));
                                                  },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  cursorColor: state.primaryColor,
                                                  textAlign: TextAlign.center,
                                                  controller: contEmp,
                                                ),
                                              ))),
                                    ]),
                                    SizedBox(width: _width * 0.02),
                                    Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        height: _height * 0.06,
                                        width: _width * 0.2,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      state.indicatorColor),
                                            ),
                                            child: Text("Alterar",
                                                style: state
                                                    .textTheme.headlineLarge),
                                            onPressed: () {
                                              setState(() {
                                                btalterar = !btalterar;
                                              });
                                            })),
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
                                          child: Text("Calcular",
                                              style: state.textTheme.bodySmall),
                                          onPressed: () {
                                            if (variables.dado <=
                                                variables.totalP) {
                                              showAlertDialog(context, state,
                                                  "Faturamento não pode ser menor ou igual que custo.");
                                            } else if (variables.totalJ == 0) {
                                              showAlertDialog(context, state,
                                                  "Preço de Compra tem que ser maior que 0.");
                                            } else if (variables.taxa <= 0 || variables.taxa >= 100.00) {
                                              print(variables.taxa);
                                              showAlertDialog(context, state,
                                                  "Lucro tem que ser maior que 0 e menor que 100.");
                                            }

                                            else {
                                              setState(() {
                                                if (btalterar == false) {
                                                  calculoPVenda(contEmp,context,state);
                                                } else {
                                                  if (variables.emp <
                                                      variables.totalJ) {
                                                    showAlertDialog(
                                                        context, state,
                                                        "Preço de venda não pode ser menor do que preço de compra.");
                                                  } else {
                                                    calculoLucro(
                                                        conttx,contEmp );
                                                    btalterar = false;
                                                  }
                                                }
                                              });
                                            }
                                          })),
                                ])))))));
  }
}

calculoPVenda(contEmp, BuildContext context, state) {
  variables.tx = 0.00;
  variables.emp = 0.00;
  num taxa = variables.taxa / 100;
  variables.tx = variables.totalP / variables.dado;
  if((taxa + variables.tx) >= 1){
    if(variables.taxa + variables.tx >= 1){
      showAlertDialog(
          context, state,
          "Lucro + Custo não pode ultrapassar 100%.");
    }
  }else {
    num soma = (taxa + variables.tx);
    num t = 1 - soma;
    variables.emp = variables.totalJ / t;
    print("emp ${variables.emp}");
    contEmp.text = variables.emp.toStringAsFixed(2);
    variables.tx = variables.tx * 100;
    print(contEmp);
  }}
calculoLucro(conttx,contEmp){
  variables.tx = 0.00;
  print("emp : ${variables.emp}");
  variables.tx = variables.totalP / variables.dado;
  num mult = variables.tx * variables.emp;
  num soma = variables.totalJ + mult;
  num subt = variables.emp - soma;
  num result = subt/variables.emp;
  variables.taxa= result * 100;
  conttx.text = variables.taxa.toStringAsFixed(2);
  contEmp.text = variables.emp.toStringAsFixed(2);
  variables.tx = variables.tx * 100;
  print(variables.taxa);
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

  //await Future.delayed(const Duration(seconds: 2));
  //viewStateController.Reset(variables);
  // Navigator.pop(context);
}
