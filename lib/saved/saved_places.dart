import 'dart:math';

import 'package:calculators/inputs/location.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/db/database_utils.dart';
import 'package:calculators/providers.dart';
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
      0xFF0059BF,
      0xFF29578A,
      0xFF29abe2 ,
      0xFF3978BF,
      0xFF001E40
    ];

    void deletePlace(int id, WidgetRef ref) {
      DatabaseUtils.deletePlaceByID(id);
      resetAllData(ref);
      setState(() {});
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
              child: FutureBuilder<List<BRRRR>>(
                  future: Future.delayed(const Duration(seconds: 2)), // PropertyDatabase.instance.readAllProperties(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    List<BRRRR> properties =
                        List.from(snapshot.data ?? <BRRRR>[]);

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
                                        dismissible:
                                            DismissiblePane(onDismissed: () {
                                          if (properties[index].id != null) {
                                            deletePlace(
                                                properties[index].id!, ref);
                                          }
                                        }),
                                        children: [
                                          SlidableAction(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            icon: Icons.archive,
                                            label: 'Delete',
                                            onPressed: (context) {
                                              if (properties[index].id !=
                                                  null) {
                                                deletePlace(
                                                    properties[index].id!, ref);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      child: CupertinoContextMenu(
                                        actions: [
                                          CupertinoContextMenuAction(
                                              child: const Material(
                                                child: ListTile(
                                                    title: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    trailing: Icon(
                                                      CupertinoIcons.delete_solid,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            onPressed: () {
                                              if (properties[index].id != null) {
                                                deletePlace(
                                                    properties[index].id!, ref);
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                        child: Material(
                                          child: ListTile(
                                            leading: (isEditing)
                                                ? IconButton(
                                                    icon: const Icon(
                                                        CupertinoIcons
                                                            .minus_circle_fill,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      if (properties[index]
                                                              .id !=
                                                          null) {
                                                        deletePlace(
                                                            properties[index]
                                                                .id!,
                                                            ref);
                                                      }
                                                    },
                                                  )
                                                : Icon(
                                                    Icons.place,
                                                    size: 48,
                                                    color: Color(colors[
                                                        index % colors.length]),
                                                  ),
                                            title:
                                                Text(properties[index].address),
                                            // subtitle:
                                            // Text(
                                            //     CalculatorUtils.getName(
                                            //         properties[index]
                                            //             .type)),
                                            trailing: const Icon(
                                                CupertinoIcons.right_chevron),
                                            onTap: () async {
                                              int? id = properties[index].id;
                                              if (id != null) {
                                                Calculator savedCalculator =
                                                    await DatabaseUtils
                                                        .loadDataByID(id, ref);
                                                if (savedCalculator ==
                                                    Calculator.brrrr ||
                                                  savedCalculator == Calculator.fixAndFlip) {
                                                  Get.to(() =>
                                                      Location(CalculatorUtils.getName(savedCalculator)));
                                                }
                                              }
                                            },
                                          ),
                                        ),
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
