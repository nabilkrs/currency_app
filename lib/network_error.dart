import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NetworkError extends StatefulWidget {
  @override
  _NetworkErrorState createState() => _NetworkErrorState();
}

class _NetworkErrorState extends State<NetworkError> {
  double v = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomLeft, colors: [
              Colors.deepOrange,
              Colors.deepOrange[900],
            ])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/connection_error.png'),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                 
                  text: [
                    "No Internet Connection",
                    "Please connect to network",
                  ],
                  textStyle: TextStyle(fontSize: 20, fontFamily: "Muli"),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
