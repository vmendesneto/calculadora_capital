import '../../controller/state_view.dart';

class Iof {
   num iofValue = 0.000041;
  num iofAdcValue = 0.0038;

  num periodoIof = variables.periodo >= 12 ? 365 : variables.periodo * 30;

}