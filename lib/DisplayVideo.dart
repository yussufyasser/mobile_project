import 'package:flutter/material.dart';
import 'package:mobile_app/MyAppbar.dart';
import 'package:mobile_app/TheApp/course.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DisplayVideo extends StatelessWidget{
  
  late YoutubePlayerController _controller;
  late course Course;
  late bool learning;

  DisplayVideo(String myVideoId,{bool learning:false,course? Course,progress:0} ){

     _controller = YoutubePlayerController(initialVideoId:myVideoId,flags: const YoutubePlayerFlags(autoPlay: true,mute: false,), );

     if(learning){
      this.Course=Course!;
      this.Course.addprogress(progress);
    }

    this.learning=learning;
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.learning ?MyAppbar.myappbar(coursevideo: true,onPressed:(){Navigator.pop(context, this.Course);} ): AppBar(),

      body: YoutubePlayer( controller: _controller,liveUIColor: Colors.amber,),
    );
  }

  
}