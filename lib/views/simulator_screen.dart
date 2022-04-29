import 'package:calculadora_capital/src/controller/tir_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../src/ calculation/calculation_sac.dart';
import '../src/controller/state_view.dart';
import '../src/providers/sac_provider.dart';
import '../src/providers/stateview_provider.dart';
import '../src/providers/theme_provider.dart';
import '../src/ calculation/variables.dart';
import 'detail_screen.dart';

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
    final calculate = ref.watch(sacProvider.notifier);
    final encargoState = ref.read(sacProvider);
    final controller =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    controller.text =
        variables.origin != null ? variables.origin!.toStringAsFixed(2) : "";
    final conttx =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    conttx.text = variables.taxa != 0 ? variables.taxa.toStringAsFixed(4) : "";

    final conttar =
        MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: "");
    conttar.text =
        variables.tarifa != 0 ? variables.tarifa.toStringAsFixed(2) : "";
    final contper = TextEditingController();
    contper.text =
        variables.periodo != null ? variables.periodo.toString() : "";
    final contcar = TextEditingController();
    contcar.text = variables.carencia != 0 ? variables.carencia.toString() : "";
    Variables _variables = Variables();

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
                            // autofocus: true,
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
                              // autofocus: true,
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
                              // autofocus: true,
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
                              //autofocus: true,
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
                              // autofocus: true,
                              controller: contcar,
                            )),
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
                                      contcar.text == ""
                                          ? 0
                                          : num.parse(contcar.text);
                                      variables.total = 0;
                                      variables.dataList = [];
                                      variables.taxa = num.parse(conttx.text);
                                      variables.tx = double.parse(conttx.text);
                                      variables.taxa = variables.taxa / 100;
                                      variables.dado =
                                          num.parse(controller.text);
                                      variables.origin =
                                          num.parse(controller.text);
                                      variables.emp =
                                          num.parse(controller.text);
                                      variables.tarifa = conttar.text == ""
                                          ? 0
                                          : num.parse(conttar.text);
                                      variables.periodo =
                                          num.parse(contper.text);
                                      variables.iof =
                                          (variables.dado! * 0.000041) * 365;
                                      variables.iofa =
                                          (variables.dado! * 0.0038);
                                      calculate.simulationSac();
                                      viewStateController
                                          .setState(variables.result);
                                    }

                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }))
                          : Container(),
                      viewState.isState != false
                          ? Column(
                              children: [
                                SizedBox(height: _height * 0.025),
                                Center(
                                    child: Row(children: [
                                  Text("Taxa Real (a.m) : ",
                                      style: state.textTheme.subtitle2),
                                  SizedBox(width: _width * 0.01),
                                  Text(variables.tir.toStringAsFixed(2),
                                      style: state.textTheme.subtitle2),
                                  SizedBox(width: _width * 0.005),
                                  Text(" % ", style: state.textTheme.subtitle2),
                                ])),
                                SizedBox(height: _height * 0.025),
                                Center(
                                    child: Row(children: [
                                  Text("Total do Empréstimo :  R\$ ",
                                      style: state.textTheme.subtitle2),
                                  SizedBox(width: _width * 0.01),
                                  Text(viewState.resultado.toStringAsFixed(2),
                                      style: state.textTheme.subtitle2),
                                ])),
                                SizedBox(height: _height * 0.025),
                                Center(
                                    child: Row(children: [
                                  Text("Total dos Encargos :  R\$ ",
                                      style: state.textTheme.subtitle2),
                                  SizedBox(width: _width * 0.01),
                                  Text(encargoState.encargos.toStringAsFixed(2),
                                      style: state.textTheme.subtitle2),
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
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      state.indicatorColor),
                                            ),
                                            child: Text("Ver Detalhamento",
                                                style:
                                                    state.textTheme.subtitle1),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => const DetailScreen()));
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
                                            child: const Text("Limpar",
                                                style: TextStyle(
                                                    color: Colors.lightBlue,
                                                    fontSize: 25)),
                                            onPressed: () {
                                              setState(() {
                                                Reset(viewStateController,
                                                    _variables);
                                              });
                                            })),
                                  ],
                                )
                              ],
                            )
                          : Container()
                    ])))));
  }

  Reset(viewStateController, _variables) {
    viewStateController.resetState();
    _variables.parcList.clear();
    _variables.amorList.clear();
    _variables.dateList.clear();
    _variables.jurosList.clear();
    _variables.dataList.clear();
    _variables.tirList.clear();
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
