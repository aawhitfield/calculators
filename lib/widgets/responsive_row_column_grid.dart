import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResponsiveRowColumnGrid extends StatelessWidget {
  final String? heading;
  final String subheading;
  final List<Widget> children;

  const ResponsiveRowColumnGrid({
    Key? key,
    this.heading,
    required this.subheading,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? header = context.isTablet
        ? Theme.of(context).textTheme.headline3
        : Theme.of(context).textTheme.headline4;

    // bool isTablet = context.isTablet;
    // bool isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;

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
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset('images/logo.png',
                      width: (context.isPortrait)
                        ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.4
                    ),
                  ),
                ),
                Text(
                  subheading,
                  style: header,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // (true) ?
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: (context.isPortrait)
                      ? (context.isTablet)
                          ? 1
                          : MediaQuery.of(context).size.width < 375
                              ? 0.7
                              : 0.8
                      : 1.5,
                  children: children,
                ),
                // : (isPortrait)
                //     ? Column(
                //         children: children,
                //       )
                //     : SizedBox(
                //         height: 250,
                //         child: ListView(
                //           shrinkWrap: true,
                //           physics: const ClampingScrollPhysics(),
                //           scrollDirection: Axis.horizontal,
                //           children: children,
                //         ),
                //       ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
