import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/TheApp/person.dart';
import 'package:mobile_app/localization.dart';

class Updateimage extends StatefulWidget{

  late Function (Locale) _setLocale;
  late Function(Color) changecolor;
  late person p;
  bool from=true;

  Updateimage(Function (Locale) _setLocale,person p,Function(Color) changecolor ,bool from){
    this._setLocale=_setLocale;
    this.p=p;
    this.changecolor=changecolor;
    this.from=from;
  }
  @override
  State<StatefulWidget> createState() {
    return UpdateimageState(this._setLocale,this.p,this.changecolor,this.from);
  }

  
}

class UpdateimageState extends State<Updateimage>{

  late Function (Locale) _setLocale;
  late Function (Color) changecolor;
  late person p;
  File? _image;
  late Image displayed;
  late bool from;

  @override
  void initState() {
    this.displayed=this.p.displayed_img;
    super.initState();
  }

  void update(){
    setState(() {
      this.displayed=Image.file(this._image!);
      this._image=null;

    });
  }

  UpdateimageState(Function (Locale) _setLocale,person p,Function(Color) changecolor,bool from){
    this._setLocale=_setLocale;
    this.p=p;
    this.changecolor=changecolor;
    this.from=from;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:from ? MyAppbar.myappbar(setLocale:  this._setLocale,settings: true,changecolor: this.changecolor):
      MyAppbar.myappbar(setLocale:  this._setLocale,flag: true,changecolor: this.changecolor),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(15),

        child:Center( child:  Column(

          children: <Widget>[

            SizedBox(height: 20,),
            SizedBox(child:  this.displayed ,width: 250,height: 250,),
            SizedBox(height:20,),

            Mybutton( AppLocalizations.of(context)!.translate('replaceimg'), Icon(Icons.photo), () { 

              Constants.TakeImage(context,(XFile? pickedFile){

                setState(() {
                  _image= File(pickedFile!.path);
                });
              });
            }),

            SizedBox(height:20,),
            if (_image != null) Image.file(_image!,height: 250,width: 250, ),
            SizedBox(height:20,),
            Mybutton( AppLocalizations.of(context)!.translate('changeimage'), Icon(Icons.photo), () async {

             if(this._image ==null)
             Constants.Alert(AppLocalizations.of(context)!.translate('sorry'), 
             AppLocalizations.of(context)!.translate('chooseimgtoupdate'), context);

             else
             Constants.verify( AppLocalizations.of(context)!.translate('verifyupdate') , context,(){
              person.update_image(p, _image);
              this.update();
             });
             
            }),
          ],
        ),)
      )
    );
  }
  
}