import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/TheApp/learn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class course extends learn{

  late String name,category,video;
  late List<String> lessons;
  late int total,lessons_num;


  List<int> progress=[];

  course(String name,bool language,String category,List<String> lessons,child c,int lessons_num):super(language,c){
    this.name=name;
    this.lessons=lessons;
    this.category=category;
    this.total=lessons.length*lessons_num;
    this.lessons_num=lessons_num;
  }
  course.init():super.init(){}



Future<void> addprogress(int progress) async {

  await FirebaseFirestore.instance.collection('children_course').doc(c.id+progress.toString()).set({

    'child': c.id,
    'course':this.category,
    'language':this.language,
    'progress':progress
    
  });

  this.progress.add(progress);
}


Future<void> send_sign(String base64Image,void what(String s) ) async {


  String url='';

  if(this.category=='characters'){
    if(this.language)
    url='http://'+Constants.ip+':5051/arabic_sign';
    else
    url='http://'+Constants.ip+':5051/english_sign';
  }


  print(url);

  final response = await http.post(Uri.parse(url),
  headers: {'Content-Type': 'application/json'},body: jsonEncode({'image': base64Image}),);

    if (response.statusCode == 200){
      print(response.body);
      what(response.body);
    }
    

    else
    print('Failed to send image: ${response.statusCode}');
    


  }
  
  @override
  StreamBuilder get_progress() {

    return StreamBuilder(

      stream: FirebaseFirestore.instance.collection('children_course').where('child' ,isEqualTo: c.id).
      where('language',isEqualTo: this.language).where('course',isEqualTo: this.category).snapshots(), 

      builder: (BuildContext, AsyncSnapshot snapshot){
        
        if(snapshot.hasError){
          print(snapshot.error);
          return Text('error');
        }
        

        else if(snapshot.connectionState==ConnectionState.waiting)
        return Center( child:  CircularProgressIndicator() );

        List<QueryDocumentSnapshot<Map<String, dynamic>>> data=snapshot.data!.docs;
        double progressValue =data.length/this.total;

        for(int i=0; i<data.length;i++)
          this.progress.add(data[i]['progress']);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: progressValue,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              SizedBox(height: 10),
              Text(
                (progressValue*100).toStringAsPrecision(3),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }

      );
  }
  



}