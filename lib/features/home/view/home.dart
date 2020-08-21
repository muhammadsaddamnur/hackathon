import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/core/widgets/atoms/ui_button.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';
import 'package:hackathon/core/widgets/molecules/ui_card_bussines.dart';
import 'package:hackathon/core/widgets/molecules/ui_card_news.dart';
import 'package:hackathon/core/widgets/templates/ui_scaffold.dart';
import 'package:hackathon/features/forum/view/forum.dart';
import 'package:hackathon/features/intro/view/intro_register.dart';
import 'package:hackathon/features/search/view/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    int selectedIndex = 0;

    void itemTap(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return UiScaffold(
      onTapSearch: () {},
      searchPage: Search(),
      bottomNavBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                title: UiText(
                  'Home',
                  textSize: TextSize.small,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                title: UiText(
                  'Home',
                  textSize: TextSize.small,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                title: UiText(
                  'Home',
                  textSize: TextSize.small,
                )),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: itemTap,
        ),
      ),
      images: [
        'https://cdn02.indozone.id/re/content/2019/12/24/WYsLVz/t_5e01d0b404b34.jpg?w=700&q=85',
        'https://img-global.cpcdn.com/recipes/2c536a2e01fea65b/640x640sq70/photo.jpg',
        'https://cdn02.indozone.id/re/content/2019/12/24/WYsLVz/t_5e01d0b404b34.jpg?w=700&q=85',
        'https://cdn02.indozone.id/re/content/2019/12/24/WYsLVz/t_5e01d0b404b34.jpg?w=700&q=85',
      ],
      children: [
        UiCardNews(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
        ),
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          child: UiButton(
            text: 'Text',
            onTap: () {},
            fillColor: Colors.green,
          ),
        ),
        UiCardBussines(
          onTap: () async {
            users
                .add(
                    {'full_name': 'saddam', 'company': 'company', 'age': 'age'})
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          },
        ),
        UiCardNews(
          onTap: () async {
            users
                .add(
                    {'full_name': 'saddam', 'company': 'company', 'age': 'age'})
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiText(
                        'Penjual Pecel Cantik',
                        textSize: TextSize.medium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UiText(
                        'Penjual Pecel Cantik',
                        textSize: TextSize.small,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Icon(
                                Icons.home,
                                size: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: UiText(
                              'Penjual Pecel CantikPenjual Pecel CantikPenjual Pecel Cantik',
                              textSize: TextSize.small,
                              maxLines: 1,
                            ),
                          ),
                          UiText(
                            'Rp 4.000.000',
                            textSize: TextSize.small,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                  ),
                ))
              ],
            ),
          ),
        ),
        UiCardNews(
          onTap: () {
            debugPrint("ddd");
            FirebaseFirestore.instance
                .collection('users')
                .get()
                .then((QuerySnapshot querySnapshot) => {
                      querySnapshot.docs.forEach((doc) {
                        print(doc.data()['age']);
                      })
                    });
          },
        ),
        UiCardNews(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Forum()));
          },
        ),
        UiCardNews(),
        StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
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
                  subtitle: new Text(document.data()['company']),
                  onTap: () {
                    debugPrint(document.id);
                  },
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}
