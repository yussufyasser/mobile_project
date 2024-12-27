import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/TheApp/Guardian.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/main.dart';
import 'package:http/http.dart' as http;

abstract class person{

  late File image;

  late Image displayed_img;
  late String id;

  
  person(File image){
    this.image=image;
  }

  person.file_and_id(File image,String id){
    this.image=image;
    this.id=id;
  }

  person.id(String id){
    this.id=id;
  }

  person.empty(){}

  person.img(Image displayed_img,String id){
    this.displayed_img=displayed_img;
    this.id=id;
  }

  Future<String> getImageURL(String img_path) async {
    String url = await FirebaseStorage.instance.ref().child(img_path+".jpg").getDownloadURL();
    return url;
  }



  Future<void> upload_image(String id,String where) async {

    String ext='jpg',dot='.';  
    final imageBytes = await this.image.readAsBytes();
    await FirebaseStorage.instance.ref('$where$id$dot$ext').
    putData(imageBytes, SettableMetadata(contentType: 'image/${ext}'));   
      
  }

  static Future<void> update_image(person p,File? _image) async {

    if(p is child){

      child c=p as child;
      c.image=_image!;
      await c.upload_image(c.id, 'children/');
      c.displayed_img=Image.file(_image);

    }

    else{

      Main.guardian.image=_image!;
      await Main.guardian.upload_image(Main.guardian.id, 'guardian/');
      Main.guardian.displayed_img=Image.file(_image);

    }


  }

  Future<void> get_id_by_image(Function what) async {

    ImageSource source=ImageSource.camera;
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    if(pickedFile !=null){

      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      String url;
      if(this is Guardian)
      url='http://'+Constants.ip+':5053/get_guardian_id';
      else
        url='http://'+Constants.ip+':5053/get_children_id';

      print(url);

      final response = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},body: jsonEncode({'image': base64Image}),);

      if (response.statusCode == 200){

        String res=jsonDecode(response.body)['message'];
        what(res);

      }

    } 
  }

}