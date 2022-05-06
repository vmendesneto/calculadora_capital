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
                            pw.Text("Simulação de Empréstimo  ",
                            style: pw.TextStyle(
                                fontSize: 20, fontWeight: pw.FontWeight.bold),
                            ),
                              pw.SizedBox(width: 35),
                        pw.Text(dt ,
                            style: pw.TextStyle(
                                fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      ]),
                      ),
                   ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Valor do Empréstimo : R\$ ",
                              ),
                              pw.Text(
                                variables.origin!.toStringAsFixed(2),
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
                                "Valor do Iof : R\$ ",
                              ),
                              pw.Text(
                                variables.iof.toStringAsFixed(2),
                              ),
                              pw.Spacer(),
                              pw.Text(
                                "Iof Adic. : R\$ ",
                              ),
                              pw.Text(
                                variables.iofa.toStringAsFixed(2),
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
                                "Outras Despesas : R\$ ",
                              ),
                              pw.Text(
                                variables.tarifa.toStringAsFixed(2),
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
                            pw.Spacer(),
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
                                "Valor Liquido: R\$ ",
                              ),
                              pw.Text(
                                variables.liquido.toStringAsFixed(2),
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
                            pw.Spacer(),
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
              pw.SizedBox(height: 20),
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
                        padding: pw.EdgeInsets.only(top: 2, bottom: 2),
                        child: pw.Text("Nº.", textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, bottom: 2),
                          child:
                              pw.Text("Data", textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, bottom: 2),
                          child:
                              pw.Text("Juros", textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text("Amortização",
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text("Parcela",
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, bottom: 2),
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
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(variables.dateList[index],
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    variables.jurosList[index]
                                        .toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    variables.amorList[index]
                                        .toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    variables.parcList[index]
                                        .toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    variables.dataList[index]
                                        .toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center)),
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
                      pw.Text(variables.totalJ.toStringAsFixed(2),
                          textAlign: pw.TextAlign.center),
                      pw.Text(variables.origin!.toStringAsFixed(2),
                          textAlign: pw.TextAlign.center),
                      pw.Text(variables.result.toStringAsFixed(2),
                          textAlign: pw.TextAlign.center),
                      pw.Text(
                        "  ",
                      ),
                    ])
                  ])
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
