import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';


String? convertHtmlToString({htmlValue}){

    final document = parse(htmlValue);
     String? parsedString = parse(document.body?.text).documentElement?.text;

    return parsedString;

}


String getDateInDDMMMYY({date}) {
  var d12 = DateFormat('dd-MMM-yyyy').format(date);
  return d12;
}

void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black,
      textColor: Colors.white,

      fontSize: 16.0);
}