import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/providers/theme_provider.dart';
import '../widgets/dialog_theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

   @override
  HomePageState  createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>{

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final state = ref.watch(themeProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: state.hoverColor,
          title: Center(child: Text("Simulador de Empréstimo", style: state.textTheme.headline5,)),
          actions: [
          PopupMenuButton(
          color: state.primaryColor,
          elevation: 20,
          enabled: true,
          onSelected: (value) {
            setState(() {
              //value == 1
              //   ?
              Navigator.of(context)
                  .push(showThemeChangerDialog(context));

            });
          },
          itemBuilder: (context) => [
          PopupMenuItem(
          child:  Text(
          "Trocar o Tema",
          style: TextStyle(color: state.unselectedWidgetColor),
        ),
      value: 1,
    ),])
    ]
        ),
        body: Container(
          color: state.primaryColor,
          height: _height,
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {

                  },
                  child: SizedBox(
                      height: _height * 0.13,
                      width: _width * 0.8,
                      child: Card(
                        elevation: 20,
                        color: state.indicatorColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            Icon(Icons.account_balance_outlined, color: state.unselectedWidgetColor,),
                            Text("Simular Capital de Giro", style: state.textTheme.subtitle2,),
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }


}
