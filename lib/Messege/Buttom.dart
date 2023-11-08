import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Boouttom {
  static buttom(String text, void Function()? tap) {
    Widget cont = InkWell(
      onTap: tap,
      child: Container(
        height: Get.height * .06,
        width: Get.width * .8,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(Get.width * .04)),
        child: Center(
          child: Text(text),
        ),
      ),
    );

    return cont;
  }
}
