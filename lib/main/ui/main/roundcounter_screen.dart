import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';


class RoundCounterScreen extends StatefulWidget {

  @override
  _RoundCounterScreenState createState() => _RoundCounterScreenState();
}

class _RoundCounterScreenState extends State<RoundCounterScreen> {

  var counter = 0;
  final List<List<Color>> colorList = 
    [
      [
        Color(0xff2C5364),
        Color(0xff0F2027),
      ],
      [
        Color(0xff8E0E00),
        Color(0xff1F1C18),
      ],
      [
        Color(0xff923cb5),
        Color(0xff304352),
      ],
      [
        Color(0xffBA8B02),
        Color(0xff181818),
      ],
      [
        Color(0xff3d72b4),
        Color(0xff525252),
      ],
      [
        Color(0xff6A9113),
        Color(0xff141517),
      ],
      [
        Color(0xff9DC5C3),
        Color(0xff29323c),
      ],
      [
        Color(0xffe74c3c),
        Color(0xff000000),
      ],
      [
        Color(0xff870000),
        Color(0xff190A05),
      ],
      [
        Color(0xff7F5A83),
        Color(0xff232526),
      ],
    ];
  
  var duration = Duration( milliseconds: -5000 );
  String twoDigits( int n ) => n.toString().padLeft(2, '0'); //* 9 ---> 09 | 11 ---> 11
  Timer? timer;

  Offset _pointerDownPosition = Offset(0,0);

  void addTime() {
    final addSecond = 1;

    setState(() {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration( seconds: seconds );
    });
  }

  void startTimer() => timer = Timer.periodic( Duration( seconds: 1 ), (_) => addTime() );

  void reset() {
    timer?.cancel();
    setState(() => duration = Duration( milliseconds: -5000 ));
  }
  void pause() {
    bool active = timer?.isActive ?? false;
    active ? timer?.cancel() : startTimer();
  }

  @override
  void initState() { 
    Wakelock.enable();
    super.initState();
  }

  @override
    void dispose() {
      timer?.cancel();
      Wakelock.disable();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(      
      body: Listener(
        onPointerDown: ( details ) {
          _pointerDownPosition = details.position;
        },
        onPointerUp: (details) {
          if (details.position.dy - _pointerDownPosition.dy > 50.0) {
            if ( counter != 0 ) {
              setState(() => counter--);
            }
          }
        },
        child: GestureDetector(
          onTap: () => setState(() => counter++),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration( 
              color: Colors.black,
              gradient: LinearGradient( 
                colors: [
                  colorList[counter % 10][0],
                  colorList[counter % 10][1],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ) 
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Text( '$counter', 
                        style: TextStyle( color: Colors.white, fontSize: 200 )
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      counter = 0;
                      reset();
                    }),
                    child: Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only( top: 5 ),
                      child: Text( 'RESET', 
                        style: TextStyle( color: Colors.white, fontSize: 30 ) 
                      ),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: () => pause(),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _timer(),
                    ),
                  ),
                  
                ]
              ),
            ),
     ),
        ),
      ),
   );
  }

  Widget _timer() {
    final minutes = twoDigits( duration.inMinutes.remainder(60) );
    final seconds = twoDigits( duration.inSeconds.remainder(60) );

    if ( int.parse(seconds) < 0 ) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          Text( 'Countdown', 
            style: TextStyle( color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold ) 
          ),
          Text( '$seconds', 
            style: TextStyle( color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold ) 
          )

        ]
      );
    }

    return Text( '$minutes:$seconds', 
      style: TextStyle( color: Colors.white, fontSize: 42 ) 
    );
  }
}

