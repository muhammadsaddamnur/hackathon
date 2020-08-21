import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/features/forum/view/forum_detail.dart';

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  CollectionReference _forums = FirebaseFirestore.instance.collection('forums');
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: _forums.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return new ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document.data()['full_name']),
                    subtitle: new Text(document.data()['post']),
                    onTap: () {
                      debugPrint(document.id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForumDetail(
                                    documentId: document.id,
                                  )));
                    },
                  );
                }).toList(),
              );
            },
          )),
          TextField(
            controller: _controller,
            onSubmitted: (value) {
              var now = new DateTime.now();
              _forums.add({
                'full_name': 'saddam',
                'date': now,
                'post': '$value',
                'comment': [],
                'index': 0
              }).then((value) {
                _controller.clear();
                print("Added");
              }).catchError((error) => print("Failed to add : $error"));
            },
          )
        ],
      ),
    );
  }
}
