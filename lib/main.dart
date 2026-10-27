import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('我的扭蛋機'),
              ElevatedButton(
                onPressed: () {
                  print('扭蛋!');
                },
                child: Text('扭'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
