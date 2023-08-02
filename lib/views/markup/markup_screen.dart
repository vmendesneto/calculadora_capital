import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/controller/state_view.dart';
import '../../src/providers/stateview_provider.dart';
import '../../src/providers/theme_provider.dart';
import '../../src/save_pdf/pdf_preco.dart';

class MarkupScreen extends ConsumerStatefulWidget {
  const MarkupScreen({Key? key}) : super(key: key);

  @override
  MarkupScreenState createState() => MarkupScreenState();
}

class MarkupScreenState extends ConsumerState<MarkupScreen> {
  static final _formKey = GlobalKey<FormState>();

  final contFat = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  final contCusto = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  final contCompra = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  final conttx = MoneyMaskedTextController(
    decimalSeparator: ".",
    thousandSeparator: "",
    initialValue: 0.00,
  );
  final contCartao = MoneyMaskedTextController(
    decimalSeparator: ".",
    thousandSeparator: "",
    initialValue: 0.00,
  );
  final contEmp = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  bool btalterar = false;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider);
    GeneratePrecoPDF generatePrecoPdf = GeneratePrecoPDF();
print("size width $_width");

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.primaryColor,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: state.primaryColor,
              ),
              onPressed: () async {
                generatePrecoPdf.generatePDFInvoice();
              },
            )
          ],
          iconTheme: IconThemeData(color: state.primaryColor),
          backgroundColor: state.hoverColor,
          title: Center(
              child: Text("Preço de Venda", style: state.textTheme.bodySmall)),
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
                                    height: _height * 0.01,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Digite os dados abaixo : ",
                                        style: state.textTheme.displayLarge,
                                      )),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Faturamento Médio: R\$",
                                        style: state.textTheme.headlineSmall),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                      height: _height * 0.04,
                                      width: _width * 0.45,
                                      decoration: BoxDecoration(
                                        color: state.unselectedWidgetColor,
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          onChanged: (value) {
                                            variables.dado = num.parse(value
                                                .replaceAll(r'.', "")
                                                .replaceAll(r',', '.'));
                                          },
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: contFat,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Custo Fixo + Custo Variavél : R\$",
                                      style: state.textTheme.headlineSmall,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                      height: _height * 0.04,
                                      width: _width * 0.35,
                                      decoration: BoxDecoration(
                                        color: state.unselectedWidgetColor,
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          onChanged: (value) {
                                            variables.totalP = num.parse(value
                                                .replaceAll(r'.', "")
                                                .replaceAll(r',', '.'));
                                          },
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: contCusto,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Preço de Compra : R\$",
                                        style: state.textTheme.headlineSmall),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                      height: _height * 0.04,
                                      width: _width * 0.45,
                                      decoration: BoxDecoration(
                                        color: state.unselectedWidgetColor,
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          onChanged: (value) {
                                            variables.totalJ = num.parse(value
                                                .replaceAll(r'.', "")
                                                .replaceAll(r',', '.'));
                                          },
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: contCompra,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Lucro : ",
                                        style: state.textTheme.headlineSmall),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                        height: _height * 0.04,
                                        width: _width * 0.25,
                                        decoration: BoxDecoration(
                                          color: btalterar == false
                                              ? state.unselectedWidgetColor
                                              : state.disabledColor,
                                        ),
                                        child: Center(
                                            child: btalterar == false
                                                ? TextFormField(
                                                    enabled:
                                                        viewState.enabled ==
                                                                true
                                                            ? true
                                                            : false,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    style: state
                                                        .textTheme.titleMedium,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          4)
                                                    ],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onChanged: (value) {
                                                      variables.taxa =
                                                          num.parse(value);
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        state.primaryColor,
                                                    textAlign: TextAlign.center,
                                                    controller: conttx,
                                                  )
                                                : Center(
                                                    child: Text(
                                                    variables.taxa
                                                        .toStringAsFixed(2),
                                                    style: state
                                                        .textTheme.titleMedium,
                                                  )))),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Taxa de Cartão  : ",
                                        style: state.textTheme.headlineSmall),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                        height: _height * 0.04,
                                        width: _width * 0.25,
                                        decoration: BoxDecoration(
                                            color: state.unselectedWidgetColor),
                                        child: Center(
                                            child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4)
                                          ],
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) {
                                            variables.iof = num.parse(value);
                                          },
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: contCartao,
                                        ))),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.01),
                                    Text("( Opcional ) ",
                                        style: state.textTheme.headlineSmall),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Custo : ",
                                        style: state.textTheme.headlineSmall),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                        height: _height * 0.04,
                                        width: _width * 0.25,
                                        decoration: BoxDecoration(
                                          color: state.disabledColor,
                                        ),
                                        child: Center(
                                            child: Text(
                                          variables.tx.toStringAsFixed(2),
                                          style: state.textTheme.titleMedium,
                                        ))),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Preço de Venda : R\$",
                                            style:
                                                state.textTheme.headlineSmall),
                                      //  SizedBox(width: _width * 0.05),
                                        Container(
                                            height: _height * 0.04,
                                            width: _width * 0.35,
                                            decoration: BoxDecoration(
                                              color: btalterar == false
                                                  ? state.disabledColor
                                                  : state.unselectedWidgetColor,
                                            ),
                                            child: Center(
                                                child: Center(
                                              child: btalterar == false
                                                  ? Text(
                                                      contEmp.text,
                                                      style: state.textTheme
                                                          .titleMedium,
                                                    )
                                                  : TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      style: state.textTheme
                                                          .titleMedium,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            11)
                                                      ],
                                                      onChanged: (value) {
                                                        variables.emp =
                                                            num.parse(value
                                                                .replaceAll(
                                                                    r'.', "")
                                                                .replaceAll(
                                                                    r',', '.'));
                                                      },
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor:
                                                          state.primaryColor,
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: contEmp,
                                                    ),
                                            ))),
                                        SizedBox(width: _width * 0.006),
                                        Container(
                                            // margin: const EdgeInsets.all(8.0),
                                            //padding: const EdgeInsets.all(8.0),
                                            height: _height * 0.04,
                                            width: _width * 0.2,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          state.indicatorColor),
                                                ),
                                                child: Text("Alterar",
                                                    style: state.textTheme
                                                        .headlineLarge),
                                                onPressed: () {
                                                  setState(() {
                                                    btalterar = !btalterar;
                                                  });
                                                })),
                                      ]),
                                  Container(
                                      // margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      width: _width,
                                      height: _height * 0.07,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    state.indicatorColor),
                                          ),
                                          child: btalterar == false
                                              ? Text("Calcular Preço",
                                                  style:
                                                      state.textTheme.bodySmall)
                                              : Text("Calcular Lucro",
                                                  style: state
                                                      .textTheme.bodySmall),
                                          onPressed: () {
                                            if (variables.dado <=
                                                variables.totalP) {
                                              showAlertDialog(context, state,
                                                  "Faturamento não pode ser menor ou igual que custo.");
                                            } else if (variables.totalJ == 0) {
                                              showAlertDialog(context, state,
                                                  "Preço de Compra tem que ser maior que 0.");
                                            } else if (variables.taxa <= 0 ||
                                                variables.taxa >= 100.00) {
                                              showAlertDialog(context, state,
                                                  "Lucro tem que ser maior que 0 e menor que 100.");
                                            } else {
                                              setState(() {
                                                if (btalterar == false) {
                                                  calculoPVenda(
                                                      contEmp, context, state);
                                                } else {
                                                  if (variables.emp <
                                                      variables.totalJ) {
                                                    showAlertDialog(
                                                        context,
                                                        state,
                                                        "Preço de venda não pode ser menor do que preço de compra.");
                                                  } else {
                                                    calculoLucro(
                                                        conttx,
                                                        contEmp,
                                                        context,
                                                        state);
                                                    btalterar = false;
                                                  }
                                                }
                                              });
                                            }
                                          })),
                                ])))))));
  }
}

