import 'package:calculadora_capital/src/controller/state_view.dart';
import 'package:calculadora_capital/views/config_screen.dart';
import 'package:calculadora_capital/views/desc_screen.dart';
import 'package:calculadora_capital/views/home_emp.dart';
import 'package:calculadora_capital/views/simulator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/providers/api_provider.dart';
import '../src/providers/stateview_provider.dart';
import '../src/providers/theme_provider.dart';
import '../consts/dialog_theme.dart';
import 'home_aplic.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
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
                child:
                    Text("Simular Operações Bancárias", style: state.textTheme.caption)),
            actions: [
              PopupMenuButton(
                  color: state.primaryColor,
                  elevation: 20,
                  enabled: true,
                  onSelected: (value) {
                    setState(() {
                      value == 1
                          ? Navigator.of(context)
                              .push(showThemeChangerDialog(context))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfigScreen()));
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
                    final apiController = ref.watch(apiProvider.notifier);
                    apiController.BankList();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageEmp()));
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
                              "Emprestimo",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DescScreen()));
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
                              Icons.money_off,
                              color: state.primaryColor,
                            ),
                            Text(
                              "Desc. Titulos",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageAplic()));
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
                              Icons.account_balance_wallet_outlined,
                              color: state.primaryColor,
                            ),
                            Text(
                              "Aplicação",
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
