import 'dart:math';

import 'package:calculators/inputs/location.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/db/database_utils.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/models/db/property_db.dart';
import 'package:calculators/models/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavedPlaces extends StatefulWidget {
  const SavedPlaces({Key? key}) : super(key: key);

  @override
  State<SavedPlaces> createState() => _SavedPlacesState();
}

class _SavedPlacesState extends State<SavedPlaces> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    List<int> colors = [
      0xFF3DC2BA,
      0xFF3EC9A3,
      0xFF40B37B,
      0xFF3EC969,
      0xFF39BF47
    ];

    void deletePlace(int id) {
      DatabaseUtils.deletePlaceByID(id);
      setState(() {
      });
    }

    return Consumer(
      builder: (context, ref, child) => Padding(
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    List<Property> properties =
                        List.from(snapshot.data ?? <Property>[]);

                    double size = min(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height) *
                        0.3;
                    return (properties.isEmpty)
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'images/404.svg',
                                width: size,
                                height: size,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No properties saved',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        BorderSide.none),
                                  ),
                                  icon: Icon((isEditing)
                                      ? CupertinoIcons.check_mark
                                      : CupertinoIcons.pencil),
                                  label: Text((isEditing) ? 'Done' : 'Edit'),
                                  onPressed: () {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: properties.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                        motion: const BehindMotion(),
                                        dismissible: DismissiblePane(
                                            onDismissed: () {
                                              if (properties[index].id != null) {
                                                deletePlace(properties[index].id!);
                                              }
                                            }),
                                        children: [
                                          SlidableAction(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.red,
                                              icon: Icons.archive,
                                              label: 'Delete',
                                              onPressed: (context) {
                                                if (properties[index].id != null) {
                                                  deletePlace(properties[index].id!);
                                                }
                                              },
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: (isEditing)
                                            ? IconButton(
                                                icon: const Icon(
                                                    CupertinoIcons
                                                        .minus_circle_fill,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  if (properties[index].id != null) {
                                                    deletePlace(properties[index].id!);
                                                  }
                                                },
                                              )
                                            : Icon(
                                                Icons.place,
                                                size: 48,
                                                color: Color(colors[
                                                    index % colors.length]),
                                              ),
                                        title: Text(properties[index].address),
                                        subtitle: Text(CalculatorUtils.getName(
                                            properties[index].calculator)),
                                        trailing: const Icon(
                                            CupertinoIcons.right_chevron),
                                        onTap: () async {
                                          int? id = properties[index].id;
                                          if (id != null) {
                                            Property savedProperty =
                                                await PropertyDatabase.instance
                                                    .readProperty(id);
                                            ref
                                                .read(propertyProvider)
                                                .updateProperty(savedProperty);
                                            if(savedProperty.calculator == Calculator.residentialREI) {
                                              Get.to(() => Location());
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
