import 'package:calculators/models/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedPlaces extends StatelessWidget {
  const SavedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<int> colors = [
      0xFF3DC2BA, 0xFF3EC9A3, 0xFF40B37B, 0xFF3EC969, 0xFF39BF47
    ];

    List<Property> properties = List.filled(10, Property(
        listPrice: 450000, address: '1910 Emmy Dr, Bakersfield, CA, 93307',

    ));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Saved Places',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(Icons.place, size: 48,
                      color: Color(colors[index % colors.length]),
                    ),
                    title: Text(properties[index].address),
                    subtitle: const Text('Residential REI'),
                  trailing: const Icon(CupertinoIcons.right_chevron),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
