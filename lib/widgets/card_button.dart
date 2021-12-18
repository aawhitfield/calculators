import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CardButton extends StatelessWidget {
  final String? svgImage;
  final double? imageSize;
  final String label;
  final VoidCallback onPressed;
  
  const CardButton({
    Key? key, this.svgImage, this.imageSize, required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool kIsTablet = context.isTablet;

    return Card(
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
      children: [
            (svgImage != null)
              ? SvgPicture.asset(svgImage!,
              width: imageSize,
              height: imageSize,
            )
                :const Icon(Icons.home),
            const SizedBox(height: 16),
            Text(label, style: (kIsTablet)
                ? Theme.of(context).textTheme.headline4
                : Theme.of(context).textTheme.headline6,),
      ],
    ),
          ),
        ));
  }
}
