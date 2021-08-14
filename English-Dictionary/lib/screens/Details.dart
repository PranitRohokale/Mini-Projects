import 'dart:ffi';

import 'package:flutter/material.dart';

class ShowDetail extends StatelessWidget {
  var listObj, word;

  ShowDetail(this.listObj, this.word);

  @override
  Widget build(BuildContext context) {
    var imgUrl = listObj['image_url'] != null
        ? listObj['image_url']
        : 'https://image.shutterstock.com/image-illustration/learn-english-word-cloud-concept-260nw-370009280.jpg';
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: [
          //images
          Positioned(
              top: 35.0,
              left: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                width: _size.width,
                height: _size.height * 0.5,
                decoration: BoxDecoration(color: Colors.white),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  // alignment: Alignment.center,
                ),
              )),
          Positioned(
              top: 60.0,
              left: 10.0,
              // left: 20.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 32.0,
                color: Theme.of(context).primaryColor,
                onPressed: () => Navigator.of(context).pop(),
              )),
          Positioned(
              top: _size.height * 0.5,
              child: Container(
                height: _size.height * 0.7,
                width: _size.width,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.purpleAccent]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.0),
                        topRight: Radius.circular(22.0))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                width: _size.width,
                                height: 50.0,
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    word.toString().toUpperCase() +
                                        ' ( ' +
                                        listObj['type'] +
                                        ' ) ',
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    //defination
                    getDetails('definition'),

                    SizedBox(
                      height: 10.0,
                    ),

                    //example
                    getDetails('example'),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getDetails(String key) {
    return listObj[key] != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5.50),
                child: Text(
                  key.toString().toUpperCase() + " : ",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              Card(
                  elevation: 1,
                  color: Colors.white,
                  shadowColor: Colors.blueGrey,
                  child: Container(
                    width: 800.0,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      listObj[key],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )),
            ],
          )
        : SizedBox();
  }
}
