import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/state_view.dart';

class GeneratePrecoPDF {
  final pdf = pw.Document();
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  generatePDFInvoice() async {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(children: <pw.Widget>[
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              " Preço de Venda ",
                              style: pw.TextStyle(
                                  fontSize: 20, fontWeight: pw.FontWeight.bold),
                            ),
                          ]),
                    ),
                  ]),
                  pw.TableRow(children: <pw.Widget>[
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(
                          children: [
                            pw.Text(
                              "Faturamento Médio : ",
                            ),
                            pw.Text(
                              formatter.format(variables.dado),
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
                              "Custos : ",
                            ),
                            pw.Text(
                              formatter.format(variables.totalP),
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
                              "Preço de Compra : ",
                            ),
                            pw.Text(
                              formatter.format(variables.totalJ),
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
                            "Lucro : ",
                          ),
                          pw.Text(
                            variables.taxa.toStringAsFixed(2),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            " % ",
                          ),
                        ],
                      ),
                    )
                  ]),
                  pw.TableRow(children: <pw.Widget>[
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(children: [
                          pw.Text(
                            "Taxa de Cartão : ",
                          ),
                          pw.Text(
                            variables.iof.toStringAsFixed(2),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            " % ",
                          ),
                        ])),
                  ]),
                  pw.TableRow(children: <pw.Widget>[
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(children: [
                          pw.Text(
                            "Custo : ",
                          ),
                          pw.Text(
                            variables.tx.toStringAsFixed(2),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            " % ",
                          ),
                        ])),
                  ]),
                  pw.TableRow(children: <pw.Widget>[
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Row(
                          children: [
                            pw.Text(
                              "Preço de Venda : ",
                            ),
                            pw.Text(
                              formatter.format(variables.emp),
                            )
                          ],
                        )),
                  ]),
                ])
          ];
        }));

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File receiptFile = File("$documentPath/Preço_Venda.pdf");
    receiptFile.writeAsBytesSync(await pdf.save());
    Share.shareFiles(['$documentPath/Preço_Venda.pdf']);
  }
}
