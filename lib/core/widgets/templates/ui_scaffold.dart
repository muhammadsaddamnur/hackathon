import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/core/widgets/atoms/ui_text.dart';
import 'package:hackathon/features/search/view/search.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UiScaffold extends StatefulWidget {
  final List<String> images;
  final List<Widget> children;
  final Function onTapSearch;
  final Widget searchPage, bottomNavBar;

  UiScaffold(
      {this.images,
      this.children,
      this.onTapSearch,
      this.searchPage,
      this.bottomNavBar});
  @override
  _UiScaffoldState createState() => _UiScaffoldState();
}

class _UiScaffoldState extends State<UiScaffold> {
  double appBarWidth = 0;
  double appBarHeight = 0;
  double appBarPaddingTop = 50;
  Color appBarColor = Colors.white;
  CrossAxisAlignment appBarCrossAxisAlignment = CrossAxisAlignment.center;
  double appBarPadding = 8;
  BorderRadiusGeometry appBarSearchBorderRadius = BorderRadius.circular(8);

  ScrollController scrollController = ScrollController();
  bool scrollMark = false;

  double statusBarHeight;
  double statusBarPadding;
  Color statusBar;
  Brightness statusIcon;

  bool isSearch = false;

  PageController bannerController = PageController(
    initialPage: 0,
  );
  int currentBanner = 0;
  Timer timer;

  timerBanner() {
    timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (currentBanner < widget.images.length) {
        currentBanner++;
      } else {
        currentBanner = 0;
      }

      bannerController.animateToPage(
        currentBanner,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  void infiniteControllerListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    debugPrint(currentScroll.toString());
    if (currentScroll > 50) {
      if (scrollMark == false) {
        setState(() {
          scrollMark = true;
          appBarWidth = MediaQuery.of(context).size.width;
          appBarHeight = 90;
          appBarPaddingTop = 0;
          appBarColor = Colors.white;
          appBarSearchBorderRadius = BorderRadius.circular(0.0);
          statusBar = Colors.white;
          statusIcon = Brightness.dark;
          appBarCrossAxisAlignment = CrossAxisAlignment.end;
          appBarPadding = 20;
          timer.cancel();
        });
      }
    } else {
      if (scrollMark == true) {
        setState(() {
          scrollMark = false;
          appBarWidth = MediaQuery.of(context).size.width - 50;
          appBarHeight = 50;
          appBarPaddingTop = 40;
          appBarColor = Colors.white;
          appBarSearchBorderRadius = BorderRadius.circular(10);
          statusBar = Colors.transparent;
          statusIcon = Brightness.light;
          appBarCrossAxisAlignment = CrossAxisAlignment.center;
          appBarPadding = 8;
          timerBanner();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    timerBanner();

    Future.microtask(() {
      setState(() {
        appBarWidth = MediaQuery.of(context).size.width - 50;
        appBarHeight = 50;
        statusBarHeight = MediaQuery.of(context).padding.top;
        // statusBarPadding = MediaQuery.of(context).size.height - 90;
        statusBarPadding = MediaQuery.of(context).size.height -
            (50 + MediaQuery.of(context).padding.top * 3.5);
        statusBar = Colors.transparent;
        statusIcon = Brightness.light;
        appBarCrossAxisAlignment = CrossAxisAlignment.center;
        appBarPadding = 8;
      });
    });

    scrollController.addListener(infiniteControllerListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      appBarWidth = MediaQuery.of(context).size.width - 50;
      appBarHeight = 50;
      statusBarHeight = MediaQuery.of(context).padding.top;
      // statusBarPadding = MediaQuery.of(context).size.height - 90;
      statusBarPadding = MediaQuery.of(context).size.height -
          (50 + MediaQuery.of(context).padding.top * 3.5);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: statusBar, statusBarIconBrightness: statusIcon),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            isSearch
                ? Search()
                : Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      child: Column(
                        children: [
                          widget.images == null
                              ? SizedBox()
                              : Container(
                                  height: 280,
                                  child: Stack(
                                    children: [
                                      PageView.builder(
                                        controller: bannerController,
                                        itemCount: widget.images.length,
                                        onPageChanged: (index) {
                                          setState(() {
                                            currentBanner = index;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Image.network(
                                                widget.images[index],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fill,
                                                height: 280,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: SmoothPageIndicator(
                                            controller: bannerController,
                                            count: widget.images.length,
                                            effect: WormEffect(
                                              dotHeight: 10,
                                              dotWidth: 10,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          Column(
                            children: widget.children,
                          )
                        ],
                      ),
                    ),
                  ),
            Positioned(
              bottom: isSearch
                  ? MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top * 3.5)
                  : statusBarPadding,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      scrollMark = true;
                      appBarWidth = MediaQuery.of(context).size.width;
                      appBarHeight = 90;
                      appBarPaddingTop = 0;
                      appBarColor = Colors.white;
                      appBarSearchBorderRadius = BorderRadius.circular(0.0);
                      statusBar = Colors.white;
                      statusIcon = Brightness.dark;
                      appBarCrossAxisAlignment = CrossAxisAlignment.end;
                      appBarPadding = 20;
                      isSearch = true;
                      timer.cancel();
                    });
                    widget.onTapSearch();
                  },
                  child: AnimatedContainer(
                    width: appBarWidth,
                    height: appBarHeight,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: appBarSearchBorderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: appBarWidth,
                      height: appBarHeight,
                      child: Row(
                        crossAxisAlignment: appBarCrossAxisAlignment,
                        children: <Widget>[
                          AnimatedPadding(
                            padding: EdgeInsets.only(
                                top: appBarPadding,
                                bottom: appBarPadding,
                                left: appBarPadding),
                            duration: Duration(milliseconds: 300),
                            child: InkWell(
                                onTap: () {
                                  if (isSearch)
                                    setState(() {
                                      isSearch = false;
                                      setState(() {
                                        scrollMark = false;
                                        appBarWidth =
                                            MediaQuery.of(context).size.width -
                                                50;
                                        appBarHeight = 50;
                                        appBarPaddingTop = 40;
                                        appBarColor = Colors.white;
                                        appBarSearchBorderRadius =
                                            BorderRadius.circular(10);
                                        statusBar = Colors.transparent;
                                        statusIcon = Brightness.light;
                                        appBarCrossAxisAlignment =
                                            CrossAxisAlignment.center;
                                        appBarPadding = 8;
                                        timerBanner();
                                      });
                                    });
                                },
                                child: Container(
                                    child: Icon(isSearch
                                        ? Icons.arrow_back
                                        : Icons.search))),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          AnimatedPadding(
                            padding: EdgeInsets.only(
                              top: appBarPadding + 5,
                              bottom: appBarPadding + 5,
                            ),
                            duration: Duration(milliseconds: 300),
                            child: Text('data'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: isSearch ? SizedBox() : widget.bottomNavBar,
      ),
    );
  }
}
