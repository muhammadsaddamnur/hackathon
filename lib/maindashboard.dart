import 'package:flutter/material.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';
import 'package:hackathon/features/home/view/home.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = 0;

  void itemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      // bottomNavigationBar: SizedBox(
      //   height: 50,
      //   child: BottomNavigationBar(
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             size: 20,
      //           ),
      //           title: UiText(
      //             'Home',
      //             textSize: TextSize.small,
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             size: 20,
      //           ),
      //           title: UiText(
      //             'Home',
      //             textSize: TextSize.small,
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             size: 20,
      //           ),
      //           title: UiText(
      //             'Home',
      //             textSize: TextSize.small,
      //           )),
      //     ],
      //     currentIndex: selectedIndex,
      //     selectedItemColor: Colors.amber[800],
      //     onTap: itemTap,
      //   ),
      // ),
    );
  }
}
