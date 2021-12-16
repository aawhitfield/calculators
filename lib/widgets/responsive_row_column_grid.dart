import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResponsiveRowColumnGrid extends StatelessWidget {
  final String heading;
  final String subheading;
  final List<Widget> children;

  const ResponsiveRowColumnGrid({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = context.isTablet
    //     ? MediaQuery.of(context).size.width * 0.6
    //     : MediaQuery.of(context).size.width;

    TextStyle? headline = context.isTablet
        ? Theme.of(context).textTheme.headline2
        : Theme.of(context).textTheme.headline3;

    TextStyle? header = context.isTablet
        ? Theme.of(context).textTheme.headline3
        : Theme.of(context).textTheme.headline4;

    // TextStyle? subhead = context.isTablet
    //     ? Theme.of(context).textTheme.headline4
    //     : Theme.of(context).textTheme.headline5;

    bool isTablet = context.isTablet;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    heading,
                    style: headline,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  subheading,
                  style: header,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                (isTablet)
                    ? GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: children,
                      )
                    : (isPortrait)
                        ? Column(
                            children: children,
                          )
                        : SizedBox(
                            height: 250,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: children,
                            ),
                          ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
