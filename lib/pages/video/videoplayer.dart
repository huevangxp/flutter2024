import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

var amout = 0;

  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text('Title', style: TextStyle(fontSize: 20),),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text('The meaning of DESCRIPTION is an act of describing; specifically : discourse intended to give a mental image of something experienced.',),
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text('price : 30.000.000 kip',),
        ),
        Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
              crossAxisAlignment:CrossAxisAlignment.start,

                    children: [
                       Image.network('https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg', width: 200, height: 200,)
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding:const EdgeInsets.all(20),
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(20),
              color: Colors.teal.withOpacity(0.1)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              // Icon(Icons.add_circle),
              Container(
                child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    if(amout >= 1){
                      amout --;
                    }
                  });
                }, 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
                child: Icon(Icons.remove_shopping_cart_sharp),
                )
              ),
              Text('$amout', style: TextStyle(fontSize: 18),),
              // 
              Container(
                child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    amout ++;
                  });
                }, 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
                child: Icon(Icons.add_shopping_cart ),
                ),
              ),
              Container(
                child: ElevatedButton.icon(
                onPressed: (){
                  
                }, 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
                label: Text('Add Cart'), 
                icon: Icon(Icons.shopping_cart_checkout),),
              )
            ],),
          )
          
      ]),
    );
  }
}
