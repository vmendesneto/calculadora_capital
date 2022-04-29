import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/providers/theme_provider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhamento da Simulação", style: state.textTheme.caption,),
        backgroundColor: state.indicatorColor,
      ),
        body: Container(
      padding: EdgeInsets.only(top: _height * 0.01,left: _width * 0.03, right: _width * 0.03),
      width: _width,
      height: _height,
      decoration: BoxDecoration(color: state.primaryColor),
      child: SizedBox(
        width: _width,
        child: Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: variables.jurosList.length,
                itemBuilder: (context, int index) {
                  variables.nparc = index + 1;
                  return Row(children: [
                    Text(index.toString()),
                    const Spacer(),
                    Text(variables.dateList[index], style: state.textTheme.bodyText1),
                    const Spacer(),
                    Text(variables.jurosList[index].toStringAsFixed(2), style: state.textTheme.bodyText1),
                    const Spacer(),
                    Text(variables.amorList[index].toStringAsFixed(2), style: state.textTheme.bodyText1),
                    const Spacer(),
                    Text(variables.parcList[index].toStringAsFixed(2), style: state.textTheme.bodyText1),
                    const Spacer(),
                    Text(
                      variables.dataList[index].toStringAsFixed(2), style: state.textTheme.bodyText1
                    ),
                  ]);
                })),
      ),
    ));

    // const SizedBox(
    //   height: 15,
    // )
    // ,
    // controller.text != ""
    // ? Container(
    // height: 30,
    // width: double.infinity,
    // decoration: const BoxDecoration(color: Colors.red),
    // child: Text(result.toStringAsFixed(2)))
    //     : Container()
    // ]),
    // )
    // ,
    // )
    // );;
  }
}
