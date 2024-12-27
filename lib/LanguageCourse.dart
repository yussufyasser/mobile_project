import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/DisplayLesson.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/TheApp/course.dart';
import 'package:mobile_app/localization.dart';


class LanguageCourse extends StatelessWidget{

  late child c;
  late bool language;
  late Function(Color) changecolor;

  LanguageCourse(child c,bool language,Function(Color) changecolor){
    this.c=c;
    this.language=language;
    this.changecolor=changecolor;
  }


  @override
  Widget build(BuildContext context) {

    late course characters;

    if(this.language){

      characters=course(AppLocalizations.of(context)!.translate('characters'),
      true, 'characters', ['ع', 'ال', 'أ', 'ب', 'ض', 'د', 'ف', 'غ', 'ه', 'ح', 'ك', 'خ', 'لا', 'م', 'ن', 'ر', 'ص', 'ش', 'ت', 'ذ', 'ئ', 'ز'] 
       ,this.c ,2);

    }

    else{

      characters=course(AppLocalizations.of(context)!.translate('characters'),
      false, 'characters', ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'] ,
      this.c,2);
    }

    return Scaffold(

      appBar:MyAppbar.myappbar(learing: true,changecolor:  this.changecolor,setLocale: (p0) {},),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[

            ElevatedButton(
              onPressed:(){

                Navigator.push(context, MaterialPageRoute(builder: (context) =>DisplayLesson(characters,this.changecolor) ));
                },
              child: characters.get_progress(),
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),))
            ),



          ],
        ),
      )

    );
  }
  
}

