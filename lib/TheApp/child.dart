import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/TheApp/person.dart';
import 'package:mobile_app/localization.dart';
import 'package:mobile_app/main.dart';
import '../Constants.dart';

class child extends person{
  
  late String name_in_arabic,name_in_english;
  

  child(String name_in_arabic, String name_in_english,File _image):super(_image){
    this.name_in_arabic=name_in_arabic;
    this.name_in_english=name_in_english;
  
  }

  child.learing(String name_in_arabic, String name_in_english,Image img,String id):super.img(img,id){
    this.name_in_arabic=name_in_arabic;
    this.name_in_english=name_in_english;

  }


  Future<void> addchild(BuildContext context) async {

    if(this.name_in_arabic.isEmpty || this.name_in_english.isEmpty)
    Constants.Alert(AppLocalizations.of(context)!.translate('please'),
    AppLocalizations.of(context)!.translate('fillall'), context);

    else{

      try{


        String id= Main.guardian.id+this.name_in_arabic+name_in_english;

        await super.upload_image(id,'children/');
      
        await FirebaseFirestore.instance.collection('children').doc(id)
        .set(
          {
            'guardian':Main.guardian.id,
            'name_arabic':this.name_in_arabic,
            'name_en':this.name_in_english,
          }

        
          );
        Constants.Alert(AppLocalizations.of(context)!.translate('confirm'),
        AppLocalizations.of(context)!.translate('addsucces'), context);


      }catch(e){
        print('failed to add the child');
      }


}}




}