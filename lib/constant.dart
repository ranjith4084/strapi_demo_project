import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Api
class ConstantApi{
  var base_url = Uri.parse('http://192.168.50.123:1337/api/apis');
}

///Toast
void showToast(String? msg, {Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: msg!, toastLength: toastLength, backgroundColor: AppColor.orange);
}

///Color

class AppColor {
  static const orange = Color(0xffffba61c);


}