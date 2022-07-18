import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../src/providers/theme_provider.dart';
import '../../src/save_pdf/pdf_desc.dart';

class DetailDescScreen extends ConsumerStatefulWidget {
  const DetailDescScreen({Key? key}) : super(key: key);

  @override
  DetailDescScreenState createState() => DetailDescScreenState();
}

class DetailDescScreenState extends ConsumerState<DetailDescScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    GenerateDescPDF generatePdf = GenerateDescPDF();
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
                                      "Simulação de Desconto",
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
                                    "Valor total do Desconto :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.dataList.sum),
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
                                    "Taxa de Juros (a.m) :  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    variables.tx.toStringAsFixed(2),
                                    style: state.textTheme.headline4,
                                  ),
                                  SizedBox(width: _width * 0.005),
                                  Text(" % ", style: state.textTheme.headline4),
                                  const Spacer(),
                                ],
                              )),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor do Juros:  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.jurosList.sum),
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
                                    "Valor Líquido:  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(variables.parcList.sum),
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
                                    "Média de dias:  ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    (variables.daysList.sum /
                                            variables.daysList.length)
                                        .toStringAsFixed(1),
                                    style: state.textTheme.headline4,
                                  )
                                ],
                              )),
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
                      5: FlexColumnWidth(0.5),
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
                                "Data de Vencimento",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Valor do título",
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
                                "Valor Líquido",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline6,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Dias",
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
                      itemCount: variables.dataMap!.length,
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
                              5: FlexColumnWidth(0.5),
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
                                    child: Text(
                                        DateFormat("dd/MM/yyyy").format(
                                            variables.dataMap![index]['venc']),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter.format(
                                            variables.dataMap![index]['dado']),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter.format(variables
                                            .dataMap![index]['result']),
                                        style: state.textTheme.bodyText1,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter.format(variables
                                            .dataMap![index]['liquido']),
                                        style: state.textTheme.headline6,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        variables.dataMap![index]['dias']
                                            .toString(),
                                        style: state.textTheme.headline6,
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
                        5: FlexColumnWidth(0.5),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Text("  ", style: state.textTheme.headline4),
                          Text("TOTAL",
                              style: state.textTheme.headline4,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.dataList.sum),
                              style: state.textTheme.headline4,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.jurosList.sum),
                              style: state.textTheme.headline4,
                              textAlign: TextAlign.center),
                          Text(formatter.format(variables.parcList.sum),
                              style: state.textTheme.headline4,
                              textAlign: TextAlign.center),
                          Text("  ", style: state.textTheme.headline4),
                        ])
                      ]),
                  SizedBox(height: _height * 0.02),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "* Valores validos para data do dia ",
                        textAlign: TextAlign.left,
                        style: state.textTheme.headline6,
                      )),
                ]))));
  }
}
