import 'package:calculadora_capital/src/%20calculation/iof_value.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../src/controller/state_view.dart';
import '../src/providers/theme_provider.dart';

class ConfigScreen extends ConsumerStatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  ConfigScreenState createState() => ConfigScreenState();
}

class ConfigScreenState extends ConsumerState<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    final iof = Iof();
    final state = ref.watch(themeProvider);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    var newIof = iof.iofValue * 100;
    var newIofadc = iof.iofAdcValue * 100;
    final controller = TextEditingController(text: newIof.toString());
    final controlleradc = TextEditingController(text: newIofadc.toString());

    return Scaffold(
      backgroundColor: state.primaryColor,
      appBar: AppBar(
        backgroundColor: state.primaryColor,
        elevation: 0.0,
      ),
    body: Container(
      margin: const EdgeInsets.all(10),
      color: state.primaryColor,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Valor do IOF : ",
                style: state.textTheme.headline4,
              ),
      Stack(
        children: [
          Container(
            height: _height * 0.05,
            width: _width * 0.3,
            decoration: BoxDecoration(
              color: state.unselectedWidgetColor,
            ),
          ),
          Center(child: SizedBox(
                height: _height * 0.05,
                width: _width * 0.3,
                child: TextFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: state.textTheme.subtitle1,
                  inputFormatters: [
                   // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(7)
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: state.primaryColor,
                  textAlign: TextAlign.center,
                  //initialValue: variables.iof,
                  controller: controller,
                ),
              ))]),
              Text(
                " % ",
                style: state.textTheme.headline4,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Valor do IOF Adicional : ",
                style: state.textTheme.headline4,
              ),
      Stack(
        children: [
          Container(
            height: _height * 0.05,
            width: _width * 0.3,
            decoration: BoxDecoration(
              color: state.unselectedWidgetColor,
            ),
          ),
          Center(child:SizedBox(
                height: _height * 0.05,
                width: _width * 0.3,
                child: TextFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: state.textTheme.subtitle1,
                  inputFormatters: [
                   // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5)
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: state.primaryColor,
                  textAlign: TextAlign.center,
                  //initialValue: variables.iofa.toString(),
                  controller: controlleradc,
                ),
              ))]),
              Text(
                " % ",
                style: state.textTheme.headline4,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
    SizedBox(
    width: _width * 0.7, // <-- Your width
    height: _height * 0.06,
    child:ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<
              Color>(
              state.indicatorColor),
        ),
        child: Text(" SALVAR ",
            style:
            state.textTheme.caption),
              onPressed: (){
          if(controller.text != "" && controlleradc.text != ""){
            newIof = num.tryParse(controller.text.replaceAll(r',','.'))!;
            newIofadc = num.tryParse(controlleradc.text.replaceAll(r',','.'))!;
            iof.iofValue = newIof / 100;
            iof.iofAdcValue=newIofadc / 100;
            Navigator.pop(context);
          }
          else{
            Navigator.pop(context);
          }
              },
          )
    ),
        ],
      ),
    ));
  }
}
