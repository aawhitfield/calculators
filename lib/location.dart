import 'package:calculators/globals.dart';
import 'package:calculators/my_input_page.dart';
import 'package:calculators/renovations.dart';
import 'package:flutter/material.dart';

import 'address_form.dart';



class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInputPage(headlineText: 'Residential REI', imageUri: 'images/house_searching.svg',
      headerText: 'Let\'s first find the property', subheadText: 'Where is the property located?',
      child: const AddressForm(),
      goTo: const Renovations(),
      position: 1,
      totalQuestions: kResidentialREIQuestions.length,
    );
  }
}
