import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedPlaces extends StatelessWidget {
  const SavedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<int> colors = [
      0xFF6DFC71, 0xFF8ABD8C, 0xFF4CAF50, 0xFFB8FCBB, 0xFF367D38
    ];

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
                    title: const Text('Saved Address'),
                    subtitle: const Text('Calculator Type'),
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
