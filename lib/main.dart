import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final StreamController _streamController = StreamController();



  addData()async{
    for(int i = 1; i<= 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      _streamController.sink.add(i);
    }
  }

  Stream<int> numberStream() async*{
    for(int i = 1; i<= 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Stream"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: numberStream().map((number) => "number $number"),
          builder: (context, snapshot){
            if(snapshot.hasError)
              return Text("hey there is some error");
            else if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            return Text("${snapshot.data}", style: Theme.of(context).textTheme.display1,);
          },
        )
      ),

    );
  }
}
