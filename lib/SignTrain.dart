import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/TheApp/course.dart';
import 'localization.dart';

class SignTrain extends StatefulWidget{

  late course Course;
  late int index;

  SignTrain(course Course,int index){
    this.Course=Course;
    this.index=index;
  }

  @override
  State<StatefulWidget> createState() {

    return SignTrainState(this.Course, this.index);
  }
  
}

class SignTrainState extends State<SignTrain>{

  late course Course;
  late int index;
  File? _image;
  String display='';



   Future<void> pickImage() async {
    
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null){

      setState(() {
        _image= File(pickedFile.path);
      });

    List<int> imageBytes = await pickedFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

   
    this.Course.send_sign(base64Image, (s){

      String r= jsonDecode(s)['message'];

      if(r==this.Course.lessons[index]){

        this.Course.addprogress(index*this.Course.lessons_num+2);


        setState(() {
          display=AppLocalizations.of(context)!.translate('correct');
        });
      }

      else if(r=='EMPTY'){
        setState(() {
          display=AppLocalizations.of(context)!.translate('notcorrect');
        });


      }

      else{
        setState(() {
          display=r;
        });

      }
    });

    }
    
  }

  SignTrainState(course Course,int index){
    this.Course=Course;
    this.index=index;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: MyAppbar.myappbar(coursevideo: true,onPressed:(){Navigator.pop(context, this.Course);} ),

      body: Center(

        child: Column(

          children: <Widget>[

            SizedBox(height: 20,),

            Mybutton(AppLocalizations.of(context)!.translate('trysign'), Icon(Icons.photo), () {

              this.pickImage();
            }),

            SizedBox(height: 20,),

            if (_image != null) Image.file(_image!,height: 250,width: 250, ),

            SizedBox(height: 20,),

            Text(display,style: TextStyle(fontSize: 20),)


          ],
        ),
      ),
    );
  }
  
}