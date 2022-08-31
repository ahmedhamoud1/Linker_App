import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linker/layout/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
        Duration(milliseconds: 5000,),()
    => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Home()),
            (route) => false) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff000000),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            // color(0xffd8b6dd)
            Expanded(
                child: Image(
                  image: AssetImage('images/1.jpg'),
                )
            )
          ],
        ),
      ),
    );
  }
}