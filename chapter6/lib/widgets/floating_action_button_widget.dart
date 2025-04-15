import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text('클릭'),
        ),
        body: Container(),
      ),
    );
  }
}