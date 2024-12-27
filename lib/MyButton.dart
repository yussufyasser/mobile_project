import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget{

  late Icon icon;
  late String tittle;
  late void Function()? onPressed;
  Color? backgroundColor;

  Mybutton(String tittle,Icon icon,void Function()? onPressed,{Color? backgroundColor=Colors.white54}){
    this.tittle=tittle;
    this.icon=icon;
    this.onPressed=onPressed;
    this.backgroundColor=backgroundColor;
  }

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(onPressed: this.onPressed, child: Row(

      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        this.icon,
        SizedBox(width: 5), 
        Text(this.tittle),
      ],
    ),

    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0),),
    backgroundColor: this.backgroundColor,)
    );

  }

  
}