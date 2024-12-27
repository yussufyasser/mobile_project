import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/MyTextfield.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/localization.dart';

class AddChild extends StatefulWidget{

  late Function(Locale) _setLocale;
  late Function(Color) changecolor;

  AddChild(Function(Locale) _setLocale,Function(Color) changecolor){
    this._setLocale=_setLocale;
    this.changecolor=changecolor;
  }

  @override
  State<StatefulWidget> createState() {
    return AddChildState(this._setLocale,this.changecolor);

  }
  
}

class AddChildState extends State<AddChild>{

  TextEditingController _arabicnamecontroller = TextEditingController(),
  _englishnamecontroller=TextEditingController();

  @override
  void dispose() {
    _arabicnamecontroller.dispose();
    _englishnamecontroller.dispose();
    super.dispose();
  }


  late Function(Locale) _setLocale;
  File? _image;
  late Function(Color) changecolor;

  AddChildState(Function(Locale) _setLocale,Function(Color) changecolor){
    this._setLocale=_setLocale;
    this.changecolor=changecolor;
  }


  @override
  Widget build(BuildContext context) {

    MyTextField name_arabic=MyTextField(AppLocalizations.of(context)!.translate('namear'), 'يوسف', 
    Icon(Icons.person),_arabicnamecontroller),
    name_in_english=MyTextField(AppLocalizations.of(context)!.translate('nameen'), 'yussuf', 
    Icon(Icons.person),_englishnamecontroller);


    return Scaffold(

      appBar: MyAppbar.myappbar(flag: true,setLocale:this._setLocale,changecolor:  this.changecolor),
      body: SingleChildScrollView(

        padding: EdgeInsets.all(15),
        child: Column(

          children: <Widget>[
            SizedBox(height: 20,),
            Mybutton(AppLocalizations.of(context)!.translate('chooseimg'),  Icon(Icons.photo), () {
              Constants.TakeImage(context,(XFile? pickedFile){
                setState(() {
                  _image= File(pickedFile!.path);
                });
              });
            }),
            SizedBox(height: 20,),
            if (_image != null) Image.file(_image!,height: 250,width: 250, ),
            SizedBox(height: 20,),
            name_arabic,
            SizedBox(height: 20,),
            name_in_english,
            SizedBox(height: 20,),
            Mybutton(AppLocalizations.of(context)!.translate('add'), Icon(Icons.add), () {

              if(_image==null)
              Constants.Alert( AppLocalizations.of(context)!.translate('please') ,
               AppLocalizations.of(context)!.translate('chooseimgforyourchild') ,context);

              else
              child(name_arabic.getController().trim(),name_in_english.getController().trim(), _image!).addchild(context);

             })
          ],
        ),
      )
    );
  }

}