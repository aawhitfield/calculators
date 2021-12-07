import 'dart:math';

import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/waiting.dart';
import 'package:calculators/models/db/property_db.dart';
import 'package:calculators/models/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedPlaces extends ConsumerWidget {
  const SavedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> colors = [
      0xFF3DC2BA,
      0xFF3EC9A3,
      0xFF40B37B,
      0xFF3EC969,
      0xFF39BF47
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
            child: FutureBuilder<List<Property>>(
                future: PropertyDatabase.instance.readAllProperties(),
                builder: (context, snapshot) {
                  String label = 'Loading Properties';
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Waiting(label: label));
                  }
                  List<Property> properties =
                      List.from(snapshot.data ?? <Property>[]);

                  double size = min(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height) * 0.3;
                  return (properties.isEmpty)
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('images/404.svg',
                            width: size,
                            height: size,
                          ),
                          const SizedBox(height: 16),
                          Text('No properties saved', style: Theme.of(context).textTheme.headline5,),
                        ],
                      )
                      : ListView.separated(
                          itemCount: properties.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                Icons.place,
                                size: 48,
                                color: Color(colors[index % colors.length]),
                              ),
                              title: Text(properties[index].address),
                              subtitle: Text(CalculatorUtils.getName(properties[index].calculator)),
                              trailing:
                                  const Icon(CupertinoIcons.right_chevron),
                              onTap: () async {
                                int? id = properties[index].id;
                                if (id != null) {
                                  Property savedProperty = await PropertyDatabase.instance
                                      .readProperty(id);
                                  ref.read(propertyProvider).updateProperty(savedProperty);
                                }
                              },
                            );
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
