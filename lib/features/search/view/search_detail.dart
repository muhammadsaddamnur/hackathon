import 'package:flutter/material.dart';

class SearchDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        reverse: true,
        children: [
          Column(
            children: [
              Divider(
                height: 0,
                thickness: 1,
              ),
              ListTile(
                title: Text('data'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
