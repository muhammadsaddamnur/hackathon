import 'package:flutter/material.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';

class UiCardNews extends StatelessWidget {
  final String image, title, subtitle, link;
  final Function onTap;

  UiCardNews({this.image, this.title, this.subtitle, this.link, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Container(
        height: 100,
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
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Container(
                    child: Image.network(
                      'https://nawacita.co/wp-content/uploads/2019/09/unnamed.jpg',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UiText(
                          'Penjual Pecel Cantik',
                          textSize: TextSize.medium,
                          fontWeight: FontWeight.w500,
                        ),
                        UiText(
                          'Lima Gadis Cantik Penjual ini bikin heboh jejaring sosial  media di Indonesia. Dimulai dari Si Ninih, Gadis cantik penjual Getuk, Sasa Darfika mahasiswi cantik penjaga warteg, Tukang Tambal ban jelita, Dewi Luna Penjual kelapa cantik yang ternyata Mantan artis dangdut dan yang terakhir cewek tukang nasi pecel yang belum diketahui namanya.',
                          textSize: TextSize.small,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        UiText(
                          'https://www.kejadiananeh.com/2015/05/...',
                          textSize: TextSize.small,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
