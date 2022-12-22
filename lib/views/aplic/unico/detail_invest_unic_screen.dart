
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../src/ calculation/variables.dart';
import '../../../src/providers/theme_provider.dart';
import '../../../src/save_pdf/pdf_aplic_unic.dart';

class DetailScreenAplUnic extends ConsumerStatefulWidget {
  num? taxa, liquido,dado,periodo;
   DetailScreenAplUnic({Key? key,this.dado,this.liquido,this.periodo, this.taxa }) : super(key: key);

  @override
  DetailScreenAplUnicState createState() => DetailScreenAplUnicState();
}

class DetailScreenAplUnicState extends ConsumerState<DetailScreenAplUnic> {

  Variables variables = Variables();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    GenerateAplicUnicPDF generatePdf = GenerateAplicUnicPDF();
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
                                      "Aplicação com Investimento Unico",
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
                                    "Valor do Investimento : ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(widget.dado),
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
                                  "Número de meses :  ",
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  widget.periodo.toString(),
                                  style: state.textTheme.headline4,
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
                                  style: state.textTheme.headline4,
                                ),
                                Text(
                                  widget.taxa!.toStringAsFixed(2),
                                  style: state.textTheme.headline4,
                                ),
                                SizedBox(width: _width * 0.01),
                                Text(" % ", style: state.textTheme.headline4),
                              ]))
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Rendimento : ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(widget.liquido! -
                                        widget.dado!),
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
                                    "Valor obtido ao Final : ",
                                    style: state.textTheme.headline4,
                                  ),
                                  Text(
                                    formatter.format(widget.liquido),
                                    style: state.textTheme.headline4,
                                  )
                                ],
                              )),
                        ]),
                      ]),
                  SizedBox(height: _height * 0.02),
                  Text(
                    "* Valores a titulo de simulação, podendo sofrer alterações na contratação. ",
                    textAlign: TextAlign.left,
                    style: state.textTheme.headline6,
                  ),
                ]))));
  }
}
