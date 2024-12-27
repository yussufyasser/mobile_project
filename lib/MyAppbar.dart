import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/Setting.dart';
import 'package:mobile_app/localization.dart';
import 'package:mobile_app/main.dart';

class MyAppbar{

   static  PreferredSizeWidget myappbar({bool flag:false,bool learing:false,
   studying:false,void Function()? onPressed : null,settings:false,Function(Locale)? setLocale,Function(Color)? changecolor,
   coursevideo:false,learning_setting:false}){

    PopupMenuButton menu=PopupMenuButton(

      itemBuilder: ((context) {


        if(flag)
        return <PopupMenuEntry>[

          PopupMenuItem(child: ListTile(
            title:Text(Main.guardian.id), 
            )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('ar', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('arabic'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('en', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('english'),)),
          )),
          
          PopupMenuItem(child: ListTile(
            
            title: TextButton(onPressed: (){ Constants.gethelp(context);  }, 
            child: Text(AppLocalizations.of(context)!.translate('help'),)),
          )),

            PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(changecolor!, setLocale! )));},
            child: Text(AppLocalizations.of(context)!.translate('settings'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Main.guardian.sign_out(context);},
            child: Text(AppLocalizations.of(context)!.translate('signout'),)),
          )),
    

        ];

        if(learing || studying)
        return <PopupMenuEntry>[

          PopupMenuItem(child: ListTile(
            title:Text(Main.guardian.id), 
            )),

          
          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){
              Constants.gethelp(context);
            },
            child: Text(AppLocalizations.of(context)!.translate('help'),)),
          )),

            PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(changecolor!, setLocale!,learn: true, )  ));},
            child: Text(AppLocalizations.of(context)!.translate('settings'),)),
          )),


          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Main.guardian.sign_out(context);},
            child: Text(AppLocalizations.of(context)!.translate('signout'),)),
          )),
    

        ];

        if(settings)
        return <PopupMenuEntry>[

          PopupMenuItem(child: ListTile(
            title:  Text(Main.guardian.id),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('ar', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('arabic'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('en', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('english'),)),
          )),
          
          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){
              Constants.gethelp(context);
            },
            child: Text(AppLocalizations.of(context)!.translate('help'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Main.guardian.sign_out(context);},
            child: Text(AppLocalizations.of(context)!.translate('signout'),)),
          )),
    

        ];

        if(learning_setting)
        return <PopupMenuEntry>[

          PopupMenuItem(child: ListTile(
            title:  Text(Main.guardian.id),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){
              Constants.gethelp(context);
            },
            child: Text(AppLocalizations.of(context)!.translate('help'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){Main.guardian.sign_out(context);},
            child: Text(AppLocalizations.of(context)!.translate('signout'),)),
          )),
    

        ];


        return <PopupMenuEntry>[

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('ar', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('arabic'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){setLocale!(Locale('en', ''));Navigator.pop(context);},
            child: Text(AppLocalizations.of(context)!.translate('english'),)),
          )),

          PopupMenuItem(child: ListTile(

            title: TextButton(onPressed: (){ Constants.gethelp(context);   },
            child: Text(AppLocalizations.of(context)!.translate('help'),)),
          )),



        ];
      }),

    );

    if(studying)
    return AppBar(

      backgroundColor: const Color.fromARGB(255, 174, 130, 127),

      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),

      actions: [menu],

      leading: IconButton(icon:  Icon(Icons.arrow_back), onPressed: onPressed,),
    );

    if(coursevideo)
    return AppBar(

      backgroundColor: const Color.fromARGB(255, 174, 130, 127),

      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),

      leading: IconButton(icon:  Icon(Icons.arrow_back), onPressed: onPressed,),
    );     

    return AppBar(

      backgroundColor: const Color.fromARGB(255, 174, 130, 127),

      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),

      actions: [menu],
    );
   }
}