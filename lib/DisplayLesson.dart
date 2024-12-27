import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/DisplayVideo.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/SignTrain.dart';
import 'package:mobile_app/TheApp/course.dart';
import 'package:mobile_app/localization.dart';

class DisplayLesson extends StatefulWidget{

  late course Course;
  late Function(Color) changecolor;


  DisplayLesson(course Course,Function(Color) changecolor ){
    this.Course=Course;
    this.changecolor=changecolor;
  }
  
  @override
  State<StatefulWidget> createState() {
    return DisplayLessonState(this.Course,this.changecolor);
  }



}


class DisplayLessonState  extends State<DisplayLesson>{

  late course Course;

  Alignment alligment=Alignment.centerLeft;

  late Function(Color) changecolor;

  DisplayLessonState(course Course,Function(Color) changecolor ){

    this.Course=Course;
    this.changecolor=changecolor;

    if(this.Course.language)
    this.alligment=Alignment.centerRight;
    

  }

  List<bool> check(int index){

    List<bool> flags=List.generate(this.Course.lessons_num, (index) =>false);
    
    for(int i=0;i<this.Course.progress.length;i++){
         
      if( (  (this.Course.progress[i]/this.Course.lessons_num).ceil() -1)==index )
        flags[ this.Course.progress[i]- index*this.Course.lessons_num -1]=true;
      
    }

    return flags;

  }

  void move_to_lesson(int progress,String video){

    Navigator.push(context, MaterialPageRoute(builder: (context) => 
    DisplayVideo(video,Course: this.Course,progress: progress,learning: true, ) )).then((updatedCourse) {
      if (updatedCourse != null) {
        setState(() {
          this.Course = updatedCourse;
          });
      }});


  }

  void move_to_sign_train(int index){

    Navigator.push(context, MaterialPageRoute(builder: (context) => 
    SignTrain(this.Course,index) )).then((updatedCourse) {
      if (updatedCourse != null) {
        setState(() {
          this.Course = updatedCourse;
          });
      }});

  }


  Column the_lesson(){

    return Column(
          children:List.generate(this.Course.lessons.length, (index){

            List<bool> flags=check(index);  

            return ExpansionTile(

              title: flags[0]&flags[1] ? Align( alignment: alligment, 
              child: Row( children: [Text( this.Course.lessons[index]),Spacer(),Icon(Icons.check,color: Colors.blue,)],), ) 
              :Align( alignment: alligment, child: Row( children: [Text( this.Course.lessons[index]),Spacer(),
              Icon(Icons.clear, color: Colors.red)],), ) ,

              children: <Align>[

                Align( child: Row( children: [
                  TextButton(onPressed: () async {

                    DocumentSnapshot<Map<String, dynamic>> document =
                   await FirebaseFirestore.instance.collection('course').doc(this.Course.lessons[index]).get();
                    if (document.exists)
                    move_to_lesson( index*this.Course.lessons_num+1, document.data()?['video'] ); 

                }, child:Text(AppLocalizations.of(context)!.translate('lesson'))),
                  Spacer(),
                  flags[0] ?Icon(Icons.check,color: Colors.blue,) :Icon(Icons.clear, color: Colors.red)
                ], ) ,alignment: alligment,),

                Align( child: Row( children: [
                  TextButton(onPressed: (){
                   move_to_sign_train(index);
                  }, child:Text(AppLocalizations.of(context)!.translate('signtrain'))),
                  Spacer(),
                  flags[1] ?Icon(Icons.check,color: Colors.blue,) :Icon(Icons.clear, color: Colors.red)
                ], ) ,alignment: alligment,),




                ],

              );

          })
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: MyAppbar.myappbar(learing: true,changecolor:  changecolor,setLocale: (p0) {},),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(15),

        child: this.the_lesson()
      ),
    );
  }
  
}