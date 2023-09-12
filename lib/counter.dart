import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Counter extends StatefulWidget {
  const Counter({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Counter> createState() => _CounterState();
}

const int limit = 31;

class _CounterState extends State<Counter> {
  int _counter = 0;
  List<int> _listaNums = [];

  void _handleCounter(int delta) {
    setState(() {
      if (delta < 0) {
        if (_counter > 0) {
          _counter--;
        }
      } else {
        if (_counter < limit) {
          _counter++;
        }
      }
    });
    Vibration.cancel();
    Vibration.vibrate(
        amplitude: 1, duration: (100 * (_counter / 2)).toInt() + 1);
  }

  void addNumber() {
    setState(() {
      _listaNums.add(_counter);
    });
  }

  static const TextStyle redNeon =
      TextStyle(color: Colors.white, fontSize: 15, shadows: <Shadow>[
    Shadow(
        color: Color.fromARGB(219, 255, 117, 107),
        blurRadius: 3,
        offset: Offset(0, 0)),
    Shadow(
        color: Color.fromARGB(170, 227, 55, 42),
        blurRadius: 10,
        offset: Offset(0, 0)),
    Shadow(
        color: Color.fromARGB(154, 183, 12, 0),
        blurRadius: 25,
        offset: Offset(0, 0)),
  ]);

  void decrease() {
    _handleCounter(-1);
  }

  void increase() {
    _handleCounter(1);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/download.jpg'),
          fit: BoxFit.cover,
        )),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        padding: const EdgeInsetsDirectional.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('Number of today:', style: redNeon),
            Text(
              '$_counter',
              style: redNeon,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: decrease,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('-'),
                ),
                TextButton(
                  onPressed: increase,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('+'),
                ),
                ElevatedButton(
                    onPressed: addNumber, child: const Text('Add to List')),
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Lista de números favoritos",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: _listaNums.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (_listaNums.isEmpty) {
                      return ListTile(
                        title: Text('Sem itens na lista.'),
                      );
                    }
                    return ListTile(
                      title: Text(
                        '${_listaNums[index]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
