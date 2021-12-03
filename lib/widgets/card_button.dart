import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            Text(label, style: Theme.of(context).textTheme.headline4,),
      ],
    ),
          ),
        ));
  }
}
