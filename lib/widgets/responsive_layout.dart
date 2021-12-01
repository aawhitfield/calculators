import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveLayout({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = context.isTablet
        ? MediaQuery.of(context).size.width * 0.6
        : MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
