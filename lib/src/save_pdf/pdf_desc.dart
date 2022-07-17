import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/state_view.dart';
import 'package:collection/collection.dart';

class GenerateDescPDF {
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
                                pw.Text("Simulação de Desconto",
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 35),
                                pw.Text(dt,
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold)),
                              ]))
                    ]),
                    pw.TableRow(children: <pw.Widget>[
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Valor total do Desconto :  ",
                              ),
                              pw.Text(
                                formatter.format(variables.dataList.sum),
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
                                "Taxa de Juros (a.m) :  ",
                              ),
                              pw.Text(
                                variables.tx.toStringAsFixed(2),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                " % ",
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
                                "Valor do Juros:  ",
                              ),
                              pw.Text(
                                formatter.format(variables.jurosList.sum),
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
                                "Valor Líquido:  ",
                              ),
                              pw.Text(
                                formatter.format(variables.parcList.sum),
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
                                "Média de dias:  ",
                              ),
                              pw.Text(
                                (variables.daysList.sum /
                                        variables.daysList.length)
                                    .toStringAsFixed(0),
                              )
                            ],
                          )),
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
                  5: pw.FlexColumnWidth(0.5),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                        child: pw.Text(
                          "Nº.",
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text(
                            "Data de Vencimento",
                            textAlign: pw.TextAlign.center,
                          )),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text(
                            "Valor do título",
                            textAlign: pw.TextAlign.center,
                          )),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text(
                            "Juros",
                            textAlign: pw.TextAlign.center,
                          )),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text(
                            "Valor Líquido",
                            textAlign: pw.TextAlign.center,
                          )),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2, bottom: 2),
                          child: pw.Text(
                            "Dias",
                            textAlign: pw.TextAlign.center,
                          )),
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
                          5: pw.FlexColumnWidth(0.5),
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
                                child: pw.Text(
                                    DateFormat("dd/MM/yyyy").format(
                                        variables.dataMap![index]['venc']),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    formatter.format(
                                        variables.dataMap![index]['dado']),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    formatter.format(
                                        variables.dataMap![index]['result']),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    formatter.format(
                                        variables.dataMap![index]['liquido']),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding:
                                    const pw.EdgeInsets.only(top: 2, bottom: 2),
                                child: pw.Text(
                                    variables.dataMap![index]['dias']
                                        .toString(),
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
                    5: pw.FlexColumnWidth(0.5),
                  },
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: <pw.TableRow>[
                    pw.TableRow(children: <pw.Widget>[
                      pw.Text(
                        "  ",
                      ),
                      pw.Text("TOTAL", textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.dataList.sum),
                          textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.jurosList.sum),
                          textAlign: pw.TextAlign.center),
                      pw.Text(formatter.format(variables.parcList.sum),
                          textAlign: pw.TextAlign.center),
                      pw.Text(
                        "  ",
                      ),
                    ])
                  ]),
              pw.SizedBox(height: 10),
              pw.Text("* Valores validos para data do dia ",
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 8)),
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
