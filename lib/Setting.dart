import 'package:flutter/material.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/Updateimage.dart';
import 'package:mobile_app/localization.dart';
import 'package:mobile_app/main.dart';

class Settings extends StatefulWidget{


  late Function (Locale) setLocale;
  late Function (Color) changecolor;
  late bool learn;

  Settings(Function (Color) changecolor,Function (Locale) setLocale,{bool learn =false}){
    this.setLocale=setLocale;
    this.changecolor=changecolor;
    this.learn=learn;
  }

  @override
  State<StatefulWidget> createState() {

    return SettingsState(this.setLocale,this.changecolor,this.learn);
  }

  
}

class SettingsState extends State<Settings> {

  late Function (Locale) setLocale;
  late Function (Color) changecolor;
  late bool learn;

  SettingsState(Function (Locale) setLocale,Function (Color) changecolor,bool learn){
    this.setLocale=setLocale;
    this.changecolor=changecolor;
    this.learn=learn;
  }
  
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.brown,
    Colors.indigo,
    Colors.amber,
    Colors.grey,
    Colors.black,
  ];
  late Color selectedColor;

  @override
  void initState() {
    this.selectedColor=Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
   return Scaffold(

    backgroundColor: Colors.white,

    appBar:learn? MyAppbar.myappbar(setLocale:this.setLocale,learning_setting: true) : MyAppbar.myappbar(setLocale:this.setLocale,settings: true),

    body: SingleChildScrollView(

      padding: EdgeInsets.all(15),

      child: Column(

        children: <Widget>[

          SizedBox(height: 20,),
          TextButton(onPressed: (){
            this.changecolor(Colors.white);
            setState(() {
              selectedColor = Colors.white;
            });
          }, child: Text(AppLocalizations.of(context)!.translate('setbackgroundcolor'),style: TextStyle(fontSize: 20),)),
          SizedBox(height: 20,),
          Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      this.changecolor(colors[index]);
                      setState(() {
                        selectedColor = colors[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index],
                        border: selectedColor == colors[index]
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                      ),
                    ),
                  );
                },
              ),    
            ),
            SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.translate('selectedcolor'),style: TextStyle(fontSize: 20),),
            selectedColor==Colors.white ? SizedBox(height: 10,):Container(width: 100,height: 100,color: selectedColor,),
            selectedColor==Colors.white ? SizedBox(height: 2) :SizedBox(height: 20,),



          ],
        ),
      ),
    );
  }
}


