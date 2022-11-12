class Calculator {
  final Map<String, double> vars;
  final String str;
  final RegExp re = RegExp(r'[*|/|+|-]');

  Calculator(this.vars, this.str);

  double calculate() {
    String str = this.str
        .replaceAll(' ', '')
        .replaceAll(',', '.');

    for (String key in vars.keys) {
      str = str.replaceAll(key, vars[key].toString());
    }

    String inBrackets = '';

    while (true) {
      inBrackets = _inBrackets(str);
      if (inBrackets.isEmpty) {
        break;
      }

      List<String> parts = _split(inBrackets);
      for(String op in <String>['*', '/', '+', '-']) {
        parts = _operations(parts, op);
      }

      str = str.replaceAll('($inBrackets)', parts[0]);
    }

    List<String> parts = _split(str);
    for(String op in <String>['*', '/', '+', '-']) {
      parts = _operations(parts, op);
    }

    return double.parse(parts[0]);
  }

  String _inBrackets(String str) {
    int openBracket = str.lastIndexOf('(');
    int closeBracket = 0;

    if (openBracket == -1) {
      return '';
    }

    openBracket++;
    closeBracket = str.indexOf(')', openBracket);

    if (closeBracket <= openBracket) {
      return '';
    }

    return str.substring(openBracket, closeBracket);
  }

  List<String> _split(String str) {
    List<String> list = [];
    int lastPos = 0;
    int pos = 0;
    String buff = '';

    while (pos > -1) {
      pos = str.indexOf(re, pos);
      if (pos > -1) {
        String a = str.substring(lastPos, pos);
        String b = str.substring(pos, pos+1);
        if (a.isNotEmpty) {
          list.add(buff+a);
          list.add(b);
          buff = '';
        } else {
          buff = b;
        }
        lastPos = ++pos;
      }
    }

    if (lastPos < str.length) {
      list.add(buff+str.substring(lastPos));
    }

    return list;
  }

  List<String> _operations(List<String> parts, String op) {
    if (parts.length <= 1) {
      return parts;
    }

    List<String> result = [];
    result.add(parts[0]);

    for (int i = 1; i < parts.length; i++) {
      if (parts[i] == op) {
          double a = double.parse(result.last);
          double b = double.parse(parts[i+1]);
          switch (op) {
            case '*':
              result.last = (a * b).toString();
              break;
            case '/':
              result.last = (a / b).toString();
              break;
            case '+':
              result.last = (a + b).toString();
              break;
            case '-':
              result.last = (a - b).toString();
              break;
          }
          i++;
      } else {
          result.add(parts[i]);
      }
    }

    return result;
  }
}