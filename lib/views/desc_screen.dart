import 'package:calculadora_capital/views/detail_desc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';
import '../src/controller/state_view.dart';
import '../src/providers/desc_provider.dart';
import '../src/providers/theme_provider.dart';

class DescScreen extends ConsumerStatefulWidget {
  const DescScreen({Key? key}) : super(key: key);

  @override
  DescScreenState createState() => DescScreenState();
}

class DescScreenState extends ConsumerState<DescScreen> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final desc = ref.read(DescStateViewProvider.notifier);
    final descState = ref.watch(DescStateViewProvider.notifier);

    final controller = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: valorInicial());
    final conttx = MoneyMaskedTextController(
      decimalSeparator: ".",
      thousandSeparator: "",
      initialValue: txInicial(),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child:
                  Text("Desconto de Titulos", style: state.textTheme.caption)),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
                height: _height,
                width: _width,
                color: state.primaryColor,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    color: state.primaryColor,
                    child: Center(
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Digite os dados abaixo : ",
                                        style: state.textTheme.headline1,
                                      )),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Valor do Titulo: R\$",
                                      style: state.textTheme.headline4,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Stack(
                                      children: [
                                        Container(
                                          height: _height * 0.05,
                                          width: _width * 0.45,
                                          decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor,
                                          ),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            height: _height * 0.06,
                                            width: _width * 0.45,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Informe o valor do Titulo";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  errorStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'FuturaPTLight.otf',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 1.0))),
                                              style: state.textTheme.subtitle1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                variables.dado = num.parse(value
                                                    .replaceAll(r'.', "")
                                                    .replaceAll(r',', '.'));
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              cursorColor: state.primaryColor,
                                              textAlign: TextAlign.center,
                                              controller: controller,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Row(children: [
                                    Text("Taxa (a.m) : ",
                                        style: state.textTheme.headline4),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.06,
                                          width: _width * 0.25,
                                          decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor,
                                          )),
                                      Center(
                                          child: SizedBox(
                                              height: _height * 0.075,
                                              width: _width * 0.25,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Taxa";
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    errorStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'FuturaPTLight.otf',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        color: Colors.red),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.0))),
                                                style:
                                                    state.textTheme.subtitle1,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      5)
                                                ],
                                                textInputAction:
                                                    TextInputAction.next,
                                                onChanged: (value) {
                                                  variables.taxa =
                                                      num.parse(value);
                                                  variables.tx =
                                                      double.parse(value);
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: state.primaryColor,
                                                textAlign: TextAlign.center,
                                                controller: conttx,
                                              ))),
                                    ]),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headline4),
                                    Checkbox(
                                        value: variables.check,
                                        onChanged: (val) {
                                          setState(() {
                                            variables.check = val!;
                                          });
                                        }),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Vencimento : ",
                                        style: state.textTheme.headline4),
                                    SizedBox(width: _width * 0.05),
                                    Stack(children: [
                                      Container(
                                          height: _height * 0.05,
                                          width: _width * 0.35,
                                          decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor,
                                          )),
                                      Center(
                                          child: SizedBox(
                                        height: _height * 0.05,
                                        width: _width * 0.35,
                                        child: Center(
                                          child: TextFormField(
                                            controller: desc.dateCtl,
                                            decoration: const InputDecoration(
                                                // labelText: "Date of birth",
                                                // hintText: "Ex. Insert your dob",
                                                ),
                                            onTap: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              variables.dateVenc =
                                                  await showDatePicker(
                                                      initialEntryMode:
                                                          DatePickerEntryMode
                                                              .calendarOnly,
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2100));
                                              desc.dateCtl.text = DateFormat(
                                                      "dd/MM/yyyy")
                                                  .format(variables.dateVenc!);
                                            },
                                          ),
                                        ),
                                      )),
                                    ]),
                                    Checkbox(
                                        value: variables.checkVenc,
                                        onChanged: (val) {
                                          setState(() {
                                            variables.checkVenc = val!;
                                          });
                                        }),
                                  ]),
                                  Row(
                                    children: [
                                      Text("Adicionar titulo a lista "),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (variables.dado == 0.00) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              var snackBar = const SnackBar(
                                                  content:
                                                      Text('Insira um Valor'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else if (variables.tx == 0.00) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              var snackBar = const SnackBar(
                                                  content: Text(
                                                      'Insira a Taxa de Juros'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else if (variables
                                                        .dateVenc!.day ==
                                                    DateTime.now().day &&
                                                variables.dateVenc!.month ==
                                                    DateTime.now().month &&
                                                variables.dateVenc!.year ==
                                                    DateTime.now().year) {
                                              var snackBar = const SnackBar(
                                                  content: Text(
                                                      'Insira uma data Válida'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              _button();
                                              setState(() {
                                                desc.descReset(variables);
                                              });
                                            }
                                          },
                                          child: Icon(Icons.add)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                      'A lista contém ${variables.dataList.length} titulos'),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: _width * 0.5,
                                          height: _height * 0.06,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.indicatorColor),
                                              ),
                                              child: Text("SIMULAR",
                                                  style:
                                                      state.textTheme.caption),
                                              onPressed: () {
                                                if (variables.dado == 0.00) {
                                                  FocusScope.of(context).requestFocus(new FocusNode());
                                                  var snackBar = const SnackBar(
                                                      content: Text(
                                                          'Insira um Valor'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                } else if (variables.tx ==
                                                    0.00) {
                                                  FocusScope.of(context).requestFocus(new FocusNode());
                                                  var snackBar = const SnackBar(
                                                      content: Text(
                                                          'Insira a Taxa de Juros'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                } else if (variables
                                                            .dateVenc!.day ==
                                                        DateTime.now().day &&
                                                    variables.dateVenc!.month ==
                                                        DateTime.now().month &&
                                                    variables.dateVenc!.year ==
                                                        DateTime.now().year) {
                                                  var snackBar = const SnackBar(
                                                      content: Text(
                                                          'Insira uma data Válida'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                } else {
                                                  _button();
                                                  Navigator.pop(context);
                                                  desc.dateCtl.text = '';
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const DetailDescScreen()));
                                                }
                                              })),
                                      const Spacer(),
                                      const Spacer(),
                                      const Spacer(),
                                    ],
                                  ),
                                ])))))));
  }

  _button() {
    var dias = variables.dateVenc!.difference(variables.hoje).inDays;
    variables.taxa = variables.tx / 100;
    var rest = variables.dado * variables.taxa;
    var result = (rest / 30) * dias;
    //adicona o dias a lista
    variables.daysList.add(dias);
    //adiciona o juros a lista
    variables.jurosList.add(result);
    //adiciona o valor do titulo a lista
    variables.dataList.add(variables.dado);
    //adiciona a data de vencimento
    variables.dateVencList.add(variables.dateVenc!);
    //adiciona o valor liquido a lista
    var liquido = variables.dado - result;
    variables.parcList.add(liquido);
    if (variables.test == null) {
      variables.test = [
        {
          'dias': dias,
          'result': result,
          'dado': variables.dado,
          'venc': variables.dateVenc!,
          'liquido': liquido
        }
      ];
    } else {
      variables.test!.add({
        'dias': dias,
        'result': result,
        'dado': variables.dado,
        'venc': variables.dateVenc!,
        'liquido': liquido
      });
    }
    variables.test!.sort((a, b) => a['dias'].compareTo(b['dias']));
    print(variables.test);
  }

  _validador() {}

  valorInicial() {
    double? inicial;
    if (variables.dado != 0.00) {
      inicial = double.parse(variables.dado.toString());
    }
    return inicial;
  }

  txInicial() {
    double? inicial;
    if (variables.tx != 0.00) {
      inicial = variables.tx;
    }
    return inicial;
  }
}
