import 'package:flutter/material.dart';

class ShowDialogs{

  ShowDialogs._();



  static showExclusiveOfferDialog({context}){
    return   showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Demo"),
      ),
    );
  }






}