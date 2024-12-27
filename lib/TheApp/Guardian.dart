import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/ChildOptions.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/TheApp/child.dart';
import 'package:mobile_app/TheApp/person.dart';
import 'package:mobile_app/localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Guardian extends person{

  late String password;

  Guardian(String id,String password):super.id(id){
    this.password=password;
  }

  Guardian.init():super.empty(){}


  Future<dynamic> sign_out(BuildContext context) async {

    await FirebaseAuth.instance.signOut();
     Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false); 
  }



  Future<void> signup(BuildContext context,String confirmpassword) async {

    if(this.id.isEmpty || this.password.isEmpty  || confirmpassword.isEmpty)
    Constants.Alert(AppLocalizations.of(context)!.translate('please'),
       AppLocalizations.of(context)!.translate('fillall'), context);
    
    else if(this.password != confirmpassword)
    Constants.Alert(AppLocalizations.of(context)!.translate('sorry'),
    AppLocalizations.of(context)!.translate('mismatch'), context);

    else if( !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',).hasMatch(this.id) )
    Constants.Alert(AppLocalizations.of(context)!.translate('sorry'),
    AppLocalizations.of(context)!.translate('notemail'), context);

    else{

        try {

          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: this.id,password: this.password,);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); 
          
          } on FirebaseAuthException catch (e) {
            print(e);
            print(e.code);
            if (e.code == 'weak-password')
            Constants.Alert(AppLocalizations.of(context)!.translate('sorry'),
            AppLocalizations.of(context)!.translate('weakpassword'), context);
          else if (e.code == 'email-already-in-use')
          Constants.Alert(AppLocalizations.of(context)!.translate('sorry'),
          AppLocalizations.of(context)!.translate('usedemail'), context);
          } catch (e) {} 


       
      }

    }


  

  Future<void> signin(BuildContext context) async {

    if(this.id.isEmpty || this.password.isEmpty)
      Constants.Alert(AppLocalizations.of(context)!.translate('please'),
       AppLocalizations.of(context)!.translate('fillall'), context);


    else{
      try {
        
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: this.id,
          password: this.password);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); 

          } on FirebaseAuthException catch (e) {

            Constants.Alert(AppLocalizations.of(context)!.translate('takecare'),
              AppLocalizations.of(context)!.translate('signinissue'), context);

        }
    }
  }

   

  StreamBuilder<QuerySnapshot> Display_children(BuildContext context,Function(Locale) _setLocale,Function(Color) changecolor ){

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('children').where('guardian',isEqualTo: this.id).snapshots(), 
      builder: (BuildContext, AsyncSnapshot snapshot){

        if(snapshot.hasError){
          print(snapshot.error);
        return Text('error');
        }
        

        else if(snapshot.connectionState==ConnectionState.waiting)
        return Center( child:  CircularProgressIndicator() );

        List<QueryDocumentSnapshot<Map<String, dynamic>>> data=snapshot.data!.docs;
        


        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),

          child: Column(
          
            children: List.generate(data.length,
             (index) {

              return SizedBox(width: MediaQuery.of(context).size.width,

             child: FutureBuilder<String>(
              
             future: getImageURL("children/"+data[index].id),

              builder: (context, AsyncSnapshot<String> Imgsnap){

                if(Imgsnap.connectionState==ConnectionState.waiting)
                return Center(child: CircularProgressIndicator(),);

                else if(Imgsnap.hasError)
                return Text('error');

                Image img=Image.network(Imgsnap.data!,width: 100, height: 100,fit: BoxFit.cover,);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {

                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ChildOptions( _setLocale, child.learing(data[index]['name_arabic'],data[index]['name_en'],img,data[index].id) ,changecolor)));
   
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.network(Imgsnap.data!,width: 100, height: 100,fit: BoxFit.cover,),
                            SizedBox(width: 16), 
                            Expanded(child: 
                            Text(data[index][AppLocalizations.of(context)!.translate('name')],
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),
                            overflow: TextOverflow.ellipsis, ),
                            ),
                            ]
                            ),
                            )
                            );

              }
              )
             
             );}
             
             
           ),
          ),
        );


      }

      );


  }


}