import 'package:less_1/main.dart';
import 'package:test/test.dart';

Map<String, double> vars = {
  'x': 10,
};

Map<String, double> testTable = {
  '10*5+4/2-1': 51,
  '(x*3-5)/5': 5,
  '3*x+15/(3+2)': 33,
  '3*-x+15/(-3+-2)': -33,
  '-3*-x+1.5/(-3+-2)': 29.7,
  '-3*-x+1,5/(-3+-2)': 29.7,
  ' -3  * - x    + 15 /   ( -3 + - 2) ': 27
};

void main() {
    for (String expression in testTable.keys) {
      test(expression, () {
        Calculator calc = Calculator(vars, expression);
        expect(calc.calculate(), testTable[expression]);
      });
    }
}