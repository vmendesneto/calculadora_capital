// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:calculadora_capital/src/controller/tir_controller.dart';
import 'package:calculadora_capital/src/providers/theme_provider.dart';
import 'package:calculadora_capital/src/theme/theme_color.dart';
import 'package:calculadora_capital/src/variables.dart';
import 'package:calculadora_capital/views/home.dart';
import 'package:calculadora_capital/views/simulator_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((shared) {
    prefs = shared;
    runApp(ProviderScope(child: MyApp()));
  });

}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themesNotifier = ref.read(themeProvider.notifier);
    themesNotifier.setTheme(themes[prefs!.getInt("theme") ?? 0]);

    return Platform.isAndroid == true ? MaterialApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Capital de Giro',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const SimulatorScreen(),
      },
      home: const SimulatorScreen(),
    ) :  CupertinoApp(
      theme: themesNotifier.getTheme(),
      title: 'Simulador Capital de Giro',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const SimulatorScreen(),
      },
      home: const SimulatorScreen(),
    );

  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final conttx = TextEditingController();
  final conttar = TextEditingController();
  final contper = TextEditingController();
  final contcar = TextEditingController();

  Variables variables = Variables();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Align(
              alignment: Alignment.center,
              child: Text(
                "Capital de giro",
                style: TextStyle(color: Colors.yellow),
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(2),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Digite o valor do emprestimo: ",
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                const Text("Valor do Empréstimo :"),
                const SizedBox(width: 20),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.yellow),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          controller: controller,
                        ))),
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                const Text("Taxa (a.m): "),
                const SizedBox(width: 20),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.yellow),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          controller: conttx,
                        ))),
                const SizedBox(width: 10),
                const Text(" % "),
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                const Text("IOF :  R\$"),
                const SizedBox(width: 10),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(variables.iof == 0 ? "" : variables.iof.toStringAsFixed(2)))),
                const SizedBox(width: 15),
                const Text("IOF Adicional:  R\$"),
                const SizedBox(width: 10),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(variables.iofa == 0 ? "" : variables.iofa.toStringAsFixed(2)))),
              ]),
              const SizedBox(height: 15),
              Row(children: [
                const Text("Tarifa de Contratação: "),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.yellow),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          controller: conttar,
                        ))),
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(children: [
                const Text("Periodo: "),
                const SizedBox(width: 20),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.yellow),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          controller: contper,
                        ))),
                const SizedBox(width: 15),
                const Text("Carência: "),
                const SizedBox(width: 20),
                Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.yellow),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          controller: contcar,
                        ))),
              ]),
              const SizedBox(
                height: 15,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: const Text("SIMULAR"),
                  textColor: Colors.yellow,
                  onPressed: () {
                    if (controller.text.isEmpty ||
                        controller.text == "" ||
                        contper.text.isEmpty ||
                        contper.text == "") {
                      variables.total = 0;
                      showAlertDialog(context);
                    } else {
                      variables.parcList.clear();
                      variables.amorList.clear();
                      variables.dateList.clear();
                      variables.jurosList.clear();
                      variables.dataList.clear();
                      variables.tirList.clear();
                      //carencia =
                      contcar.text == "" ? 0 : num.parse(contcar.text);
                      variables.total = 0;
                      variables.dataList = [];
                      variables.taxa = num.parse(conttx.text);
                      variables.tx = double.parse(conttx.text);
                      variables.taxa = variables.taxa / 100;
                      variables.dado = double.parse(controller.text);
                      variables.emp = double.parse(controller.text);
                      variables.tarifa = conttar.text == "" ? 0 : num.parse(conttar.text);
                      variables.periodo = num.parse(contper.text);
                      variables.iof = (variables.dado! * 0.000041) * 365;
                      variables.iofa = (variables.dado! * 0.0038);
                      var _liquido = variables.emp - variables.iof - variables.iofa - variables.tarifa;
                      var _empTir = -(_liquido);
                      variables.tirList.add(_empTir);
                      variables.saldodevedor = variables.dado!;
                      int i = 1;
                      int c = 1;

                      for (i; i <= variables.periodo!; i++) {
                        variables.amortiza = (variables.emp / (variables.periodo! - variables.carencia));
                        if (variables.carencia >= c) {
                          variables.amortiza = 0;
                          variables.juros = variables.saldodevedor * variables.taxa;
                          variables.saldodevedor = variables.saldodevedor;
                          variables.dado = variables.saldodevedor;
                          variables.dataList.add(variables.saldodevedor);
                          variables.jurosList.add(variables.juros!);
                          variables.amorList.add(variables.amortiza);
                          variables.newDate =
                              DateTime(variables.date.year, variables.date.month + 1, variables.date.day);
                          variables.date = variables.newDate!;
                          variables.dateList
                              .add(DateFormat("dd/MM/yyyy").format(variables.newDate!));
                          variables.parcela = variables.juros!;
                          variables.parcList.add(variables.parcela);
                          variables.tirList.add(variables.parcela);
                          variables.totalP = variables.totalP + variables.parcela;
                          c++;
                        } else {
                          variables.amorList.add(variables.amortiza);
                          variables.juros = variables.saldodevedor * variables.taxa;
                          variables.saldodevedor = variables.saldodevedor - variables.amortiza;
                          variables.dado = variables.saldodevedor;
                          variables.jurosList.add(variables.juros!);
                          variables.parcela = variables.juros! + variables.amortiza;
                          variables.result = variables.result + variables.parcela;
                          variables.tirList.add(variables.parcela);
                          variables.parcList.add(variables.parcela);
                          variables.dataList.add(variables.saldodevedor);
                          variables.newDate =
                              DateTime(variables.date.year, variables.date.month + 1, variables.date.day);
                          variables.date = variables.newDate!;
                          variables.dateList
                              .add(DateFormat("dd/MM/yyyy").format(variables.newDate!));
                          variables.totalP = variables.totalP + variables.parcela;

                          setState(() {

                            variables.result = variables.result;
                            variables.parcList = variables.parcList;
                            variables.amorList = variables.amorList;
                            variables.dateList = variables.dateList;
                            variables.jurosList = variables.jurosList;
                            variables.dataList = variables.dataList;
                          });
                        }

                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    }
                    variables.tir = (tirController.irr(values: variables.tirList)*100);


                  }),
              const SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    const Text("Taxa Real (a.m): "),
                    Container(
                        height: 35,
                        width: 90,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(variables.tir.toStringAsFixed(2)))),
                    const SizedBox(width: 10),
                    const Text(" % "),
                  ])),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Os Valores do empréstimo são:",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              controller.text != ""
                  ? Container(
                  width: 490,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(double.parse(controller.text)
                            .toStringAsFixed(2))),
                    Row(children: [
                      SizedBox(
                          width: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: variables.jurosList.length,
                              itemBuilder: (context, int index) {
                                variables.nparc = index + 1;

                                return variables.jurosList.toString() != null
                                    ? Align(
                                    alignment: Alignment.center,
                                    child: Row(children: [
                                      Text(variables.nparc.toString()),
                                      const SizedBox(width: 15),
                                      Text(variables.dateList[index]),
                                      const SizedBox(width: 15),
                                      Text(variables.jurosList[index]
                                          .toStringAsFixed(2)),
                                    ]))
                                    : Container();
                              })),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 280,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: variables.dataList.length,
                              itemBuilder: (context, int index) {
                                return variables.dataList.toString() != null
                                    ? Align(
                                  alignment: Alignment.center,
                                  child: Row(children: [
                                    Text(variables.amorList[index]
                                        .toStringAsFixed(2)),
                                    const SizedBox(width: 15),
                                    Text(variables.parcList[index]
                                        .toStringAsFixed(2)),
                                    const SizedBox(width: 15),
                                    Text(
                                      variables.dataList[index]
                                          .toStringAsFixed(2),
                                    ),
                                  ]),
                                )
                                    : Container();
                              })),
                    ]),
                  ]))
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              controller.text != ""
                  ? Container(
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Text(variables.result.toStringAsFixed(2)))
                  : Container()
            ]),
          ),
        ));
  }



  showAlertDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Center(child: Text("Insira um número")),
          );
        });
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }
}
