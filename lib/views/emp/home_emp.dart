import 'package:calculadora_capital/views/emp/simulator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../src/providers/stateview_provider.dart';
import '../../src/providers/theme_provider.dart';
import '../../consts/dialog_theme.dart';

class HomePageEmp extends ConsumerStatefulWidget {
  const HomePageEmp({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePageEmp> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);
    final viewState = ref.watch(stateViewProvider.notifier);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: state.hoverColor,
            iconTheme: IconThemeData(color: state.primaryColor),
            title: Center(
                child: Text("Simulador de Empréstimo",
                    style: state.textTheme.caption)),
            actions: [
              PopupMenuButton(
                  color: state.primaryColor,
                  elevation: 20,
                  enabled: true,
                  onSelected: (value) {
                    setState(() {
                      Navigator.of(context)
                          .push(showThemeChangerDialog(context));
                    });
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "Trocar o Tema",
                            style: TextStyle(
                                color: state.unselectedWidgetColor,
                                fontSize: 10),
                          ),
                          value: 1,
                        ),
                        // PopupMenuItem(
                        //   child:  Text(
                        //     "Configurações",
                        //     style: TextStyle(color: state.unselectedWidgetColor, fontSize: 10),
                        //   ),
                        //   value: 2,
                        // ),
                      ])
            ]),
        body: Container(
          color: state.primaryColor,
          height: _height,
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    viewState.resetButton();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SimulatorScreen()));
                  },
                  child: SizedBox(
                      height: _height * 0.13,
                      width: _width * 0.8,
                      child: Card(
                        elevation: 20,
                        color: state.indicatorColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              color: state.primaryColor,
                            ),
                            Text(
                              "Modalidade Sac",
                              style: state.textTheme.caption,
                            ),
                          ],
                        ),
                      ))),
              SizedBox(
                height: _height * 0.02,
              ),
              GestureDetector(
                  onTap: () {
                    viewState.resetButton();
                    viewState.setTable();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SimulatorScreen()));
                  },
                  child: SizedBox(
                      height: _height * 0.13,
                      width: _width * 0.8,
                      child: Card(
                        elevation: 20,
                        color: state.indicatorColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              color: state.primaryColor,
                            ),
                            Text(
                              "Modalidade Price",
                              style: state.textTheme.caption,
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ));
  }
}
