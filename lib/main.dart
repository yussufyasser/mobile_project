
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/Constants.dart';
import 'package:mobile_app/Home.dart';
import 'package:mobile_app/TheApp/Guardian.dart';
import 'package:mobile_app/signin.dart';
import 'localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Main{

  static Guardian guardian=Guardian.init();
  static bool start=false;
}


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await  FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null){
          Main.start =true;
          Main.guardian.id=user.email!;

        }
        


      });

  Constants.setip();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return MyAppState();
  }


}

class MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', '');
  Color color=Colors.white;


  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

   void changecolor(Color color)async {
      
    setState(() {

      this.color=color;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(Main.start)
      return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: this.color, ),

          locale: _locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ar', ''),
          ],

        routes: {'/home': (context) => Home(_setLocale,changecolor), 
        '/sign_in':(context) => SignIn(_setLocale,changecolor)},

          home: Home(_setLocale,changecolor),
    );
    

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: this.color, ),

      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],

    routes: {'/home': (context) => Home(_setLocale,changecolor), 
    '/sign_in':(context) => SignIn(_setLocale,changecolor)},

      home: SignIn(_setLocale,changecolor),
    );
  }
}

