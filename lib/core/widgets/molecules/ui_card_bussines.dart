import 'package:flutter/material.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';

class UiCardBussines extends StatelessWidget {
  final String image, title, subtitle, link;
  final Function onTap;

  UiCardBussines(
      {this.image, this.title, this.subtitle, this.link, this.onTap});
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
                          '5 Juta - 10 Juta',
                          textSize: TextSize.medium,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: UiText(
                                  'Online',
                                  color: Colors.white,
                                  textSize: TextSize.small,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: UiText(
                                  'Offline',
                                  color: Colors.white,
                                  textSize: TextSize.small,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          ],
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
