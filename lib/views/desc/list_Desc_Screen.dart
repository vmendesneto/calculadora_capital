import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import '../../src/providers/theme_provider.dart';

class ListDescScreen extends ConsumerStatefulWidget {
  const ListDescScreen({Key? key}) : super(key: key);

  @override
  ListDescScreenState createState() => ListDescScreenState();
}

class ListDescScreenState extends ConsumerState<ListDescScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Scaffold(
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          title: Text("Lista de Títulos Incluídos",
              style: state.textTheme.caption, textAlign: TextAlign.center),
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
                    border: TableBorder.all(color: state.unselectedWidgetColor),
                    columnWidths: const <int, TableColumnWidth>{
                      //largura de cada coluna
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      // 3: FlexColumnWidth(),
                      // 4: FlexColumnWidth(),
                      // 5: FlexColumnWidth(0.5),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Text(
                              " Excluir",
                              textAlign: TextAlign.center,
                              style: state.textTheme.headline4,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Data de Vencimento",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline4,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                "Valor do título",
                                textAlign: TextAlign.center,
                                style: state.textTheme.headline4,
                              )),
                          // Padding(
                          //     padding: const EdgeInsets.only(top: 2, bottom: 2),
                          //     child: Text(
                          //       "Juros",
                          //       textAlign: TextAlign.center,
                          //       style: state.textTheme.headline6,
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.only(top: 2, bottom: 2),
                          //     child: Text(
                          //       "Valor Líquido",
                          //       textAlign: TextAlign.center,
                          //       style: state.textTheme.headline6,
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.only(top: 2, bottom: 2),
                          //     child: Text(
                          //       "Dias",
                          //       textAlign: TextAlign.center,
                          //       style: state.textTheme.headline6,
                          //     )),
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
                        return Table(
                            border: TableBorder.all(
                                color: state.unselectedWidgetColor),
                            columnWidths: const <int, TableColumnWidth>{
                              //largura de cada coluna
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              // 3: FlexColumnWidth(),
                              // 4: FlexColumnWidth(),
                              // 5: FlexColumnWidth(0.5),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        AlertDialog alert = AlertDialog(
                                          backgroundColor: state.primaryColor,
                                          title: Text(
                                            "Excluir",
                                            style: state.textTheme.subtitle2,
                                          ),
                                          content: Text(
                                            "Confirma a exclusão do título de ${formatter.format(variables.dataMap![index]['dado'])} com vencimento em ${DateFormat("dd/MM/yyyy").format(variables.dataMap![index]['venc'])} ? ",
                                            style: state.textTheme.subtitle2,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.hoverColor),
                                              ),
                                              child: const Text("Cancelar",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.hoverColor),
                                              ),
                                              child: const Text("Excluir",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                setState(() {
                                                  Map<String, dynamic> remover =
                                                      {};
                                                  remover =
                                                      variables.dataMap![index];
                                                  variables.dataList
                                                      .remove(remover['dado']);
                                                  variables.dateVencList
                                                      .remove(remover['venc']);
                                                  variables.jurosList.remove(
                                                      remover['result']);
                                                  variables.parcList.remove(
                                                      remover['liquido']);

                                                  variables.dataMap!
                                                      .removeAt(index);

                                                  variables.dataMap =
                                                      variables.dataMap;
                                                });

                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                            ),
                                          ],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: 25,
                                        color: state.unselectedWidgetColor,
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        DateFormat("dd/MM/yyyy").format(
                                            variables.dataMap![index]['venc']),
                                        style: state.textTheme.headline4,
                                        textAlign: TextAlign.center)),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                        formatter.format(
                                            variables.dataMap![index]['dado']),
                                        style: state.textTheme.headline4,
                                        textAlign: TextAlign.center)),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 2, bottom: 2),
                                //     child: Text(
                                //         formatter.format(variables
                                //             .dataMap![index]['result']),
                                //         style: state.textTheme.headline4,
                                //         textAlign: TextAlign.center)),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 2, bottom: 2),
                                //     child: Text(
                                //         formatter.format(variables
                                //             .dataMap![index]['liquido']),
                                //         style: state.textTheme.headline4,
                                //         textAlign: TextAlign.center)),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 2, bottom: 2),
                                //     child: Text(
                                //         variables.dataMap![index]['dias']
                                //             .toString(),
                                //         style: state.textTheme.headline4,
                                //         textAlign: TextAlign.center)),
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
                        // 3: FlexColumnWidth(),
                        // 4: FlexColumnWidth(),
                        // 5: FlexColumnWidth(0.5),
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
                          // Text(formatter.format(variables.jurosList.sum),
                          //     style: state.textTheme.headline4,
                          //     textAlign: TextAlign.center),
                          // Text(formatter.format(variables.parcList.sum),
                          //     style: state.textTheme.headline4,
                          //     textAlign: TextAlign.center),
                          // Text("  ", style: state.textTheme.headline4),
                        ])
                      ]),
                  SizedBox(height: _height * 0.02),
                ]))));
  }
}
