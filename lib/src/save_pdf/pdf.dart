import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/state_view.dart';

class GeneratePDF {
  /// Cria e Imprime a fatura

  var dt = DateTime.now();
  final pdf = pw.Document();

  generatePDFInvoice() async {
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(16),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Header(
                //level: 0,
                child: pw.Row(
                  //mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Valor do Empréstimo : R\$ ",
                    ),
                    pw.Text(
                      variables.origin!.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
              pw.Header(
                child: pw.Row(
                  children: [
                    pw.Text(
                      "Valor do Iof : R\$ ",
                    ),
                    pw.Text(
                      variables.iof.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
              pw.Header(
                child: pw.Row(
                  children: [
                    pw.Text(
                      "Valor do Iof Adic. : R\$ ",
                    ),
                    pw.Text(
                      variables.iofa.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
              pw.Header(
                child: pw.Row(
                  children: [
                    pw.Text(
                      "Outras Despesas : R\$ ",
                    ),
                    pw.Text(
                      variables.tarifa.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Header(
                    child: pw.Row(
                  children: [
                    pw.Text(
                      "Periodo (mes) : ",
                    ),
                    pw.Text(
                      variables.periodo.toString(),
                    ),
                    pw.SizedBox(
                      width: 40,
                    ),
                  ],
                )),
                pw.SizedBox(width: 20),
                pw.Header(
                  child: pw.Row(
                    children: [
                      pw.Text(
                        "Carência (mes) : ",
                      ),
                      pw.Text(
                        variables.carencia.toString(),
                      ),
                    ],
                  ),
                ),
              ]),
              pw.Header(
                child: pw.Row(
                  children: [
                    pw.Text(
                      "Valor Liquido: R\$ ",
                    ),
                    pw.Text(
                      variables.liquido.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Header(
                    child: pw.Row(
                  children: [
                    pw.Text(
                      "Taxa Nominal (a.m) : ",
                    ),
                    pw.Text(
                      variables.tx.toStringAsFixed(2),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      " % ",
                    ),
                  ],
                )),
                pw.SizedBox(width: 20),
                pw.Header(
                    child: pw.Row(
                  children: [
                    pw.Text(
                      "Taxa Real (a.m) : ",
                    ),
                    pw.Text(
                      variables.tir.toStringAsFixed(2),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      " % ",
                    ),
                  ],
                )),
              ]),
              pw.Header(
                child: pw.SizedBox(height: 4),
              ),
              pw.Header(
                  child: pw.Align(
                      alignment: pw.Alignment.topCenter,
                      child: pw.Column(children: [
                        pw.Header(
                            child: pw.Row(
                          children: [
                            pw.Text(
                              "Nº.",
                            ),
                            pw.Spacer(),
                            pw.Spacer(),
                            pw.Text(
                              "Data",
                            ),
                            pw.Spacer(),
                            pw.Spacer(),
                            //pw.Spacer(),
                            pw.Text(
                              "Juros",
                            ),
                            pw.Spacer(),
                            pw.Text(
                              "Amortização",
                            ),
                            pw.Spacer(),
                            pw.Text(
                              "Parcela",
                            ),
                            pw.Spacer(),
                            pw.Text(
                              "Saldo Dev.",
                            ),
                          ],
                        )),
                      ]))),
              pw.ListView.builder(
                  itemCount: variables.jurosList.length,
                  itemBuilder: (context, int index) {
                    variables.nparc = index + 1;
                    return pw.Header(
                        child: pw.Row(children: [
                      pw.Text(
                        index.toString(),
                      ),
                      pw.Spacer(),
                      pw.Text(
                        variables.dateList[index],
                      ),
                      pw.Spacer(),
                      pw.Text(
                        variables.jurosList[index].toStringAsFixed(2),
                      ),
                      pw.Spacer(),
                      pw.Text(
                        variables.amorList[index].toStringAsFixed(2),
                      ),
                      pw.Spacer(),
                      pw.Text(
                        variables.parcList[index].toStringAsFixed(2),
                      ),
                      pw.Spacer(),
                      pw.Text(
                        variables.dataList[index].toStringAsFixed(2),
                      ),
                    ]));
                  }),
              pw.Header(
                  child: pw.Row(children: [
                pw.Spacer(),
                pw.Spacer(),
                pw.Text(
                  "TOTAL",
                ),
                pw.Spacer(),
                    pw.Spacer(),
                pw.Text(
                  variables.totalJ.toStringAsFixed(2),
                ),
                pw.Spacer(),
                pw.Text(
                  variables.origin!.toStringAsFixed(2),
                ),
                pw.Spacer(),
                pw.Text(
                  variables.result.toStringAsFixed(2),
                ),
                pw.Spacer(),
                pw.Spacer(),
                pw.Text(
                  "  ",
                ),
              ]))
            ];
          }),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File receiptFile = File("$documentPath/receipt.pdf");
    receiptFile.writeAsBytesSync(await pdf.save());
    Share.shareFiles(['$documentPath/receipt.pdf']);
  }
}
