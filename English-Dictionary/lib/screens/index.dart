import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'Details.dart';

class MyDictionary extends StatefulWidget {
  @override
  _MyDictionaryState createState() => _MyDictionaryState();
}

class _MyDictionaryState extends State<MyDictionary> {
  TextEditingController _controller = TextEditingController();
  final _token = "d336055240cdc3f75d11f70302a7fc8388a4301b";
  var _url = "https://owlbot.info/api/v4/dictionary/";

  StreamController _streamController;
  Stream _stream;

  Timer _hasTimerRequest;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  void _search() async {
    if (_controller.value == null ||
        _controller.value.toString().trim().length == 0) {
      _streamController.add(null);
      return;
    }

    //just for adding the purpose of circular progress bar
    _streamController.add("waitingQueue");

    final url = Uri.parse(_url + _controller.text.toString().trim());
    // print(url.toString());
    var response =
        await get(url, headers: {"Authorization": "Token " + _token});

    //adding the result into stream
    if (response.statusCode == 200)
      _streamController.add(json.decode(response.body));
    else
      _streamController.add("Not Found");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "English Dictionary",
          style: TextStyle(
              letterSpacing: 1.2, fontWeight: FontWeight.w600, fontSize: 24.0),
        )),
        bottom: PreferredSize(
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0)),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (String text) {
                          if (this._hasTimerRequest?.isActive ?? false)
                            _hasTimerRequest.cancel();
                          _hasTimerRequest =
                              Timer(Duration(milliseconds: 1500), _search);
                        },
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: "Search a word",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0)),
                      ),
                    )),
                Expanded(
                    child: IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    _search();
                  },
                ))
              ],
            ),
            preferredSize: Size.fromHeight(50.0)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.5),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Enter a search word...",textScaleFactor: 1.3,),
              );
            }

            if (snapshot.data == "waitingQueue") {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }

            if (snapshot.data == "NotFound") {
              return Center(
                child: Text("Opps..Result not found!"),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data['definitions'].length,
                itemBuilder: (BuildContext context, int index) {
                  var imgUrl = snapshot.data["definitions"][index]["image_url"];

                  return ListBody(
                    children: [
                      Container(
                          margin: EdgeInsets.all(5.5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.0,
                                    color: Colors.blueGrey.shade50,
                                    spreadRadius: 5.0)
                              ]),
                          child: ListTile(
                              leading: imgUrl != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(imgUrl),
                                    )
                                  : null,
                              title: Text(
                                (snapshot.data['word'] +
                                        ' ( ' +
                                        snapshot.data['definitions'][index]
                                            ["type"] +
                                        ' ) ')
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                snapshot.data['definitions'][index]
                                    ["definition"],
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ShowDetail(
                                          snapshot.data['definitions'][index],
                                          snapshot.data['word'])))))
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
