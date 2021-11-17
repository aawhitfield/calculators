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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const Text('Residential REI'),
            SvgPicture.asset('images/house_searching.svg'),
            const Text('Let\'s first find the property'),
            const Text('Where is the property located?'),
            const TextField(),
            const TextField(),
            const TextField(),
            const TextField(),
            const TextField(),
            const TextField(),
            ElevatedButton(
              onPressed: () {  },
              child: null,
            ),
          ],
        ),
      ),


    );
  }
}