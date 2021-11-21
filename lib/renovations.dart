import 'package:calculators/globals.dart';
import 'package:calculators/widgets/dollar_prefix.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class Renovations extends StatefulWidget {
  const Renovations({Key? key}) : super(key: key);

  @override
  State<Renovations> createState() => _RenovationsState();
}

class _RenovationsState extends State<Renovations> {
  bool enterTotal = true;

  @override
  Widget build(BuildContext context) {
    return MyInputPage(
      imageUri: 'images/construction.svg',
      headerText: 'Renovations',
      subheadText: 'How much will it take to renovate the property?',
      onSubmit: () {},
      position: 2,
      totalQuestions: kResidentialREIQuestions.length,
      child: ResponsiveLayout(
        children: (enterTotal)
            ? [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DollarPrefix(
                    child: TextField(
                        decoration: InputDecoration(
                      labelText: 'Total cost',
                    )),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      enterTotal = false;
                    });
                  },
                  child: const Text(
                    'Or enter renovations by category',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ]
            : [
          TextButton(
            onPressed: () {
              setState(() {
                enterTotal = true;
              });
            },
            child: const Text(
              'Just enter the total',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Foundation',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Roof',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Air Conditioner',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Painting/Patching',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Kitchen',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Windows',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Plumbing',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Flooring',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Bathrooms',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Appliances',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Electrical',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Yard',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Cleaning',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Baseboards',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Exterior',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Demo',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Elevators',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Build 28 units',
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DollarPrefix(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Other',
                  )),
            ),
          ),
              ],
      ),
    );
  }
}
