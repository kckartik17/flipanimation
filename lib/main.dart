import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
AnimationController controller;
  Animation flip_anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    flip_anim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.5, curve: Curves.linear)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Center(child: Text('Animations'),),
        ),
        body: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return Center(
                child: InkWell(
                  onTap: () {
                    controller.repeat();
                  },
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: Transform(
                      transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.005)
                      ..rotateY(2 * pi * flip_anim.value),
                      alignment: Alignment.center,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.green.withOpacity(0.2),
                        child: RotationTransition(
                          turns: flip_anim,
                           child: Center(
                            child: Text('This flips',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                            )
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
