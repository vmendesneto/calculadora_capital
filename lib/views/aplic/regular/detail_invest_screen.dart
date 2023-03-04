import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../src/providers/theme_provider.dart';
import '../../../src/save_pdf/pdf_aplic.dart';

class DetailScreenApl extends ConsumerStatefulWidget {
  const DetailScreenApl({Key? key}) : super(key: key);

  @override
  DetailScreenAplState createState() => DetailScreenAplState();
}

class DetailScreenAplState extends ConsumerState<DetailScreenApl> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    GenerateAplicPDF generatePdf = GenerateAplicPDF();
    var dt = DateFormat("dd/MM/yyyy").format(DateTime.now());
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          title: Text(
            "Analítico da Simulação",
            style: state.textTheme.bodySmall,
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
                                      "Aplicação com Depósitos Regulares",
                                      style: state.textTheme.headlineMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: _width * 0.1),
                                    Text(dt, style: state.textTheme.headlineMedium),
                                  ]))
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor do depósito (mes) : ",
                                    style: state.textTheme.headlineMedium,
                                  ),
                                  Text(
                                    formatter.format(variables.dado),
                                    style: state.textTheme.headlineMedium,
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
                                  "Número de meses:  : ",
                                  style: state.textTheme.headlineMedium,
                                ),
                                Text(
                                  variables.periodo.toString(),
                                  style: state.textTheme.headlineMedium,
                                ),
                                SizedBox(
                                  width: _width * 0.1,
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(children: [
                                Text(
                                  "Taxa de Juros (a.m) : ",
                                  style: state.textTheme.headlineMedium,
                                ),
                                Text(
                                  variables.tx.toStringAsFixed(2),
                                  style: state.textTheme.headlineMedium,
                                ),
                                SizedBox(width: _width * 0.01),
                                Text(" % ", style: state.textTheme.headlineMedium),
                              ]))
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Valor Investido : ",
                                    style: state.textTheme.headlineMedium,
                                  ),
                                  Text(
                                    formatter.format(
                                        variables.dado * variables.periodo),
                                    style: state.textTheme.headlineMedium,
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
                                    "Rendimento : ",
                                    style: state.textTheme.headlineMedium,
                                  ),
                                  Text(
                                    formatter.format(variables.liquido -
                                        (variables.dado * variables.periodo)),
                                    style: state.textTheme.headlineMedium,
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
                                    "Valor obtido ao Final : ",
                                    style: state.textTheme.headlineMedium,
                                  ),
                                  Text(
                                    formatter.format(variables.liquido),
                                    style: state.textTheme.headlineMedium,
                                  )
                                ],
                              )),
                        ]),
                      ]),
                  SizedBox(height: _height * 0.02),
                  Text(
                    "* Valores a titulo de simulação, podendo sofrer alterações na contratação. ",
                    textAlign: TextAlign.left,
                    style: state.textTheme.titleLarge,
                  ),
                ]))));
  }
}
