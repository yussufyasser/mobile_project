import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/DisplayVideo.dart';
import 'package:mobile_app/localization.dart';


class Constants{

  static void verify(String message,BuildContext context,Function what){

    showDialog(
      context: context, 
      builder:(BuildContext builder){

        return SingleChildScrollView( child:  AlertDialog(

          title: Text(AppLocalizations.of(context)!.translate('confirm'),),
          content: Text(message),
          actions:<Row> [

            Row(
              children:<TextButton> [

              TextButton(onPressed: (){
                what();
                Navigator.of(context).pop();
                
              }, child: 
                Text( AppLocalizations.of(context)!.translate('yes'),)) ,

                TextButton(onPressed: (){Navigator.of(context).pop();}, child: 
                Text( AppLocalizations.of(context)!.translate('no'),)),

              ],
            )
                  
          ],

        ));
      }

      );
  }


  static void Alert(String tittle, String message,BuildContext context){

    showDialog(
      context: context, 
      builder:(BuildContext builder){

        return SingleChildScrollView( child:  AlertDialog(

          title: Text(tittle),
          content: Text(message),
          actions: <Center>[

            Center( child:  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text(
              AppLocalizations.of(context)!.translate('ok'),
            )),)
          ],

        ));
      }

      );
  }


  static void TakeImage(context,Function what) {

    ImageSource source=ImageSource.camera;

    Future<void> pickImage() async {

      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null)
      what(pickedFile );
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(AppLocalizations.of(context)!.translate('gallery')),
                onTap: () {
                  source=ImageSource.gallery;
                  pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(AppLocalizations.of(context)!.translate('Camera')),
                onTap: () {
                  pickImage();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static String help='';

  static Future<void> gethelp(BuildContext context ) async {

    if(help !=''){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayVideo( help ) ));
      return;
    }

    DocumentSnapshot<Map<String, dynamic>> document =
    await FirebaseFirestore.instance.collection('help').doc('Uro0FwC78lHHg5dRStDT').get();

    if (document.exists){
      help= document.data()?['video'];
      Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayVideo( help ) ));
   
    }
  }

  static String ip='';

  static Future<void> setip() async {

    DocumentSnapshot<Map<String, dynamic>> document =
    await FirebaseFirestore.instance.collection('backend').doc('79GfDOCMpGDTbzxvLA3M').get();

    if (document.exists)
    ip= document.data()?['ip'];


  }



  
}

