import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../src/controller/state_view.dart';
import '../../src/keys_utils.dart';
import '../../src/providers/desc_provider.dart';
import '../../src/providers/theme_provider.dart';
import 'detail_desc_screen.dart';
import 'list_Desc_Screen.dart';

class DescScreen extends ConsumerStatefulWidget {
  const DescScreen({Key? key}) : super(key: key);

  @override
  DescScreenState createState() => DescScreenState();
}

class DescScreenState extends ConsumerState<DescScreen> {
  static final _formKey = GlobalKey<FormState>();

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final desc = ref.read(DescStateViewProvider.notifier);

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
              child: Text("Desconto de Titulos",
                  style: state.textTheme.bodySmall)),
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
                                        style: state.textTheme.displayLarge,
                                      )),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Valor do Titulo: R\$",
                                      style: state.textTheme.headlineMedium,
                                    ),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                      alignment: Alignment.center,
                                      height: _height * 0.05,
                                      width: _width * 0.35,
                                      decoration: BoxDecoration(
                                        color: state.unselectedWidgetColor,
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          isCollapsed: true,
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: InputBorder.none,
                                        ),
                                        style: state.textTheme.titleMedium,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          variables.dado = num.parse(value
                                              .replaceAll(r'.', "")
                                              .replaceAll(r',', '.'));
                                        },
                                        textInputAction: TextInputAction.next,
                                        cursorColor: state.primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: controller,
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  Row(children: [
                                    Text("Taxa (a.m) : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                        alignment: Alignment.center,
                                        height: _height * 0.05,
                                        width: _width * 0.25,
                                        decoration: BoxDecoration(
                                          color: variables.check == true
                                              ? state.disabledColor
                                              : state.unselectedWidgetColor,
                                        ),
                                        child: TextFormField(
                                          enabled: variables.check == true
                                              ? false
                                              : true,
                                          decoration: const InputDecoration(
                                            isCollapsed: true,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(5.0),
                                            border: InputBorder.none,
                                          ),
                                          style: state.textTheme.titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(5)
                                          ],
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) {
                                            variables.taxa = num.parse(value);
                                            variables.tx = double.parse(value);
                                          },
                                          keyboardType: TextInputType.number,
                                          cursorColor: state.primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: conttx,
                                        )),
                                    SizedBox(width: _width * 0.03),
                                    Text(" % ",
                                        style: state.textTheme.headlineMedium),
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(children: [
                                    Text("Vencimento : ",
                                        style: state.textTheme.headlineMedium),
                                    SizedBox(width: _width * 0.05),
                                    Container(
                                      alignment: Alignment.center,
                                      height: _height * 0.05,
                                      width: _width * 0.30,
                                      decoration: BoxDecoration(
                                        color: state.unselectedWidgetColor,
                                      ),
                                      child: TextFormField(
                                        enabled: variables.checkVenc == true
                                            ? false
                                            : true,
                                        decoration: const InputDecoration(
                                          isCollapsed: true,
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(5.0),
                                        ),
                                        style: state.textTheme.titleMedium,
                                        controller: desc.dateCtl,
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          _selectDate(context, desc);
                                        },
                                      ),
                                    ),
                                    Checkbox(
                                        side: BorderSide(
                                            color: state.unselectedWidgetColor),
                                        value: variables.checkVenc,
                                        onChanged: (val) {
                                          setState(() {
                                            variables.checkVenc = val!;
                                          });
                                        }),
                                    Text("Manter ",
                                        style: state.textTheme.headlineMedium)
                                  ]),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color(0xff17316B)),
                                          ),
                                          onPressed: () {
                                            _validador(state);
                                            setState(() {
                                              desc.descReset(variables);
                                            });
                                          },
                                          child: Text(
                                            "Adicionar na Lista",
                                            //style: TextStyle(fontSize: 16),
                                            style: state.textTheme.bodySmall,
                                          )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color(0xff17316B)),
                                          ),
                                          onPressed: () {
                                            if (variables.dataMap!.length > 0) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ListDescScreen()));
                                            } else {
                                              var snackBar = SnackBar(
                                                  backgroundColor:
                                                      state.primaryColorDark,
                                                  content: Text(
                                                      'Lista está Vazia',
                                                      style: state.textTheme
                                                          .displayLarge));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          child: Text(
                                            "Editar Lista",
                                            style: state.textTheme.bodySmall,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: variables.dataList.isNotEmpty
                                          ? Text(
                                              'A lista contém ${variables.dataMap!.length} títulos',
                                              style:
                                                  state.textTheme.displayLarge)
                                          : Container()),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 3.0, right: 3.0),
                                          width: _width - 40,
                                          height: _height * 0.06,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        state.indicatorColor),
                                              ),
                                              child: Text("SIMULAR",
                                                  style: state
                                                      .textTheme.bodySmall),
                                              onPressed: () {
                                                //se a lista é vazia
                                                if (variables
                                                    .dataList.isEmpty) {
                                                  _validador(state);
                                                  if (variables.validate ==
                                                      true) {
                                                    Navigator.pop(context);
                                                    desc.dateCtl.text = '';
                                                    showInterstitialAd();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DetailDescScreen()));
                                                  } else {}
                                                } else if (variables
                                                    .dataList.isNotEmpty) {
                                                  if (variables.dado == 0.00 ||
                                                      variables.tx == 0.00 ||
                                                      (variables.dateVenc!
                                                                  .day ==
                                                              DateTime.now()
                                                                  .day &&
                                                          variables.dateVenc!
                                                                  .month ==
                                                              DateTime.now()
                                                                  .month &&
                                                          variables.dateVenc!
                                                                  .year ==
                                                              DateTime.now()
                                                                  .year)) {
                                                    Navigator.pop(context);
                                                    desc.dateCtl.text = '';
                                                    showInterstitialAd();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DetailDescScreen()));
                                                  } else {
                                                    _button();
                                                    Navigator.pop(context);
                                                    desc.dateCtl.text = '';
                                                    showInterstitialAd();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DetailDescScreen()));
                                                  }
                                                }
                                              })),
                                      const Spacer(),
                                      const Spacer(),
                                      const Spacer(),
                                    ],
                                  ),
                                ])))))));
  }

  void _selectDate(BuildContext context, desc) async {
    variables.dateVenc = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (variables.dateVenc != null && variables.dateVenc != DateTime.now()) {
      desc.dateCtl.text = DateFormat("dd/MM/yyyy").format(variables.dateVenc!);
    } else {
      if (variables.dateVenc == null) {}
    }
  }

  _validador(state) {
    if (variables.dado == 0.00) {
      FocusScope.of(context).requestFocus(FocusNode());
      var snackBar = SnackBar(
          backgroundColor: state.primaryColorDark,
          content: Text('Insira o Valor do Título',
              style: state.textTheme.headline1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (variables.tx == 0.00) {
      FocusScope.of(context).requestFocus(FocusNode());
      var snackBar = SnackBar(
          backgroundColor: state.primaryColorDark,
          content:
              Text('Insira a Taxa de Juros', style: state.textTheme.headline1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (variables.dateVenc!.day == DateTime.now().day &&
        variables.dateVenc!.month == DateTime.now().month &&
        variables.dateVenc!.year == DateTime.now().year) {
      FocusScope.of(context).requestFocus(FocusNode());
      var snackBar = SnackBar(
          backgroundColor: state.primaryColorDark,
          content:
              Text('Insira uma Data Válida', style: state.textTheme.headline1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      variables.validate = true;
      _button();
    }
  }

  _button() {
    var dias = variables.dateVenc!.difference(variables.hoje).inDays;
    //Foi necessario adicionar 1 dia
    dias = dias + 1;
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
    variables.check = true;
    if (variables.dataMap == null) {
      variables.dataMap = [
        {
          'dias': dias,
          'result': result,
          'dado': variables.dado,
          'venc': variables.dateVenc!,
          'liquido': liquido,
        }
      ];
    } else {
      variables.dataMap!.add({
        'dias': dias,
        'result': result,
        'dado': variables.dado,
        'venc': variables.dateVenc!,
        'liquido': liquido
      });
    }
    variables.dataMap!.sort((a, b) => a['dias'].compareTo(b['dias']));
  }

  valorInicial() {
    double inicial = 0.00;
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

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Keys().idInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }
}
