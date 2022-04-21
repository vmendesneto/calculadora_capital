import 'package:calculadora_capital/src/controller/tir_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../src/providers/stateview_provider.dart';
import '../src/providers/theme_provider.dart';
import '../src/variables.dart';

class SimulatorScreen extends ConsumerStatefulWidget {
  const SimulatorScreen({Key? key}) : super(key: key);

  @override
  SimulatorScreenState createState() => SimulatorScreenState();
}

class SimulatorScreenState extends ConsumerState<SimulatorScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);
    final viewStateController = ref.read(stateViewProvider.notifier);

    final controller =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    final conttx =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    final conttar =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    final contper = TextEditingController();
    final contcar = TextEditingController();

    Variables variables = Variables();

    return Material(
        child: Container(
            height: _height,
            width: _width,
            color: state.primaryColor,
            //margin: const EdgeInsets.all(10),
            child: Container(
                margin: const EdgeInsets.all(10),
                color: state.primaryColor,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: _height * 0.08,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Digite o valor do emprestimo: ",
                            style: state.textTheme.caption,
                          )),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      Row(children: [
                        Text(
                          "Valor do Empréstimo :",
                          style: state.textTheme.headline4,
                        ),
                        SizedBox(width: _width * 0.05),
                        Container(
                          height: _height * 0.05,
                          width: _width * 0.45,
                          decoration: BoxDecoration(
                            color: state.unselectedWidgetColor,
                          ),
                          child: TextFormField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            style: state.textTheme.subtitle1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor: state.primaryColor,
                            textAlign: TextAlign.center,
                            autofocus: true,
                            controller: controller,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Row(children: [
                        Text("Taxa (a.m) : ", style: state.textTheme.headline4),
                        SizedBox(width: _width * 0.05),
                        Container(
                            height: _height * 0.05,
                            width: _width * 0.25,
                            decoration: BoxDecoration(
                              color: state.unselectedWidgetColor,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: state.textTheme.subtitle1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: state.primaryColor,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              controller: conttx,
                            )),
                        SizedBox(width: _width * 0.03),
                        Text(" % ", style: state.textTheme.headline4),
                      ]),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      // Row(children: [
                      //   Text("IOF :  R\$", style: state.textTheme.bodyText2),
                      //   const SizedBox(width: 10),
                      //   Container(
                      //       height: 35,
                      //       width: 90,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.blue,
                      //       ),
                      //       child: Align(
                      //           alignment: Alignment.center,
                      //           child: Text(variables.iof == 0
                      //               ? ""
                      //               : variables.iof.toStringAsFixed(2)))),
                      //   const SizedBox(width: 15),
                      //   Text("IOF Adicional:  R\$",
                      //       style: state.textTheme.bodyText2),
                      //   const SizedBox(width: 10),
                      //   Container(
                      //       height: 35,
                      //       width: 90,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.blue,
                      //       ),
                      //       child: Align(
                      //           alignment: Alignment.center,
                      //           child: Text(variables.iofa == 0
                      //               ? ""
                      //               : variables.iofa.toStringAsFixed(2)))),
                      // ]),
                      //const SizedBox(height: 15),
                      Row(children: [
                        Text("Outras Despesas : ",
                            style: state.textTheme.headline4),
                        Container(
                            height: _height * 0.05,
                            width: _width * 0.25,
                            decoration: BoxDecoration(
                              color: state.unselectedWidgetColor,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: state.textTheme.subtitle1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: state.primaryColor,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              controller: conttar,
                            )),
                      ]),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Row(children: [
                        Text("Periodo : ", style: state.textTheme.headline4),
                        SizedBox(width: _width * 0.03),
                        Container(
                            height: _height * 0.05,
                            width: _width * 0.25,
                            decoration: BoxDecoration(
                              color: state.unselectedWidgetColor,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: state.textTheme.subtitle1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: state.primaryColor,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              controller: contper,
                            )),
                        SizedBox(width: _width * 0.03),
                        Text("Carência : ", style: state.textTheme.headline4),
                        SizedBox(width: _width * 0.03),
                        Container(
                            height: _height * 0.05,
                            width: _width * 0.25,
                            decoration: BoxDecoration(
                              color: state.unselectedWidgetColor,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: state.textTheme.subtitle1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: state.primaryColor,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              controller: contcar,
                            )),
                      ]),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                          viewState.isState == false ? SizedBox(
                          width: _width * 0.7, // <-- Your width
                          height: _height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        state.indicatorColor),
                              ),
                              child: Text("SIMULAR",
                                  style: state.textTheme.subtitle1),
                              onPressed: () {
                                if (controller.text.isEmpty ||
                                    controller.text == "" ||
                                    contper.text.isEmpty ||
                                    contper.text == "") {
                                  variables.total = 0;
                                  showAlertDialog(context, state);
                                } else {
                                  variables.parcList.clear();
                                  variables.amorList.clear();
                                  variables.dateList.clear();
                                  variables.jurosList.clear();
                                  variables.dataList.clear();
                                  variables.tirList.clear();
                                  //carencia =
                                  contcar.text == ""
                                      ? 0
                                      : num.parse(contcar.text);
                                  variables.total = 0;
                                  variables.dataList = [];
                                  variables.taxa = num.parse(conttx.text);
                                  variables.tx = double.parse(conttx.text);
                                  variables.taxa = variables.taxa / 100;
                                  variables.dado = num.parse(controller.text);
                                  variables.emp = num.parse(controller.text);
                                  variables.tarifa = conttar.text == ""
                                      ? 0
                                      : num.parse(conttar.text);
                                  variables.periodo = num.parse(contper.text);
                                  variables.iof =
                                      (variables.dado! * 0.000041) * 365;
                                  variables.iofa = (variables.dado! * 0.0038);
                                  var _liquido = variables.emp -
                                      variables.iof -
                                      variables.iofa -
                                      variables.tarifa;
                                  var _empTir = -(_liquido);
                                  variables.tirList.add(_empTir);
                                  variables.saldodevedor = variables.dado!;
                                  int i = 1;
                                  int c = 1;

                                  for (i; i <= variables.periodo!; i++) {
                                    variables.amortiza = (variables.emp /
                                        (variables.periodo! -
                                            variables.carencia));
                                    if (variables.carencia >= c) {
                                      variables.amortiza = 0;
                                      variables.juros = variables.saldodevedor *
                                          variables.taxa;
                                      variables.saldodevedor =
                                          variables.saldodevedor;
                                      variables.dado = variables.saldodevedor;
                                      variables.dataList
                                          .add(variables.saldodevedor);
                                      variables.jurosList.add(variables.juros!);
                                      variables.amorList
                                          .add(variables.amortiza);
                                      variables.newDate = DateTime(
                                          variables.date.year,
                                          variables.date.month + 1,
                                          variables.date.day);
                                      variables.date = variables.newDate!;
                                      variables.dateList.add(
                                          DateFormat("dd/MM/yyyy")
                                              .format(variables.newDate!));
                                      variables.parcela = variables.juros!;
                                      variables.parcList.add(variables.parcela);
                                      variables.tirList.add(variables.parcela);
                                      variables.totalP =
                                          variables.totalP + variables.parcela;
                                      c++;
                                    } else {
                                      variables.amorList
                                          .add(variables.amortiza);
                                      variables.juros = variables.saldodevedor *
                                          variables.taxa;
                                      variables.saldodevedor =
                                          variables.saldodevedor -
                                              variables.amortiza;
                                      variables.dado = variables.saldodevedor;
                                      variables.jurosList.add(variables.juros!);
                                      variables.parcela =
                                          variables.juros! + variables.amortiza;
                                      variables.result =
                                          variables.result + variables.parcela;
                                      variables.tirList.add(variables.parcela);
                                      variables.parcList.add(variables.parcela);
                                      variables.dataList
                                          .add(variables.saldodevedor);
                                      variables.newDate = DateTime(
                                          variables.date.year,
                                          variables.date.month + 1,
                                          variables.date.day);
                                      variables.date = variables.newDate!;
                                      variables.dateList.add(
                                          DateFormat("dd/MM/yyyy")
                                              .format(variables.newDate!));
                                      variables.totalP =
                                          variables.totalP + variables.parcela;

                                      setState(() {
                                        //variables.result = variables.result;
                                        variables.parcList = variables.parcList;
                                        variables.amorList = variables.amorList;
                                        variables.dateList = variables.dateList;
                                        variables.jurosList =
                                            variables.jurosList;
                                        variables.dataList = variables.dataList;
                                      });
                                    }
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                }
                                variables.tir = (tirController.irr(
                                        values: variables.tirList) *
                                    100);

                                print(variables.result);
                                viewStateController.setState(variables.result);
                              })): Container(),
                      viewState.isState != false
                          ? Column(
                              children: [
                                SizedBox(height: _height * 0.025),
                                Center(
                                    child: Row(children: [
                                  Text("Total do Empréstimo :",
                                      style: state.textTheme.subtitle2),
                                  Text(viewState.resultado.toStringAsFixed(2),
                                      style: state.textTheme.subtitle2),])),
                                  SizedBox(height: _height * 0.025),
                                  SizedBox(
                                      width: _width * 0.7, // <-- Your width
                                      height: _height * 0.06,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    state.indicatorColor),
                                          ),
                                          child: Text("Ver Detalhamento",
                                              style: state.textTheme.subtitle1),
                                          onPressed: () {
                                            print("MOstrar ListView em outra tela");
                                          })),

                              ],
                            )
                          : Container()
                    ])))));
  }

  showAlertDialog(BuildContext context, state) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              "Insira um número",
              style: state.textTheme.bodyText1,
            )),
          );
        });
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }
}
