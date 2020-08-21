import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForumDetail extends StatefulWidget {
  final String documentId;
  ForumDetail({this.documentId});
  @override
  _ForumDetailState createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  // String documentIds= widget.documentId;

  DocumentReference _forums;
  // dynamic data;
  Future<dynamic> getData() async {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
    setState(() {
      _forums = FirebaseFirestore.instance
          .collection('forums')
          .doc('${widget.documentId}');
    });

    // await _forums.get().then<dynamic>((DocumentSnapshot snapshot) async {
    //   debugPrint('biji' +
    //       snapshot.get(FieldPath([
    //         'post',
    //       ])));
    //   setState(() {
    //     data = snapshot.data();
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          // Container(
          //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          //   child: ListTile(
          //     title: Text(data == null ? '' : data['full_name'].toString()),
          //     subtitle:
          //         Text(data == null ? '' : data['comment'].length.toString()),
          //   ),
          // ),

          Expanded(
              child: StreamBuilder<DocumentSnapshot>(
            stream: _forums.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              List<dynamic> data2 = snapshot.data.data()['comment'];

              return Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: ListTile(
                      title: Text(snapshot.data.data()['full_name'].toString()),
                      subtitle: Text(
                          snapshot.data.data()['comment'].length.toString()),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.data()['comment'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(data2[index]['nama']),
                              Text(data2[index]['text']),
                            ],
                          );
                        }),
                  ),
                  RaisedButton(
                      child: Text('Tambahin/update data comment'),
                      onPressed: () {
                        CollectionReference forums =
                            FirebaseFirestore.instance.collection('forums');
                        // data2.add({'nama': 'aulia', 'text': 'tambahan'});
                        // forums
                        //     .doc('${widget.documentId}')
                        //     .update({'comment': data2})
                        //     .then((value) => print("User Updated"))
                        //     .catchError((error) =>
                        //         print("Failed to update user: $error"));

                        forums
                            .doc('${widget.documentId}')
                            .update({
                              'comment': FieldValue.arrayUnion([
                                {
                                  'nama': 'aaaaaaaa',
                                  'text': 'tambahan',
                                  'index': snapshot.data.data()['index'] + 1
                                }
                              ]),
                              'index': FieldValue.increment(1),
                              'date': FieldValue.serverTimestamp()
                            })
                            .then((value) => print("User Updated"))
                            .catchError((error) =>
                                print("Failed to update user: $error"));
                      }),
                ],
              );
            },
          )),
        ]));
  }
}
