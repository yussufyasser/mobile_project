import 'package:flutter/material.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/MyButton.dart';
import 'package:mobile_app/MyTextfield.dart';
import 'package:mobile_app/SignUp.dart';
import 'package:mobile_app/TheApp/Guardian.dart';
import 'package:mobile_app/localization.dart';
import 'package:mobile_app/main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';


class SignIn extends StatefulWidget{


  late Function (Locale) _setLocale;
  late Function(Color) changecolor;

  SignIn(Function(Locale)_setLocale,Function(Color) changecolor){
    this.changecolor=changecolor;
    this._setLocale=_setLocale;
  }
  
  @override
  State<StatefulWidget> createState() {

   return SignInState(this._setLocale,this.changecolor);
  }

}

class SignInState extends State<SignIn>{

Future<void> sendImageToAPI(String base64Image) async {
  print('sendddddddd');
  try {
    final url = 'http://'+Constants.ip+':8000/get_email'; 
    final payload = {'image': base64Image};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );


    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if(responseData['message']=='1')
      Constants.Alert('please','check your email',context);
      print('Response from API: ${responseData['message']}');
    } else {
      print('Failed to send image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending image to API: $e');
  }
}

  TextEditingController _emailcontroller = TextEditingController(),_passwordcontroller=TextEditingController();

  late Function (Locale) _setLocale;
  late Function(Color) changecolor;

  SignInState(Function(Locale)_setLocale,Function(Color) changecolor){
    this.changecolor=changecolor;
    this._setLocale=_setLocale;
  }


  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  bool req_sign_in=false;

  @override
  Widget build(BuildContext context) {

    MyTextField email=
    MyTextField(AppLocalizations.of(context)!.translate('email'), 'y.yashoor@gmail.com', Icon(Icons.email),_emailcontroller),
    password=
    MyTextField(AppLocalizations.of(context)!.translate('password'), '12@##234dde', 
    Icon(Icons.lock),_passwordcontroller, dont_show_text: true, );

    return Scaffold(


      appBar: MyAppbar.myappbar(setLocale:  this._setLocale),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            SizedBox(height: 20,),
            email,
            SizedBox(height: 20,),
            password,
            SizedBox(height: 20,),
            Mybutton(AppLocalizations.of(context)!.translate('signin'), Icon(Icons.login), () async {

              if(req_sign_in)
              return;

              req_sign_in=true;

              Main.guardian= Guardian(email.getController().trim(), password.getController().trim());
              await Main.guardian.signin(context);

              req_sign_in=false;

             }),
            SizedBox(height: 20,),

            Row(children: <TextButton>[

              TextButton(onPressed: () async {

                final ImagePicker _picker = ImagePicker();
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                print('iiiiii');
                if (pickedFile != null) {
                  final imageBytes = await pickedFile.readAsBytes();
                  String base64Image = base64Encode(imageBytes);
                  print('fffffff');
                  sendImageToAPI(base64Image);
              }
                
              }, 
              child: Text(AppLocalizations.of(context)!.translate('forgetpassword'),
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),


              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(this._setLocale,this.changecolor)));
              }, child: Text(AppLocalizations.of(context)!.translate('createaccount'),
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))


            ],)

          ],

      )
      )
      

     

    );

  }

  
}