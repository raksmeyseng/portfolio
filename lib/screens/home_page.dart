import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/bottom_bar.dart';
import 'package:my_portfolio/widgets/carousel.dart';
import 'package:my_portfolio/widgets/destination_heading.dart';
import 'package:my_portfolio/widgets/discover_heading.dart';
import 'package:my_portfolio/widgets/explore_drawer.dart';
import 'package:my_portfolio/widgets/featured_heading.dart';
import 'package:my_portfolio/widgets/responsive.dart';
import 'package:my_portfolio/widgets/web_scrollbar.dart';

import '../widgets/featured_tiles.dart';
import '../widgets/top_bar_contents.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
                SizedBox(width: screenSize.width / 50),
              ],
              title: const Text(
                'RAKSMEY SENG',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Electrolize',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(null, opacity: _opacity),
            ),
      drawer: const ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: screenSize.height * 0.75,
                      width: screenSize.width,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 90, 106, 255),
                              Color.fromARGB(255, 68, 1, 74),
                            ],
                          ),
                        ),
                      )
                      // Image.asset(
                      //   'assets/images/cover.png',
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  Column(
                    children: [
                      // FloatingQuickAccessBar(screenSize: screenSize),
                      DiscoverHeading(screenSize: screenSize),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          FeaturedHeading(
                            screenSize: screenSize,
                          ),
                          FeaturedTiles(screenSize: screenSize)
                        ],
                      ),
                    ],
                  )
                ],
              ),
              DestinationHeading(screenSize: screenSize),
              const DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
