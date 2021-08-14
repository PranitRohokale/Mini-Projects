import 'dart:async';
import 'package:english_dictionary/screens/index.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onLoading);
  }

  onLoading() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      // return CovidData();
      return MyDictionary();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlueAccent, Colors.purpleAccent])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 70.0,height: 20.0,),
              Expanded(
                child: Center(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-15/360),
                    child: Text(
                      "❝ 𝐄𝐧𝐠𝐥𝐢𝐬𝐡 𝐃𝐢𝐜𝐭𝐢𝐨𝐧𝐚𝐫𝐲 ❞",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
