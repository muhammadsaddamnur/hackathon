import 'package:flutter/material.dart';

class Bussines extends StatefulWidget {
  @override
  _BussinesState createState() => _BussinesState();
}

class _BussinesState extends State<Bussines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AppBar(),
          )),
      body: Container(),
    );
  }
}
