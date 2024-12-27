import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/AddChild.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/localization.dart';
import 'package:mobile_app/main.dart';


class Home extends StatelessWidget{

  late Function(Locale) _setlocale;
  late Function(Color) changecolor;

  Home(Function(Locale)_setLocale,Function(Color) changecolor){
    this._setlocale=_setLocale;
    this.changecolor=changecolor;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:MyAppbar.myappbar(setLocale:  this._setlocale,flag: true,changecolor:  this.changecolor),
      body: SingleChildScrollView(

        child: Column(

          children: <Widget>[

            Mybutton(AppLocalizations.of(context)!.translate('addchild'), Icon(Icons.add), () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddChild(this._setlocale,this.changecolor)));
            }),

            Main.guardian.Display_children(context,this._setlocale,this.changecolor)
          ],
        ),
      )
    );

  }

  
}