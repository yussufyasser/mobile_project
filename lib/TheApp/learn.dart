import 'package:flutter/material.dart';
import 'package:mobile_app/TheApp/child.dart';

abstract class learn{

  late bool language;
  late child c;

  Widget  get_progress();

  learn(bool language,child c){
    this.language=language;
    this.c=c;
  }

  learn.init(){}
}