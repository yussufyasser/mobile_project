import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/MyTextfield.dart';
import 'package:mobile_app/TheApp/Guardian.dart';
import 'package:mobile_app/localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'dart:convert';

class SignUp extends StatefulWidget{

  late Function (Locale) _setLocale;
  late Function (Color) changecolor;

  SignUp(Function (Locale) _setLocale,Function (Color) changecolor){
    this._setLocale=_setLocale;
    this.changecolor=changecolor;
  }

  @override
  State<StatefulWidget> createState() {

    return SignUpState(this._setLocale,this.changecolor);

  }


}

class SignUpState extends State<SignUp>{

Future<bool> sendImageToAPI(String base64Image,String email) async {
  try {
    final url = 'http://'+Constants.ip+':9000/send_image';
    final payload = {'email': email,'image':base64Image};
    print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response from API: ${responseData['message']}');
      if(responseData['message']=='1')
      return true;
      else
      return false;
    } else {
      print('Failed to send image. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error sending image to API: $e');
  }

  return false;
}

  File? _image;
  TextEditingController _emailcontroller = TextEditingController(),
  _passwordcontroller=TextEditingController(),_confirmcontroller=TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmcontroller.dispose();
    super.dispose();
  }

  late Function (Locale) _setLocale;
  late Function (Color) changecolor;

  SignUpState (Function (Locale) _setLocale,Function (Color) changecolor){
    this._setLocale=_setLocale;
    this.changecolor=changecolor;
  }



  @override
  Widget build(BuildContext context) {

    MyTextField email= MyTextField(AppLocalizations.of(context)!.translate('email'), 'y.yashoor@gmail.com', Icon(Icons.email),_emailcontroller),
    password=MyTextField(AppLocalizations.of(context)!.translate('password'), '12@##234dde', Icon(Icons.lock),
    _passwordcontroller,dont_show_text: true),
    confirmpassword= MyTextField(AppLocalizations.of(context)!.translate('confirmpass'), '12@##234dde', 
    Icon(Icons.lock),_confirmcontroller,dont_show_text: true,);


    return Scaffold(


      appBar: MyAppbar.myappbar(setLocale:  this._setLocale),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(15),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            SizedBox(height: 20,),

            Mybutton(AppLocalizations.of(context)!.translate('takepic'), Icon(Icons.photo), () {
              
              Constants.TakeImage(context,(XFile? pickedFile){
                setState(() {
                  _image= File(pickedFile!.path);
                });
              });
             }),

             SizedBox(height: 10,),

             _image == null
            ? Text(AppLocalizations.of(context)!.translate('noimg'))
            :Image.file(_image!,width: 250,height: 250,),

            SizedBox(height: 20,),

            email,

            SizedBox(height: 20,),

            password,

            SizedBox(height: 20,),

            confirmpassword,

            SizedBox(height: 20,),

            SizedBox(height: 20,),

            Mybutton(AppLocalizations.of(context)!.translate('createaccount'), Icon(Icons.add), () async {

              if(_image ==null)
             Constants.Alert( AppLocalizations.of(context)!.translate('please') ,
              AppLocalizations.of(context)!.translate('takeimg'), context);


              else{



                final imageBytes = await _image!.readAsBytes();
                String base64Image = base64Encode(imageBytes);
                Future<bool> flag=sendImageToAPI(base64Image,email.getController());

                if(await flag){
                  Main.guardian=Guardian(email.getController().trim(), password.getController().trim());
                  await Main.guardian.signup(context, confirmpassword.getController().trim());
                }
                else{
                  Constants.Alert('please', 'take a prober image\n where your face appear in it', context);
                }


              }

             }
             )
      


          ],
        ),

        
      ),
      

     

    );

  }

  
}