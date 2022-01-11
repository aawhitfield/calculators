import 'dart:math';

import 'package:calculators/inputs/quick_max_offer.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/database_utils.dart';
import 'package:calculators/models/saved_calculator.dart';
import 'package:calculators/outputs/fix_flip_statement.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/waiting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      0xFF29abe2,
      0xFF0071bc,
      0xFF003673,
    ];

    void deletePlace(String id, WidgetRef ref) {
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
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection(FirestoreCollections.users)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection(FirestoreCollections.calculators)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Waiting(label: 'Loading saved properties'));
                    }

                    List<SavedCalculator> properties = <SavedCalculator>[];

                    if (snapshot.data != null) {
                      for(DocumentSnapshot<Map<String, dynamic>> document in snapshot.data!.docs) {
                        Map<String, dynamic>? data = document.data();
                        if(data != null) {
                          SavedCalculator newCalculator = SavedCalculator(address: data['address'], calculatorType: data['calculatorType'], uid: document.id);
                          properties.add(newCalculator);
                        }
                      }
                    }


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
                                            deletePlace(
                                                properties[index].uid, ref);
                                        }),
                                        children: [
                                          SlidableAction(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            icon: Icons.archive,
                                            label: 'Delete',
                                            onPressed: (context) {
                                                deletePlace(
                                                    properties[index].uid, ref);
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
                                                deletePlace(
                                                    properties[index].uid, ref);

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
                                                        deletePlace(
                                                            properties[index]
                                                                .uid,
                                                            ref);

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
                                            subtitle:
                                            Text(properties[index].calculatorType),
                                            trailing: const Icon(
                                                CupertinoIcons.right_chevron),
                                            onTap: () async {
                                              ref.read(savedCalculatorProvider).updateAll(properties[index]);

                                              String id = properties[index].uid;
                                              Calculator calculatorType = CalculatorUtils.toType(properties[index].calculatorType);

                                              await DatabaseUtils
                                                        .loadDataByID(id, ref, calculatorType);
                                              ref.read(calculatorProvider).updateCurrentCalculator(calculatorType);
                                                if (calculatorType ==
                                                    Calculator.brrrr) {
                                                  ref.read(brrrrProvider).calculateAll();
                                                  Get.to(() =>
                                                      const Report());
                                                }
                                                else if(calculatorType == Calculator.quickMaxOffer) {
                                                  ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                                                  Get.to(() => const QuickMaxOffer());
                                                }
                                                else if(calculatorType == Calculator.fixAndFlip) {
                                                  ref.read(fixFlipProvider).calculateAll();
                                                  Get.to(() => const FixFlipStatement());
                                                }
                                                else if(calculatorType == Calculator.turnkeyRental) {
                                                  ref.read(turnkeyProvider).calculateAll();
                                                  Get.to(() => const TurnkeyRentalReport());
                                                }
                                              }
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
