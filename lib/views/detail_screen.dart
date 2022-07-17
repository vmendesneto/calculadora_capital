import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:calculadora_capital/src/save_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../src/providers/theme_provider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    GeneratePDF generatePdf = GeneratePDF();
    var dt = DateFormat("dd/MM/yyyy").format(DateTime.now());
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          title: Text(
            "Analítico da Simulação",
            style: state.textTheme.caption,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: state.primaryColor,
              ),
              onPressed: () async {
                generatePdf.generatePDFInvoice();
              },
            )
          ],
          backgroundColor: state.indicatorColor,
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
                padding: EdgeInsets.only(
                    top: _height * 0.01,
                    left: _width * 0.03,
                    right: _width * 0.03),
                decoration: BoxDecoration(color: state.primaryColor),
                child: Column(children: [
                  Table(
                      border:
                          TableBorder.all(color: state.unselectedWidgetColor),
                      columnWidths: const <int, TableColumnWidth>{
                        //largura de cada coluna
                        0: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      variables.itemSelecionado == "Select Bank"
                                          ? "Simulação de Empréstimo"
                                          : variables.itemSelecionado,
                                      style: state.textTheme.headline4,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: _width * 0.1),
                                    Text(dt, style: state.textTheme.headline4),
                                  ]))
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor do Empréstimo :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.origin!),
                                    style: state.textTheme.headline4,
                                  ),
                                ],
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor do Iof :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.iof),
                                    style: state.textTheme.headline4,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Iof Adic. :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.iofa),
                                    style: state.textTheme.headline4,
                                  ),
                                ],
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Outras Despesas :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.tarifa),
                                    style: state.textTheme.headline4,
                                  )
                                ],
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Text(
                                  "Periodo (mes) : ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.periodo.toString(),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(
                                  width: _width * 0.06,
                                ),
                                const Spacer(),
                                Text(
                                  "Carência (mes) : ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.carencia.toString(),
                                  style: state.textTheme.headline4,
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor Liquido:  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.liquido),
                                    style: state.textTheme.headline4,
                                  )
                                ],
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(children: [
                                Text(
                                  "Taxa (a.m): ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.tx.toStringAsFixed(2),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(width: _width * 0.005),
                                Text(" % ", style: state.textTheme.headline4),
                                const Spacer(),
                                Text(
                                  "Taxa Real(a.m): ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.tir.toStringAsFixed(2),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(width: _width * 0.005),
                                Text(" % ", style: state.textTheme.headline4),
                              ]))
                        ]),
                      ]),
                  SizedBox(height: _height * 0.02),
                  Table(
                    border: TableBorder.all(color: state.unselectedWidgetColor),
                    columnWidths: const <int, TableColumnWidth>{
                      //largura de cada coluna
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(),
                      5: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Text(
                              "Nº.",
                              textAlign: TextAlign.center,
                              style: state.textTheme.headline6,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Data",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Juros",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Amortização",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Parcela",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Saldo Dev.",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                        ],
                      ),
                    ],
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: variables.jurosList.length,
                      itemBuilder: (context, int index) {
                        variables.nparc = index + 1;
                        return Table(
                            border: TableBorder.all(
                                color: state.unselectedWidgetColor),
                            columnWidths: const <int, TableColumnWidth>{
                              //largura de cada coluna
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth(),
                              4: FlexColumnWidth(),
                              5: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(index.toString(),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(variables.dateList[index],
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter
                                            .format(variables.jurosList[index]),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter
                                            .format(variables.amorList[index]),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter
                                            .format(variables.parcList[index]),
                                        style: state.textTheme.headline6,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter
                                            .format(variables.dataList[index]),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                              ])
                            ]);
                      }),
                  Table(
                      border:
                          TableBorder.all(color: state.unselectedWidgetColor),
                      columnWidths: const <int, TableColumnWidth>{
                        //largura de cada coluna
                        0: FlexColumnWidth(0.5),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(),
                        4: FlexColumnWidth(),
                        5: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Text("  ", style: state.textTheme.headline6),
                          Text("TOTAL",
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.totalJ),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.origin!),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.result),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text("  ", style: state.textTheme.headline6),
                        ])
                      ]),
                  SizedBox(height: _height * 0.02),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "* Valores a titulo de simulação, podendo sofrer alterações na contratação. ",
                        textAlign: TextAlign.left,
                        style: state.textTheme.headline6,
                      )),
                  SizedBox(height: _height * 0.01),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "** Taxa Real (a.m): Pagamentos que serão realizados sobre o valor liquido captado. ",
                        textAlign: TextAlign.left,
                        style: state.textTheme.headline6,
                      )),
                ]))));
  }
}
