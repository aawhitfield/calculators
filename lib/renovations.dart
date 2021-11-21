import 'package:calculators/my_input_page.dart';
import 'package:flutter/material.dart';

class Renovations extends StatefulWidget {
  const Renovations({Key? key}) : super(key: key);

  @override
  _RenovationsState createState() => _RenovationsState();
}

class _RenovationsState extends State<Renovations> {
  @override
  Widget build(BuildContext context) {
    return MyInputPage(imageUri: 'images/construction.svg', headerText: 'Renovations', subheadText: 'How much will it take to renovate the property?', child: Container(), goTo: Container());
  }
}
