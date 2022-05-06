import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:calculadora_capital/src/save_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          title: Text(
            "Analítico da Simulação",
            style: state.textTheme.caption,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
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
                //width: _width,
                //height: _height,
                decoration: BoxDecoration(color: state.primaryColor),
                child: Column(children: [
                  Table(
                      border: TableBorder.all(color: state.unselectedWidgetColor),
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
                                children: [
                                  Text(
                                    "Valor do Empréstimo : R\$ ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.origin!.toStringAsFixed(2),
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
                                    "Valor do Iof : R\$ ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.iof.toStringAsFixed(2),
                                    style: state.textTheme.headline4,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Iof Adic. : R\$ ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.iofa.toStringAsFixed(2),
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
                                    "Outras Despesas : R\$ ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.tarifa.toStringAsFixed(2),
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
                                  width: _width * 0.1,
                                ),
                                Spacer(),
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
                                    "Valor Liquido: R\$ ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.liquido.toStringAsFixed(2),
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
                                  "Taxa Nominal (a.m) : ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.tx.toStringAsFixed(2),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(width: _width * 0.01),
                                Text(" % ", style: state.textTheme.headline4),
                                Spacer(),
                                Text(
                                  "Taxa Real (a.m) : ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  variables.tir.toStringAsFixed(2),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(width: _width * 0.01),
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
                    children:  <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Text("Nº.", textAlign: TextAlign.center, style: state.textTheme.headline6,),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text("Data", textAlign: TextAlign.center,style: state.textTheme.headline6,)),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child:
                                  Text("Juros", textAlign: TextAlign.center,style: state.textTheme.headline6,)),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text("Amortização",
                                  textAlign: TextAlign.center,style: state.textTheme.headline6,)),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child:
                                  Text("Parcela", textAlign: TextAlign.center,style: state.textTheme.headline6,)),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text("Saldo Dev.",
                                  textAlign: TextAlign.center,style: state.textTheme.headline6,)),
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
                                        variables.jurosList[index]
                                            .toStringAsFixed(2),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        variables.amorList[index]
                                            .toStringAsFixed(2),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        variables.parcList[index]
                                            .toStringAsFixed(2),
                                        style: state.textTheme.headline6,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        variables.dataList[index]
                                            .toStringAsFixed(2),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                              ])
                            ]);
                      }),
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
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Text("  ", style: state.textTheme.headline6),
                          Text("TOTAL",
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(variables.totalJ.toStringAsFixed(2),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(variables.origin!.toStringAsFixed(2),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text(variables.result.toStringAsFixed(2),
                              style: state.textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text("  ", style: state.textTheme.headline6),
                        ])
                      ])
                ]))));
  }
}
