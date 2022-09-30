import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/state_view.dart';

class GeneratePDF {
  /// Cria e Imprime a fatura

  //var dt = DateTime.now();
  var dt = DateFormat("dd/MM/yyyy").format(DateTime.now());
  final pdf = pw.Document();
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  generatePDFInvoice() async {
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(16),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: const <int, pw.TableColumnWidth>{
                    //largura de cada coluna
                    0: pw.FlexColumnWidth(),
                  },
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: <pw.TableRow>[
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                variables.itemSelecionado != "Select Bank"
                                    ? variables.itemSelecionado
                                    : "Simulação de Empréstimo",
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 35),
                              pw.Text(dt,
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold)),
                            ]),
                      ),
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Valor do Empréstimo :  ",
                              ),
                              pw.Text(
                                formatter.format(variables.origin!),
                              ),
                            ],
                          )),
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Valor do Iof :  ",
                              ),
                              pw.Text(
                                formatter.format(variables.iof),
                              ),
                              pw.SizedBox(width: 20),
                              pw.Text(
                                "Iof Adic. : ",
                              ),
                              pw.Text(
                                formatter.format(variables.iofa),
                              ),
                            ],
                          )),
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Outras Despesas : ",
                              ),
                              pw.Text(
                                formatter.format(variables.tarifa),
                              )
                            ],
                          )),
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(
                          children: [
                            pw.Text(
                              "Periodo (mes) : ",
                            ),
                            pw.Text(
                              variables.periodo.toString(),
                            ),
                            pw.SizedBox(
                              width: 5,
                            ),
                            pw.SizedBox(width: 20),
                            pw.Text(
                              "Carência (mes) : ",
                            ),
                            pw.Text(
                              variables.carencia.toString(),
                            ),
                          ],
                        ),
                      )
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Valor Liquido: ",
                              ),
                              pw.Text(
                                formatter.format(variables.liquido),
                              )
                            ],
                          )),
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(children: [
                            pw.Text(
                              "Taxa Nominal (a.m) : ",
                            ),
                            pw.Text(
                              variables.tx.toStringAsFixed(2),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              " % ",
                            ),
                            pw.SizedBox(width: 20),
                            pw.Text(
                              "Taxa Real (a.m) : ",
                            ),
                            pw.Text(
                              variables.tir.toStringAsFixed(2),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              " % ",
                            ),
                          ]))
                    ]),
                  ]),
              pw.SizedBox(height: 15),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: const <int, pw.TableColumnWidth>{
                  //largura de cada coluna
                  0: pw.FlexColumnWidth(0.5),
                  1: pw.FlexColumnWidth(),
                  2: pw.FlexColumnWidth(),
                  3: pw.FlexColumnWidth(),
                  4: pw.FlexColumnWidth(),
                  5: pw.FlexColumnWidth(),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                        child: pw.Text("Nº.", textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child:
                              pw.Text("Data", textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child:
                              pw.Text("Juros", textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text("Amortização",
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text("Parcela",
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text("Saldo Dev.",
                              textAlign: pw.TextAlign.center)),
                    ],
                  ),
                ],
              ),
              pw.ListView.builder(
                  itemCount: variables.jurosList.length,
                  itemBuilder: (context, int index) {
                    variables.nparc = index + 1;
                    return pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: const <int, pw.TableColumnWidth>{
                          //largura de cada coluna
                          0: pw.FlexColumnWidth(0.5),
                          1: pw.FlexColumnWidth(),
                          2: pw.FlexColumnWidth(),
                          3: pw.FlexColumnWidth(),
                          4: pw.FlexColumnWidth(),
                          5: pw.FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            pw.TableCellVerticalAlignment.middle,
                        children: <pw.TableRow>[
                          pw.TableRow(children: <pw.Widget>[
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(index.toString(),
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(variables.dateList[index],
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                    formatter.format(variables.jurosList[index]
                                        ),
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                    formatter.format(variables.amorList[index]
                                        ),
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                    formatter.format(variables.parcList[index]
                                        ),
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                    formatter.format(variables.dataList[index]
                                        ),
                                    textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 9))),
                          ])
                        ]);
                  }),
              pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: const <int, pw.TableColumnWidth>{
                    //largura de cada coluna
                    0: pw.FlexColumnWidth(0.5),
                    1: pw.FlexColumnWidth(),
                    2: pw.FlexColumnWidth(),
                    3: pw.FlexColumnWidth(),
                    4: pw.FlexColumnWidth(),
                    5: pw.FlexColumnWidth(),
                  },
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: <pw.TableRow>[
                    pw.TableRow(children: <pw.Widget>[
                      pw.Text(
                        "  ",
                      ),
                      pw.Text("TOTAL", textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.totalJ),
                          textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.origin!),
                          textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.result),
                          textAlign: pw.TextAlign.center),
                      pw.Text(
                        "  ",
                      ),
                    ])
                  ]),
              pw.SizedBox(height: 10),
              pw.Text(
                  "* Valores a titulo de simulação, podendo sofrer alterações na contratação. ",
                  textAlign: pw.TextAlign.left,style: const pw.TextStyle(fontSize: 8)),
              pw.SizedBox(height: 5),
              pw.Text(
                "** Taxa Real (a.m): Pagamentos que serão realizados sobre o valor liquido captado. ",
                textAlign: pw.TextAlign.left,style: const pw.TextStyle(fontSize: 8)
              ),
            ];
          }),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File receiptFile = File("$documentPath/Simulacao.pdf");
    receiptFile.writeAsBytesSync(await pdf.save());
    Share.shareFiles(['$documentPath/Simulacao.pdf']);
  }
}
