import 'package:flutter/material.dart';
import 'package:hackathon/core/widgets/atoms/ui_button.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';
import 'package:hackathon/features/bussines/view/bussines.dart';
import 'package:hackathon/features/search/view/search_detail.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: true,
        padding: EdgeInsets.all(8),
        children: [
          UiButton(
            fillColor: Colors.green,
            text: 'Kami Bantu Cari Ide',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Bussines()));
            },
          ),
          SizedBox(
            height: 30,
          ),
          UiButton(
            fillColor: Colors.white,
            borderColor: Colors.grey,
            textColor: Colors.grey,
            text: 'Mau usaha dibidang apa ?',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchDetail()));
            },
          ),
          UiButton(
            fillColor: Colors.white,
            borderColor: Colors.grey,
            textColor: Colors.grey,
            text: 'Modalnya berapa ?',
            onTap: () {},
          ),
          SizedBox(
            height: 5,
          ),
          UiText(
            'Coba diajawab ya, biar kami tau apa usaha yang cocok untuk kamu',
            maxLines: 3,
            textSize: TextSize.small,
          ),
          Lottie.asset('images/search.json'),
        ],
      ),
    );
  }
}
