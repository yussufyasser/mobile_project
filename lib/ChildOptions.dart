import 'package:flutter/material.dart';
import 'package:mobile_app/LanguageCourse.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/Updateimage.dart';
import 'package:mobile_app/localization.dart';



class ChildOptions extends StatelessWidget{

  late Function(Locale) _setLocale;
  late Function (Color) changecolor;
  late child Child;

  ChildOptions(Function(Locale) _setLocale,child Child,Function (Color) changecolor){
    this._setLocale=_setLocale;
    this.Child=Child;
    this.changecolor=changecolor;
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: MyAppbar.myappbar(setLocale:  this._setLocale,flag: true,changecolor:  this.changecolor),

      body:SingleChildScrollView(

         padding: EdgeInsets.all(15),

         child:  Column(

          children: <SizedBox>[

          SizedBox(height: 20,),

          SizedBox( child:  Mybutton(AppLocalizations.of(context)!.translate('updateimg'), 
          Icon(Icons.photo), () { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => Updateimage(_setLocale,this.Child,this.changecolor,false)));
           }) ,width: MediaQuery.sizeOf(context).width),

           SizedBox(height: 20,),

          SizedBox( 
            child:  
            ElevatedButton(onPressed: () {
             this. _setLocale(Locale('ar', ''));
             Navigator.push(context, MaterialPageRoute(builder: (context) =>LanguageCourse(this.Child,true,this.changecolor) ));
            },
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/finalseniorproject-83a2c.appspot.com/o/arabic.jpg?alt=media&token=ba4f0e16-8c48-460e-9486-f6bf7336a19f',
            height: double.infinity,width: double.infinity,
           ),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),), backgroundColor: Colors.blue,),
            ),width: 250,height: 250,),
          
          SizedBox(height: 20,),

          SizedBox( 
            child:  
            ElevatedButton(onPressed: () {
             this. _setLocale(Locale('en', ''));
             Navigator.push(context, MaterialPageRoute(builder: (context) =>LanguageCourse(this.Child,false,this.changecolor) ));
            },
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/finalseniorproject-83a2c.appspot.com/o/english.jpg?alt=media&token=bc95c223-8091-47e3-a656-3ba06f1581aa',
            ),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),), backgroundColor: Colors.blue,),
            ),width: 250,height: 250,),


            
          ],

        ),

      ),
    );

  }
  
}


