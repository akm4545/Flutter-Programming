import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // 파란색 Container
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              ),

              // 빨간색 Container
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}