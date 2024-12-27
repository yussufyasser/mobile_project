import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  late Icon icon;
  TextEditingController _controller=TextEditingController();
  late String tittle,example;
  late TextInputType InputType;
  late bool dont_show_text;
  double size_between_text=0;



  String getController(){ return this._controller.text.toString();}

  MyTextField(String title,String example,Icon icon,TextEditingController _controller,
  {bool dont_show_text=false,TextInputType InputType =TextInputType.text,double size_between_text=3, } ){

    this.tittle=title;
    this.example=example;
    this.icon=icon;
    this.dont_show_text=dont_show_text;
    this.InputType=InputType;
    this.size_between_text;
    this._controller=_controller;}



  @override
  Widget build(BuildContext context) {

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[

       Text(this.tittle,style: 
        TextStyle(fontWeight: FontWeight.w400,fontSize: 20,)),
        
        SizedBox(height: this.size_between_text,),

        TextField(
          obscureText: this.dont_show_text,
          inputFormatters: [],
          keyboardType: this.InputType,
          controller: this._controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon:  this.icon,
            hintText: this.example,

          ),

        )
      ],
    );

  }

  
}