calculoPVenda(contEmp, BuildContext context, state) {
  variables.tx = 0.00;
  variables.emp = 0.00;
  num taxa = variables.taxa / 100;
  num cartao = variables.iof / 100;
  variables.tx = variables.totalP / variables.dado;
  num soma = (taxa + variables.tx + cartao);
  if (soma >= 1) {
    showAlertDialog(
        context, state, "Lucro + Custo + Cartão não pode ultrapassar 100 %.");
  } else {
    num t = 1 - soma;
    variables.emp = variables.totalJ / t;

    contEmp.text = variables.emp.toStringAsFixed(2);
    variables.tx = variables.tx * 100;
  }
}

calculoLucro(conttx, contEmp, BuildContext context, state) {
  variables.tx = 0.00;
  num cartao = variables.iof / 100;
  variables.tx = variables.totalP / variables.dado;
  num mult = variables.tx * variables.emp;
  num soma = variables.totalJ + mult;
  num subt = variables.emp - soma;
  num result = subt / variables.emp;
  num validacao = result + cartao + variables.tx;
  if (validacao >= 1) {
    showAlertDialog(context, state,
        "Preço de Venda Inválido, Lucro + Custo + Cartão não pode ultrapassar 100 %.");
  } else {
    variables.taxa = result * 100;
    conttx.text = variables.taxa.toStringAsFixed(2);
    contEmp.text = variables.emp.toStringAsFixed(2);
    variables.tx = variables.tx * 100;
  }
}

showAlertDialog(BuildContext context, state, String message) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: state.primaryColor,
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: state.textTheme.subtitle2,
          )),
        );
      });

  //await Future.delayed(const Duration(seconds: 2));
  //viewStateController.Reset(variables);
  // Navigator.pop(context);
}
