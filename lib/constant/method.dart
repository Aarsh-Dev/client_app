import 'package:html/parser.dart';
import 'package:intl/intl.dart';


String? convertHtmlToString({htmlValue}){

    final document = parse(htmlValue);
     String? parsedString = parse(document.body?.text).documentElement?.text;

    return parsedString;

}


String getDateInDDMMMYY({date}) {
  var d12 = DateFormat('dd-MMM-yyyy').format(date);
  return d12;
}