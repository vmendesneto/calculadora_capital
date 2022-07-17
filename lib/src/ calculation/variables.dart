

class Variables {
  List<num> dataList = [];
  List<num> jurosList = [];
  List<String> dateList = [];
  List<DateTime> dateVencList = [];
  List<num> parcList = [];
  List<num> amorList = [];
  List<num> tirList = [];
  List<num> daysList = [];
  List? dataMap = [];

  DateTime hoje = DateTime.now();
  DateTime? dateVenc = DateTime.now();

  double result = 0.00;
  num dado = 0.00;
  num? origin;
  num saldodevedor = 0;
  num? juros;
  num vtir = 0.00;
  num amortiza = 0;
  num periodo = 0;
  num taxa = 0;
  int total = 0;
  int nparc = 0;
  int valor = 0;
  DateTime? newDate;
  num parcela = 0;
  num carencia = 0;
  num iof = 0.00;
  num iofa = 0.00;
  num totalP = 0.00;
  num totalJ = 0.00;
  num emp = 0.00;
  double tx = 0.00;
  DateTime date = DateTime.now();
  num tir = 0;
  num tarifa = 0;
  num liquido = 0;
  String itemSelecionado = 'Select Bank';
  double? width;
  bool check = false;
  bool checkVenc = false;
  bool validate = false;


}