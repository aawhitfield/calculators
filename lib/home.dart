import 'package:calculators/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                'Residential REI',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 32),
              SvgPicture.asset(
                'images/house_searching.svg',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 32),
              Text(
                'Let\'s first find the property',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Where is the property located?',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const MyTextField(),
              const MyTextField(),
              const MyTextField(),
              const MyTextField(),
              const MyTextField(),
              const MyTextField(),
              ElevatedButton(
                onPressed: () {},
                child: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
