import 'package:calculators/globals.dart';
import 'package:calculators/widgets/dollar_prefix.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Renovations extends ConsumerWidget {
  const Renovations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      imageUri: 'images/construction.svg',
      headerText: 'Renovations',
      subheadText: 'How much will it take to renovate the property?',
      onSubmit: () {},
      position: 2,
      totalQuestions: kResidentialREIQuestions.length,
      child: const ResponsiveLayout(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                labelText: 'Total cost',
              )),
            ),
          ),
        ],
      ),
    );
  }
}
