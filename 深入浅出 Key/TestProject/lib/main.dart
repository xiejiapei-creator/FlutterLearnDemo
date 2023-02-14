import 'dart:math';
import 'package:flutter/material.dart';

void main()=>runApp(MyScreenApp());

class MyScreenApp extends StatelessWidget {
  const MyScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}

// ====== 页面展示 ======

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Widget> widgets = [
    // StatelessContainer(),
    // StatelessContainer(),
    // StatefulContainer(),
    // StatefulContainer(),
    // StatefulContainer(key: UniqueKey(),),
    // StatefulContainer(key: UniqueKey(),),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: StatefulContainer(key: UniqueKey(),),
    // ),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: StatefulContainer(key: UniqueKey(),),
    // ),
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(),
    ),
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchWidget,
        child: Icon(Icons.undo),
      ),
    );
  }

  switchWidget(){
    widgets.insert(0, widgets.removeAt(1));
    setState(() {});
  }
}

// ====== Stateless 组件和 Stateful 组件 ======

class StatelessContainer extends StatelessWidget {
  final Color color = RandomColor().randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

class StatefulContainer extends StatefulWidget {
  // StatefulContainer({required Key key}) : super(key: key);
  @override
  _StatefulContainerState createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color color = RandomColor().randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

// ====== 随机颜色 ======

class RandomColor {
  Color randomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }
}

