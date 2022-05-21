import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/state_view.dart';

class GenerateAplicPDF {
  /// Cria e Imprime a fatura
  var dt = DateFormat("dd/MM/yyyy").format(DateTime.now());
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
                  //largura de cada coluna
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
                              "Simulação Aplicação com Depósitos Regulares",
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
                              "Valor do depósito (mes) :  ",
                            ),
                            pw.Text(
                              formatter.format(variables.dado!),
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
                            "Número de meses:  : ",
                          ),
                          pw.Text(
                            variables.periodo.toString(),
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
                            "Taxa de Juros (a.m) : ",
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
                      child: pw.Row(children: [
                        pw.Text(
                          "Valor Liquido: ",
                        ),
                        pw.Text(
                            formatter.format(variables.liquido),
                        )
                      ]),
                    ),
                  ])
                ]),
            pw.SizedBox(height: 10),
            pw.Text(
                "* Valores a titulo de simulação, podendo sofrer alterações na contratação. ",
                textAlign: pw.TextAlign.left),
          ];
        }));

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File receiptFile = File("$documentPath/Simulacao_Aplicacao.pdf");
    receiptFile.writeAsBytesSync(await pdf.save());
    Share.shareFiles(['$documentPath/Simulacao_Aplicacao.pdf']);
  }
}
